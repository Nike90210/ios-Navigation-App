//
//  PhotoTableViewCell.swift
//  Navigator
//
//  Created by Jazzband on 03.01.2023.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    static let cellID = "cellID"

    lazy var cellLabel = {
        let photoLabel = UILabel()
        photoLabel.text = "Photos"
        photoLabel.textColor = .black
        photoLabel.font = UIFont.boldSystemFont(ofSize: 24)
        photoLabel.translatesAutoresizingMaskIntoConstraints = false
        return photoLabel

    }()

    lazy var arrowImage : UIImageView = {
        let arrowLabel = UIImageView(image: UIImage(systemName: "arrow.forward"))
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false
        return arrowLabel
    }()

    func setImageProperties(image: UIImageView){
        image.layer.cornerRadius = 6
        image.clipsToBounds =  true
        image.translatesAutoresizingMaskIntoConstraints = false
    }

    lazy var firstImage = {
        let firstImage = UIImageView(image: UIImage(named: "1"))
        setImageProperties(image: firstImage)
        return firstImage
    }()

    lazy var secondImage = {
        let SecondImage = UIImageView(image: UIImage(named: "2"))
        setImageProperties(image: SecondImage)
        return SecondImage
    }()

    lazy var thirdImage = {
        let ThirdImage = UIImageView(image: UIImage(named: "3"))
        setImageProperties(image: ThirdImage)
        return ThirdImage
    }()

    lazy var fourthImage = {
        let FourthImage = UIImageView(image: UIImage(named: "4"))
        setImageProperties(image: FourthImage)
        return FourthImage
    }()

    lazy var stackViewsPhotos: UIStackView = {
        let stackImage = UIStackView()
        stackImage.axis = .horizontal
        stackImage.spacing = 8
        stackImage.alignment = .fill
        stackImage.distribution = .fillEqually
        stackImage.translatesAutoresizingMaskIntoConstraints = false

        addViewStack(stack: stackImage, views: [firstImage,
                                                secondImage,
                                                thirdImage,
                                                fourthImage
                                               ])
        return stackImage
    }()

    func addViewStack(stack: UIStackView, views: [UIView]){
        views.forEach{
            stack.addArrangedSubview($0)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(stackViewsPhotos)
        addSubview(cellLabel)
        addSubview(arrowImage)
        setConstrainsForItems()
    }

    func setConstrainsForItems(){
        NSLayoutConstraint.activate([
            cellLabel.topAnchor.constraint(equalTo: topAnchor,constant: 12),
            cellLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),

            arrowImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            arrowImage.centerYAnchor.constraint(equalTo: cellLabel.centerYAnchor),
            arrowImage.heightAnchor.constraint(equalToConstant: 22),
            arrowImage.widthAnchor.constraint(equalToConstant: 22),

            firstImage.widthAnchor.constraint(equalTo: firstImage.heightAnchor),

            stackViewsPhotos.topAnchor.constraint(equalTo: cellLabel.bottomAnchor, constant: 12),
            stackViewsPhotos.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            stackViewsPhotos.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            stackViewsPhotos.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
}
