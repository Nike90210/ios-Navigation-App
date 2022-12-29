//
//  ViewController.swift
//  Navigator
//
//  Created by Jazzband on 26.12.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    var myTableView = UITableView()


    override func viewDidLoad() {
        super.viewDidLoad()

        self.myTableView = UITableView(frame: view.bounds, style: .plain)
        self.myTableView.delegate = self
        view.addSubview(myTableView)


    }
    



}
