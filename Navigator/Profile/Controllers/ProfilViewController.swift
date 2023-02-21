//
//  ProfilViewController.swift
//  Navigator
//
//  Created by Jazzband on 01.12.2022.
//

import UIKit

class ProfilViewController: UIViewController {

    private var posts: [PostModel] = Posts.singleton.posts
    // Идентификатор для метода cellForRowAt dequeueReusableCell

    // Переменные для перерисовки констрейнтов при анимации картинки аватарки
    var avatarImageTop: NSLayoutConstraint!

    var avatarImageLeading: NSLayoutConstraint!

    var avatarImageWidth: NSLayoutConstraint!

    var avatarImageHeight: NSLayoutConstraint!

    var avatarImageCenterX: NSLayoutConstraint!

    var avatarImageCenterY: NSLayoutConstraint!

    var isVatarInViewCenter: Bool = false


    // Создание таблицы и массива с типом данных структуры с данными

    var headrView: UIView = ProfileHeaderView()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0.4
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.id)
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.cellID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

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

        avatarImageTop = avatarImage.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 16)
        avatarImageTop.isActive = true

        avatarImageLeading = avatarImage.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16)
        avatarImageLeading.isActive = true

        avatarImageWidth = avatarImage.widthAnchor.constraint(equalToConstant: 130)
        avatarImageWidth.isActive = true

        avatarImageHeight = avatarImage.heightAnchor.constraint(equalToConstant: 130)
        avatarImageHeight.isActive = true
        return headerView
    }()

    // Создаем фоновое View с прозрчностью
    lazy var phonView: UIView = {
        let phonView = UIView()
        phonView.backgroundColor = UIColor(white: 1, alpha: 0)
        phonView.translatesAutoresizingMaskIntoConstraints = false
        return phonView
    }()

    // Создаем кнопку для возврата картинки в прежнее состояние на позицию хэдер с анимацией, добавляя на кнопку метод
   lazy  var escapeImageButton: UIButton = {
        let escapeButton = UIButton()
        escapeButton.setImage(UIImage(systemName: "delete.backward.fill"), for: .normal)
        escapeButton.addTarget(self, action: #selector(EscapeButtonPressed), for: .touchUpInside)
        escapeButton.translatesAutoresizingMaskIntoConstraints = false
        return escapeButton
    }()

    //MARK: -  Методы

    private func setConstrains(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.reloadData()
        setConstrains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
            return posts.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.cellID, for: indexPath) as! PhotoTableViewCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id, for: indexPath) as! TableViewCell
            cell.cellModeToRepresent(post: posts[indexPath.item], index: indexPath.item, switchAction: true)
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

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.section == 1 {
            return .delete
        }
        return .none
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        posts.remove(at: indexPath.item)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        self.tableView.reloadData()
    }

}

extension ProfilViewController{

    // отрисовываем констрейнты перед началом анимации картинки на передний план

    @objc func EscapeButtonPressed(){
        avatarImageCenterX.isActive = false
        avatarImageCenterY.isActive = false
        avatarImageWidth.isActive = false
        avatarImageHeight.isActive = false
        avatarImageWidth = avatarImage.widthAnchor.constraint(equalToConstant: 130)
        avatarImageWidth.isActive = true
        avatarImageHeight = avatarImage.heightAnchor.constraint(equalToConstant: 130)
        avatarImageTop.isActive = true
        avatarImageLeading.isActive = true
        avatarImageHeight.isActive = true
        avatarImageWidth.isActive = true
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.phonView.backgroundColor = UIColor(white: 1, alpha: 0)
            self.view.layoutIfNeeded()
            self.avatarImage.layer.cornerRadius = 65
        }) {_ in
            self.phonView.isHidden = true
            self.headerView.addSubview(self.avatarImage)
            self.avatarImageTop.isActive = false
            self.avatarImageLeading.isActive = false
            self.avatarImageTop.isActive = true
            self.avatarImageLeading.isActive = true
            self.view.layoutIfNeeded()
            self.isVatarInViewCenter = false
        }
    }

    @objc func tapAvatar(_ UIGesture: UIGestureRecognizer){
        guard isVatarInViewCenter == false else { return }
        isVatarInViewCenter = true
        view.addSubview(phonView)
        view.addSubview(avatarImage)
        self.phonView.addSubview(escapeImageButton)
        self.phonView.isHidden = false
        escapeImageButton.alpha = 0
        constrainsBeforeAnimation()
        constrainsAfterAnimation()
        phonView.bringSubviewToFront(avatarImage)
        UIView.animate(withDuration: 1, delay: 0.7, animations: {
            self.phonView.backgroundColor = UIColor(white: 1, alpha: 0.7)
            self.view.layoutIfNeeded()
            self.avatarImage.layer.cornerRadius = 4
        })
        UIView.animate(withDuration: 0.5, delay: 1, animations: {
            self.escapeImageButton.alpha = 2
        })
    }

    private func constrainsBeforeAnimation() {
        phonView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        phonView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        phonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        phonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        avatarImageTop.isActive = true
        avatarImageLeading.isActive = true
        escapeImageButton.topAnchor.constraint(equalTo: phonView.topAnchor, constant: 16).isActive = true
        escapeImageButton.trailingAnchor.constraint(equalTo: phonView.trailingAnchor, constant: -16).isActive = true
        view.layoutIfNeeded()
    }

    // отрисовывваем констрейнты после анимации
    private func constrainsAfterAnimation() {
        avatarImageTop.isActive = false
        avatarImageLeading.isActive = false
        avatarImageWidth.isActive = false
        avatarImageHeight.isActive = false

        avatarImageCenterX = avatarImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        avatarImageCenterX.isActive = true

        avatarImageCenterY = avatarImage.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        avatarImageCenterY.isActive = true

        avatarImageWidth = avatarImage.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
        avatarImageWidth.isActive = true

        avatarImageHeight = avatarImage.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
        avatarImageHeight.isActive = true
    }
}




