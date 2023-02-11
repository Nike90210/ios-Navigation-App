//
//  TableViewCell.swift
//  Navigator
//
//  Created by Jazzband on 27.12.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    static let id = "PostCellId"

    private lazy var index = 0

    private lazy var switchAction = false

    lazy var postImage: UIImageView = {
        let postImage = UIImageView()
        postImage.frame = frame
        postImage.contentMode = .scaleAspectFill
        postImage.backgroundColor = .black
        postImage.isUserInteractionEnabled = true
        postImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewAction)))
        postImage.translatesAutoresizingMaskIntoConstraints = false
        return postImage
    }()

    lazy var autor: UILabel = {
        let autor = UILabel()
        autor.text = ""
        autor.textColor = .black
        autor.font = UIFont.boldSystemFont(ofSize: 18)
        autor.numberOfLines = 2
        autor.translatesAutoresizingMaskIntoConstraints = false
        return autor
    }()

    lazy var labelDiscription: UILabel = {
        let labelDescription = UILabel()
        labelDescription.textColor = .systemGray
        labelDescription.font = UIFont.systemFont(ofSize: 15)
        labelDescription.numberOfLines = 0
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        return labelDescription
    }()

    lazy var likes: UILabel = {
        let likes = UILabel()
        likes.textColor = .black
        likes.font = UIFont.systemFont(ofSize: 17)
        likes.isUserInteractionEnabled = true
        likes.numberOfLines = 0
        likes.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(likeAction)))
        likes.translatesAutoresizingMaskIntoConstraints = false
        return likes
    }()

    lazy var views: UILabel = {
        let views = UILabel()
        views.textColor = .black
        views.font = UIFont.systemFont(ofSize: 17)
        views.numberOfLines = 0
        views.translatesAutoresizingMaskIntoConstraints = false
        return views
    }()

    @objc func viewAction(){
        guard switchAction else { return }
        Posts.singleton.posts[index].views += 1
        views.text = "Views: \(Posts.singleton.posts[index].views)"
        layoutIfNeeded()
        if let navigationController = ((superview as? UITableView)?.dataSource as? UIViewController)?.navigationController {
            let toFullDetail = FullDetailViewController()
            toFullDetail.index = index
            let navigationControllerPresents = UINavigationController(rootViewController: toFullDetail)
            navigationControllerPresents.modalPresentationStyle = .fullScreen
            navigationControllerPresents.modalTransitionStyle = .crossDissolve
            navigationController.present(navigationControllerPresents, animated: true)
        }
    }

    @objc func likeAction(){
        Posts.singleton.posts[index].likes += 1
        likes.text = "likes: \(Posts.singleton.posts[index].likes)"
        layoutIfNeeded()
    }

    func cellModeToRepresent(post: PostModel, index: Int, switchAction: Bool){
        autor.text = post.autor
        postImage.image = UIImage(named: post.image)
        if switchAction {
            labelDiscription.text = post.shortDescription
        } else {
            labelDiscription.text = post.fullDescription
        }
        likes.text = "Likes: \(Posts.singleton.posts[index].likes)"
        views.text = "Views: \(Posts.singleton.posts[index].views)"
        self.index = index
        self.switchAction = switchAction
    }

    override class func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(postImage)
        addSubview(autor)
        addSubview(labelDiscription)
        addSubview(likes)
        addSubview(views)
        setConstraintsConfiguration()
    }
}

extension TableViewCell {

    func setConstraintsConfiguration(){
        NSLayoutConstraint.activate([
            autor.topAnchor.constraint(equalTo: topAnchor,constant: 16),
            autor.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            postImage.topAnchor.constraint(equalTo: autor.bottomAnchor, constant: 16),
            postImage.heightAnchor.constraint(equalTo: widthAnchor),
            postImage.widthAnchor.constraint(equalTo: widthAnchor),
            postImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelDiscription.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16),
            labelDiscription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            labelDiscription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            likes.topAnchor.constraint(equalTo: labelDiscription.bottomAnchor, constant: 16),
            likes.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            likes.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -16),
            views.topAnchor.constraint(equalTo: labelDiscription.bottomAnchor, constant: 16),
            views.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)

        ])
    }
}
