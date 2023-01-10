//
//  ProfilViewController.swift
//  Navigator
//
//  Created by Jazzband on 01.12.2022.
//

import UIKit

class ProfilViewController: UIViewController {


    // Идентификатор для метода cellForRowAt dequeueReusableCell
    struct Cells {
        static let TableViewCell = "tableViewCell"
    }

    // MARK: - Переменные

    // Переменные для перерисовки констрейнтов при анимации картинки аватарки
    var topAvatar: NSLayoutConstraint!

    var leadingAvatar: NSLayoutConstraint!

    var avatarWidth: NSLayoutConstraint!

    var avatarHeight: NSLayoutConstraint!

    var avatarCenterX: NSLayoutConstraint!

    var avatarCenterY: NSLayoutConstraint!

    var isCenter: Bool = false


    // Создание таблицы и массива с типом данных структуры с данными
    var tableView = UITableView(frame: .zero, style: .grouped)
    var headrView: UIView = ProfileHeaderView()
    var dataSourses: [PostModel] = []

    // Создаю аватарка по верх хэдер аватарки и анимация
    lazy var avatarImage: UIImageView = {
        let avatarImage = UIImageView(image: UIImage(named: "Dragon Expansion"))
        avatarImage.layer.cornerRadius = 65
        avatarImage.clipsToBounds = true
        avatarImage.layer.borderColor = UIColor.white.cgColor
        avatarImage.layer.borderWidth = 3
        avatarImage.isUserInteractionEnabled = true
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAvatar)))
        return avatarImage
    }()

    // Создаем View с экземпляром на Хэдер и добавляем в этот экземпляр картинку, так как картинку из Хэдэр удалили. Прикрепляем констрейнты как они были сделаны в Хэдер до удаления.
    private lazy var headerView: UIView = {
        let headerView = ProfileHeaderView()
        headerView.addSubview(avatarImage)

        topAvatar = avatarImage.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 16)
        topAvatar.isActive = true

        leadingAvatar = avatarImage.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16)
        leadingAvatar.isActive = true

        avatarWidth = avatarImage.widthAnchor.constraint(equalToConstant: 130)
        avatarWidth.isActive = true

        avatarHeight = avatarImage.heightAnchor.constraint(equalToConstant: 130)
        avatarHeight.isActive = true
        return headerView
    }()

    // Создаем фоновое View с прозрчностью
    var phonView: UIView = {
        let phonView = UIView()
        phonView.backgroundColor = UIColor(white: 1, alpha: 0)
        phonView.translatesAutoresizingMaskIntoConstraints = false
        return phonView
    }()

    // Создаем кнопку для возврата картинки в прежнее состояние на позицию хэдер с анимацией, добавляя на кнопку метод
    var escapeImageButton: UIButton = {
        let escapeButton = UIButton()
        escapeButton.setImage(UIImage(systemName: "delete.backward.fill"), for: .normal)
        escapeButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        escapeButton.translatesAutoresizingMaskIntoConstraints = false
        return escapeButton
    }()

    //MARK: -  Методы

    // привязка делегата и dataSource к таблице и регистрация кастомной ячейки с идентификатором
    func setConfiguration(){
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(phonView)
        phonView.isHidden = true

        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0.2
        tableView.register(TableViewCell.self, forCellReuseIdentifier: Cells.TableViewCell)
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.cellID)
    }

    // создание констрейнтов для таблицы на экране
    private func setConstrains(){

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            tableView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor),
            tableView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),
            phonView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            phonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            phonView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            phonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    // ObjectiveC метод который вызывает кнопка при нажатии что бы картинка вернулась обратно на позицию с анимацией.
    @objc func buttonPressed(){

        avatarCenterX.isActive = false
        avatarCenterY.isActive = false
        avatarWidth.isActive = false
        avatarHeight.isActive = false

        avatarWidth = avatarImage.widthAnchor.constraint(equalToConstant: 130)
        avatarWidth.isActive = true

        avatarHeight = avatarImage.heightAnchor.constraint(equalToConstant: 130)
        avatarHeight.isActive = true

        topAvatar.isActive = true
        leadingAvatar.isActive = true

        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.view.layoutIfNeeded()
            self.phonView.backgroundColor = UIColor(white: 1, alpha: 0)
            self.avatarImage.layer.cornerRadius = 65
        }) {_ in

            self.headerView.addSubview(self.avatarImage)
            self.topAvatar.isActive = false
            self.leadingAvatar.isActive = false
            self.topAvatar.isActive = true
            self.leadingAvatar.isActive = true
            self.view.layoutIfNeeded()
            self.phonView.isHidden = true
        }
    }

    // метод objectivC вызывается по тапу на картинку : картинка анимируется выходит на передний план и появляется кнопка на фоновом изображении, сам фон становится пррзрачным. Картинка анимируется благодаря отрисовки констрейнтов высоты и ширины через метод layoutIfNeeded

    @objc func tapAvatar(_ UIGesture: UIGestureRecognizer){

        view.addSubview(avatarImage)
        topAvatar.isActive = true
        leadingAvatar.isActive = true
        self.view.layoutIfNeeded()

        avatarHeight.isActive = true
        phonView.isHidden = false
        phonView.addSubview(escapeImageButton)
        escapeImageButton.alpha = 0
        constrainsAfterAnimation()

        UIView.animate(withDuration: 1, delay: 0.7, animations: {
            self.phonView.backgroundColor = UIColor(white: 1, alpha: 0)
            self.view.layoutIfNeeded()
            self.escapeImageButton.alpha = 2
            self.avatarImage.layer.cornerRadius = 0
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setConfiguration()
        setConstrains()
        dataSourses = dataSourceFromModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

// MARK: - Extensions
// расширение для TableView
extension ProfilViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        return headerView
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            return dataSourses.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.cellID, for: indexPath)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: Cells.TableViewCell) as! TableViewCell
            let images = dataSourses[indexPath.row]
            cell.set(post: images)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            let vc = PhotosViewController()
            navigationController?.pushViewController(vc, animated: true)
        }

    }
}

