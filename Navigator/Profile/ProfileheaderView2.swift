//
//  ProfileheaderView2.swift
//  Navigator
//
//  Created by Jazzband on 16.12.2022.
//

import UIKit

class ProfileheaderView2: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        subViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }




    func subViews (){
        let safeArea = safeAreaLayoutGuide

        let imageView: UIImageView = {
            let imageView = UIImageView(image: UIImage(named: "Dragon Expansion"))
            imageView.layer.cornerRadius = 65
            imageView.clipsToBounds = true
            imageView.layer.borderColor = UIColor.white.cgColor
            imageView.layer.borderWidth = 3
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()

        let fulNamelabel = UILabel()
        fulNamelabel.translatesAutoresizingMaskIntoConstraints = false
        fulNamelabel.backgroundColor = .lightGray
        fulNamelabel.text = "Magic of knowledge"
        fulNamelabel.textColor = .black
        fulNamelabel.font = UIFont.boldSystemFont(ofSize: 18)

        let statusLabel = UILabel()
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.backgroundColor = .lightGray
        statusLabel.text = "what you want to know?"
        statusLabel.textColor = .black
        statusLabel.font = UIFont(name: "Regular", size: 10)

        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show status", for: .normal)
        button.addAction(UIAction{_ in
           print( statusLabel.text ?? "" )
        }, for: .touchUpInside)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset.width = 4
        button.layer.shadowOffset.height = 4
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7


        let statusTexField = UITextField()
        statusTexField.translatesAutoresizingMaskIntoConstraints = false
        statusTexField.textColor = .black
        statusTexField.backgroundColor = .white
        statusTexField.clipsToBounds = true
        statusTexField.layer.borderColor = UIColor.blue.cgColor
        statusTexField.layer.borderWidth = 1
        statusTexField.layer.cornerRadius = 6

        addSubview(fulNamelabel)
        addSubview(statusLabel)
        addSubview(button)
        addSubview(statusTexField)
        addSubview(imageView)

        NSLayoutConstraint.activate([
            fulNamelabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50),
            fulNamelabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),

            statusLabel.topAnchor.constraint(equalTo: fulNamelabel.bottomAnchor, constant: 40),
            statusLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,constant: 16),

            statusTexField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 10),
            statusTexField.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            statusTexField.heightAnchor.constraint(equalToConstant: 40),
            statusTexField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),

            button.topAnchor.constraint(equalTo: statusTexField.bottomAnchor, constant: 16),
            button.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 50),

            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            imageView.heightAnchor.constraint(equalToConstant: 130),
            imageView.widthAnchor.constraint(equalToConstant: 130)

        ])
    }

}

