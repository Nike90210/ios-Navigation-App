//
//  PostController.swift
//  Navigator
//
//  Created by Jazzband on 27.11.2022.
//

import UIKit

class PostController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        navigationController?.viewControllers.forEach{ vc in print(vc.self)}

    }
    

}


struct Post {

var title: String
    
}