// задаем данные для отображение из созданной отдельно структуры
extension ProfilViewController{

    func dataSourceFromModel() -> [PostModel]{
        let post1 = PostModel(autor: "CDProject",
                              description: "a bad game",
                              image: UIImage(named: "ciberPunk")!,
                              likes: "Likes: 11",
                              views: "Views: 24")
        let post2 = PostModel(autor: "NationalGeographic",
                              description: "winter forest in North America",
                              image: UIImage(named: "winterHouse")!,
                              likes: "Likes: 12",
                              views: "Views: 124")
        let post3 = PostModel(autor: "CCP Games",
                              description: "Explore a deeper sapce with new ships",
                              image:UIImage(named: "Eve")!,
                              likes: "Likes: 122",
                              views: "Views: 1241")
        let post4 = PostModel(autor: "NationalGeographic",
                              description: "We found this admirable raod withing a red forest on the outskirt of  the Easten Ireland",
                              image: UIImage(named: "dorogaRed")!,
                              likes: "Likes: 938",
                              views: "Views: 924")

        return [post1, post2, post3, post4]
    }

    // отрисовываем констрейнты перед началом анимации картинки на передний план
    private func constrainsBeforeAnimation() {
        topAvatar.isActive = true
        leadingAvatar.isActive = true
        escapeImageButton.topAnchor.constraint(equalTo: phonView.topAnchor, constant: 16).isActive = true
        escapeImageButton.trailingAnchor.constraint(equalTo: phonView.trailingAnchor, constant: -16).isActive = true
        view.layoutIfNeeded()
    }

    // отрисовывваем констрейнты после анимации
    private func constrainsAfterAnimation() {
        topAvatar.isActive = false
        leadingAvatar.isActive = false
        avatarWidth.isActive = false
        avatarHeight.isActive = false

        avatarCenterX = avatarImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        avatarCenterX.isActive = true

        avatarCenterY = avatarImage.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        avatarCenterY.isActive = true

        avatarWidth = avatarImage.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
        avatarWidth.isActive = true

        avatarHeight = avatarImage.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
        avatarHeight.isActive = true
    }
}

//MARK: - Old code for reference

//    var dataSourceFromModel: [PostModel]{
//        let models = [
//            PostModel(autor: "CDProject",
//                      description: "this game was created for a shame",
//                      image: "cyberPunk",
//                      likes: 452,
//                      views: 600),
//            PostModel(autor: " NagionalGeorgrapgics",
//                      description: "We found this road on the way to a old city of irland",
//                      image: "dorogaRed",
//                      likes: 5000,
//                      views: 10456),
//            PostModel(autor: "CCP Games",
//                      description: "descover hollow of the deepr space",
//                      image: "Eve",
//                      likes: 224,
//                      views: 436),
//            PostModel(autor: "Netional Georraphic",
//                      description: "a lonely house in the forbiden forest in the nothe of Canade",
//                      image: "winterHouse",
//                      likes: 973,
//                      views: 943)
//        ]
//        return dataSourceFromModel
//    }






//    let profileHeader = ProfileHeaderView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.backgroundColor = .lightGray
//        self.view.addSubview(profileHeader)
//        self.view.addSubview(changeTitleButton)
//        profileHeader.translatesAutoresizingMaskIntoConstraints = false
//        setConstrains()
//        navigationBar()
//    }
//
//    func navigationBar(){
//        let navigatinBar = UINavigationBarAppearance()
//        navigatinBar.titleTextAttributes = [.foregroundColor: UIColor.black]
//        navigatinBar.backgroundColor = .white
//        navigationItem.scrollEdgeAppearance = navigatinBar
//        title = "Profile"
//
//    }
//
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//
//    }
//
//    var changeTitleButton: UIButton = {
//
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Change Title", for: .normal)
//        button.setTitleColor(UIColor.white, for: .normal)
//        button.backgroundColor = .black
//        button.layer.cornerRadius = 4
//        button.layer.shadowOffset.width = 4
//        button.layer.shadowOffset.height = 4
//        button.layer.shadowRadius = 4
//        button.layer.shadowColor = UIColor.black.cgColor
//        button.layer.shadowOpacity = 0.7
//        button.addTarget(self, action: #selector(changeTitle), for: .touchUpInside)
//        return button
//    }()
//
//    @objc func changeTitle(){
//
//        title = "You have changed title, why?"
//    }
//
//    func setConstrains(){
//        NSLayoutConstraint.activate([
//            changeTitleButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0 ),
//            changeTitleButton.heightAnchor.constraint(equalToConstant: 50),
//            changeTitleButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
//            changeTitleButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
//
//            profileHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            profileHeader.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            profileHeader.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            profileHeader.heightAnchor.constraint(equalToConstant: 220)
//        ])
//    }


