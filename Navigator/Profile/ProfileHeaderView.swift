//
//import UIKit
//
//class ProfileHeaderView: UIView {
//
//
//            var imageForProfile: UIView = {
//
//                let imageView = UIView(frame: CGRect(x: 30, y: 120, width: 130, height: 130))
//                imageView.layer.cornerRadius = imageView.frame.width / 2
//                imageView.clipsToBounds = true
//                imageView.layer.borderColor = UIColor.white.cgColor
//                imageView.layer.borderWidth = 3
//
//                let imageLair = CALayer()
//                let imageForAvatar = UIImage(named: "Dragon Expansion")?.cgImage
//                imageLair.frame = CGRect(x: 0, y: 0, width: 130, height: 130)
//                imageLair.contents = imageForAvatar
//                imageView.layer.addSublayer(imageLair)
//
//                return imageView
//            }()
//
//            var label: UILabel{
//
//                let label = UILabel(frame: CGRect(x: 180, y: 190, width: 180, height: 40))
//                label.text = "New Features"
//                label.textColor = .systemGray
//                label.font = UIFont(name: "Regular", size: 14)
//                label.backgroundColor = .lightGray
//
//                return label
//            }
//
//        var labelStatus: UILabel  {
//
//            let label = UILabel(frame: .zero)
//            label.text = "it's about time"
//            label.textColor = .black
//            label.font = UIFont.boldSystemFont(ofSize: 18)
//            label.backgroundColor = .lightGray
//
//            return label
//        }
//
//
//            var button: UIButton{
//
//                let button = UIButton(frame: CGRect(x: 30, y: 260, width: 330, height: 50))
//                button.setTitle("show status", for: .normal)
//                button.setTitleColor(UIColor.white, for: .normal)
//                button.backgroundColor = .blue
//                button.layer.cornerRadius = 4
//                button.layer.shadowOffset.width = 4
//                button.layer.shadowOffset.height = 4
//                button.layer.shadowRadius = 4
//                button.layer.shadowColor = UIColor.black.cgColor
//                button.layer.shadowOpacity = 0.7
//                button.addTarget(self, action: #selector(showStatus), for: .touchUpInside)
//
//                return button
//            }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        subViews()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//    private func subViews(){
//
//        setConstrains()
//        //                addSubview(label)
//        //                addSubview(imageForProfile)
//    }
//
//    //        @objc func showStatus(){
//    //
//    //            print(label.text ?? "")
//    //
//    //        }
//
//}
//
//
//extension ProfileHeaderView{
//
//    func setConstrains(){
//
//        let labelStatus = UILabel(frame: .zero)
//        labelStatus.translatesAutoresizingMaskIntoConstraints = false
//        labelStatus.text = "it's about time"
//        labelStatus.textColor = .black
//        labelStatus.font = UIFont.boldSystemFont(ofSize: 18)
//        labelStatus.backgroundColor = .lightGray
//
//        let safeArea = safeAreaLayoutGuide
//        addSubview(labelStatus)
//
//        NSLayoutConstraint.activate([
//            labelStatus.topAnchor.constraint(equalTo: safeArea.topAnchor,constant: 30),
//            labelStatus.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 40),
//            labelStatus.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 40),
//            labelStatus.heightAnchor.constraint(equalToConstant: 40)
//        ])
//    }
//}
//
