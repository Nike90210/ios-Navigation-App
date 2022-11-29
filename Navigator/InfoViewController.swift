//
//  InfoViewController.swift
//  Navigator
//
//  Created by Jazzband on 29.11.2022.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(button)
        self.view.backgroundColor = .darkGray


    }
    

    var button : UIButton{
        let button = UIButton(frame: CGRect(x: 165, y: 400, width: 100,height: 40))

        button.setTitle("Info", for: .normal)
        button.setTitleColor(.black,for: .normal)
        button.layer.backgroundColor = UIColor.white.cgColor
        button.layer.cornerRadius = 10
        button.addTarget(self,action: #selector(alert),  for: .touchUpInside)
        return button
        
    }

    @objc func alert (){

        let alertController = UIAlertController(title: "Alert", message: "Error", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ok", style: .default){_ in alertController.dismiss(animated: true)})
        alertController.addAction(UIAlertAction(title: "cancel", style: .cancel){_ in alertController.dismiss(animated: true)})

        self.present(alertController,animated: true)

    }


}
