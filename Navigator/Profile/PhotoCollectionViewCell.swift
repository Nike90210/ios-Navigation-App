//
//  PhotoCollectionViewCell.swift
//  Navigator
//
//  Created by Jazzband on 04.01.2023.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    static let id = "photoid"

    lazy var PhotoName: String = ""

    lazy var PhotoView: UIImageView = {
        let PhotoView = UIImageView(image: UIImage(named: PhotoName))
        PhotoView.frame = frame
        PhotoView.translatesAutoresizingMaskIntoConstraints = false
        return PhotoView
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(PhotoView)
        setConstrains()
    }

}

extension PhotoCollectionViewCell {

    private func setConstrains() {
        NSLayoutConstraint.activate([
            PhotoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            PhotoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            PhotoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            PhotoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

}



