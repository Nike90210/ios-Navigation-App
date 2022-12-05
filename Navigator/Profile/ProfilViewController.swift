//
//  ProfilViewController.swift
//  Navigator
//
//  Created by Jazzband on 01.12.2022.
//

import UIKit

class ProfilViewController: UIViewController {

    let profileHeader = ProfileHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .lightGray
        self.view.addSubview(profileHeader)
        self.view.addSubview(profileHeader.button)
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

}
