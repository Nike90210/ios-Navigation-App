

import UIKit

class LogInViewController: UIViewController {


    var scrollView: UIScrollView!

    let navigationBar = UINavigationBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        layoutElements()
        navigationBar.isHidden = true

    }

    func layoutElements(){

        let loginImage: UIImageView = {
            let loginImage = UIImageView(image: UIImage(named: "logo"))
            loginImage.layer.cornerRadius = 10
            loginImage.clipsToBounds = true
            loginImage.translatesAutoresizingMaskIntoConstraints = false
            return loginImage
        }()



        let loginTextField: UITextField = {
            let logingTextField = UITextField()
            logingTextField.placeholder = "Email or phone"
            logingTextField.font = UIFont.systemFont(ofSize: 16)
            logingTextField.layer.cornerRadius = 10
            logingTextField.layer.backgroundColor = UIColor.systemGray6.cgColor
            logingTextField.textColor = .black
            logingTextField.tintColor = UIColor(named: "MyColor")
            logingTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: logingTextField.frame.height))
            logingTextField.leftViewMode = .always
            logingTextField.layer.borderColor = UIColor.lightGray.cgColor
            logingTextField.layer.borderWidth = 0.5
            logingTextField.autocapitalizationType = .none

            logingTextField.translatesAutoresizingMaskIntoConstraints = false
            return logingTextField
        }()



        let passwordTextField: UITextField = {
            let passwordTextField = UITextField()
            passwordTextField.placeholder = "Password"
            passwordTextField.font = UIFont.systemFont(ofSize: 16)
            passwordTextField.layer.cornerRadius = 10
            passwordTextField.layer.backgroundColor = UIColor.systemGray6.cgColor
            passwordTextField.textColor = .black
            passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
            passwordTextField.tintColor = UIColor(named: "MyColor")
            passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passwordTextField.frame.height))
            passwordTextField.leftViewMode = .always
            passwordTextField.layer.borderWidth = 0.5
            passwordTextField.autocapitalizationType = .none
            passwordTextField.isSecureTextEntry = true
            passwordTextField.translatesAutoresizingMaskIntoConstraints = false
            return passwordTextField
        }()




        let logingButton = UIButton()

        if let buttonImage = UIImage(named: "blue_pixel"){
            logingButton.setBackgroundImage(buttonImage, for: .normal)
            logingButton.setBackgroundImage(buttonImage.drawImage(alpha: 0.8), for: .selected)
            logingButton.setBackgroundImage(buttonImage.drawImage(alpha: 0.8), for: .highlighted)
            logingButton.setBackgroundImage(buttonImage.drawImage(alpha: 0.8), for: .disabled)
        }else{
            logingButton.backgroundColor = .blue
        }

        logingButton.setTitleColor(UIColor.white, for: .normal)
        logingButton.setTitle("Log in", for: .normal)
        logingButton.clipsToBounds = true
        logingButton.layer.cornerRadius = 10
        logingButton.translatesAutoresizingMaskIntoConstraints = false
        logingButton.addAction(UIAction{_ in
            let profileView = ProfilViewController()
            self.navigationController?.pushViewController(profileView, animated: true)
        }, for: .touchUpInside)


        self.scrollView  = UIScrollView()
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 900)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.keyboardDismissMode = .interactive
        self.view.addSubview(scrollView)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(loginImage)
        scrollView.addSubview(loginTextField)
        scrollView.addSubview(logingButton)

        NSLayoutConstraint.activate([

            self.scrollView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor),
            self.scrollView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),
            self.scrollView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.scrollView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),

            loginImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            loginImage.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: -170),
            loginImage.heightAnchor.constraint(equalToConstant: 100),
            loginImage.widthAnchor.constraint(equalToConstant: 100),

            loginTextField.topAnchor.constraint(equalTo: loginImage.bottomAnchor, constant: 120),
            loginTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            loginTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16 ),
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
           //loginTextField.widthAnchor.constraint(equalToConstant: 360),

            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 0),
            passwordTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
           // passwordTextField.widthAnchor.constraint(equalToConstant: 360),


            logingButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            logingButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            logingButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            logingButton.heightAnchor.constraint(equalToConstant: 50)
            //logingButton.widthAnchor.constraint(equalToConstant: 360)
        ])
    }

    func subscribeKeaboardEvent(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardwWiilShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardwWiilShow(_ notification: NSNotification){
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)? .cgRectValue else {return}
        self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height - self.view.safeAreaInsets.bottom + 70, right: 0)
    }

    @objc func keyboardWillHide(_ notification: NSNotification){
        self.scrollView.contentInset = .zero
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeKeaboardEvent()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}

extension UIImage{

    func drawImage(alpha: CGFloat) -> UIImage?{
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetImageFromCurrentImageContext()
        return newImage
    }
}
