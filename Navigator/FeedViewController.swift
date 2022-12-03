

import UIKit

class FeedViewController: UIViewController {

    let post = Post(title: "New Photo")



    override func viewDidLoad() {

        super.viewDidLoad()
        self.view.addSubview(button)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .done, target: self, action: #selector(toInfoController))
        self.view.backgroundColor = .systemPurple
        navigationBar()
    }


    var button: UIButton{

        let button = UIButton(frame: CGRect(x: 165, y: 400, width: 70,height: 40))

        button.setTitle("Post", for: .normal)
        button.setTitleColor(.black,for: .normal)
        button.layer.backgroundColor = UIColor.white.cgColor
        button.layer.cornerRadius = 10
        button.addTarget(self,action: #selector(buttonAction),  for: .touchUpInside)
        return button
    }

    @objc func buttonAction() {
        let postVC = PostController()
        self.navigationController?.pushViewController(postVC, animated: true)
        postVC.title = post.title
    }

    @objc func toInfoController(){
        let infoVC = InfoViewController()
       self.navigationController?.pushViewController(infoVC, animated: true)
    }


    func navigationBar(){
        let navigationBar = UINavigationBarAppearance()
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationBar.backgroundColor = .white
        navigationItem.scrollEdgeAppearance = navigationBar
        title = "Feed"
    }


}







