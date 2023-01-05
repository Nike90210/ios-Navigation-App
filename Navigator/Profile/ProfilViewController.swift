//
//  ProfilViewController.swift
//  Navigator
//
//  Created by Jazzband on 01.12.2022.
//

import UIKit

class ProfilViewController: UIViewController {

    let navigationBar = UINavigationBar()

    // Создание таблицы и массива с типом данных структуры с данными
    var tableView = UITableView(frame: .zero, style: .grouped)
    var headrView: UIView = ProfileHeaderView()
    var dataSourses: [PostModel] = []

    // Идентификатор для метода cellForRowAt dequeueReusableCell
    struct Cells {
        static let TableViewCell = "tableViewCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setConfiguration()
        setConstrains()
        dataSourses = dataSourceFromModel()
        navigationController?.navigationBar.backgroundColor = .white
        navigationBar.isHidden  = true
    }

    // привязка делегата и dataSource к таблице и регистрация кастомной ячейки с идентификатором
    func setConfiguration(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: Cells.TableViewCell)
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.idForHeader)
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.cellID)
    }

    // создание констрейнтов для таблицы на экране
    private func setConstrains(){

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            tableView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor),
            tableView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor)
        ])
    }
}

extension ProfilViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        return ProfileHeaderView()
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
}





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


