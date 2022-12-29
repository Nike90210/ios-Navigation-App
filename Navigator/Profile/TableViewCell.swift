//
//  TableViewCell.swift
//  Navigator
//
//  Created by Jazzband on 27.12.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    // Создание элементов для ячейки
    var uiImage = UIImageView()
    var autor = UILabel()
    var labelDescription = UILabel()
    var likes = UILabel()
    var views = UILabel()
 

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(uiImage)
        addSubview(autor)
        addSubview(labelDescription)
        addSubview(likes)
        addSubview(views)

        setImageConfiguration()
        setLabelsConfiguration()
        setConstraintsConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // метод для отображения элементов в ячеках в методе CellForRowAt
    func set(post: PostModel){
        autor.text = post.autor
        labelDescription.text = post.description
        uiImage.image = post.image
        likes.text = post.likes
        views.text = post.views
    
    }

    // Конфигурация для картинки
    func setImageConfiguration (){
        uiImage.contentMode = .scaleAspectFit
        uiImage.backgroundColor = .black
  
    }

    // настройка для Лэйблов
    func setLabelsConfiguration(){
        autor.numberOfLines = 0
        autor.adjustsFontSizeToFitWidth = true

        labelDescription.numberOfLines = 0
        labelDescription.adjustsFontSizeToFitWidth = true

        likes.numberOfLines = 0
        likes.adjustsFontSizeToFitWidth = true

        views.numberOfLines = 0
        views.adjustsFontSizeToFitWidth = true
    }


// создание констрейнтов
    func setConstraintsConfiguration(){



        autor.translatesAutoresizingMaskIntoConstraints = false
        uiImage.translatesAutoresizingMaskIntoConstraints = false
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        likes.translatesAutoresizingMaskIntoConstraints = false
        views.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([


            autor.topAnchor.constraint(equalTo: topAnchor,constant: 16),
            autor.leadingAnchor.constraint(equalTo: leadingAnchor),

            uiImage.topAnchor.constraint(equalTo: autor.bottomAnchor, constant: 16),
            uiImage.heightAnchor.constraint(equalTo: widthAnchor),
            uiImage.widthAnchor.constraint(equalTo: widthAnchor),
            uiImage.centerXAnchor.constraint(equalTo: centerXAnchor),

            labelDescription.topAnchor.constraint(equalTo: uiImage.bottomAnchor, constant: 16),
            labelDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            labelDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            likes.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 16),
            likes.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            likes.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -16),

            views.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 16),
            views.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)

        ])
    }

}
