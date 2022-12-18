//
//  ProfilViewController.swift
//  Navigator
//
//  Created by Jazzband on 01.12.2022.
//

import UIKit

class ProfilViewController: UIViewController {

    let profileHeader = ProfileheaderView2()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.view.addSubview(profileHeader)
        self.view.addSubview(changeTitleButton)
        profileHeader.translatesAutoresizingMaskIntoConstraints = false
        setConstrains()
        navigationBar()
    }

    func navigationBar(){
        let navigatinBar = UINavigationBarAppearance()
        navigatinBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigatinBar.backgroundColor = .white
        navigationItem.scrollEdgeAppearance = navigatinBar
        title = "Profile"

    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

    }

    var changeTitleButton: UIButton = {

        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Change Title", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 4
        button.layer.shadowOffset.width = 4
        button.layer.shadowOffset.height = 4
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(changeTitle), for: .touchUpInside)
        return button
    }()

    @objc func changeTitle(){

        title = "You have changed title, why?"
    }

    func setConstrains(){
        NSLayoutConstraint.activate([
            changeTitleButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0 ),
            changeTitleButton.heightAnchor.constraint(equalToConstant: 50),
            changeTitleButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            changeTitleButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),

            profileHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeader.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileHeader.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            profileHeader.heightAnchor.constraint(equalToConstant: 220)
        ])
    }

}






