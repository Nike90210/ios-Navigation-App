

import UIKit

class LogInViewController: UIViewController {

    var loginTextFieldConstraintsLeading: NSLayoutConstraint!
    var loginTextFieldConstrainstTrailing: NSLayoutConstraint!
    var passwordTextFieldConstraintsLeading: NSLayoutConstraint!
    var paswordTextFieldConstrainstTrailing: NSLayoutConstraint!

    lazy var loginTextField: UITextField = {
        let logingTextField = UITextField(frame: .zero)
        logingTextField.placeholder = "Email or phone"

        standartSettingsForTextFields(textFields: logingTextField)

        loginTextFieldConstraintsLeading = logingTextField.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        loginTextFieldConstrainstTrailing = logingTextField.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        return logingTextField
    }()

    lazy var  passwordTextField: UITextField = {
        let passwordTextField = UITextField(frame: .zero)
        passwordTextField.placeholder = "Password"
        passwordTextField.tintColor = UIColor(named: "MyColor")
        passwordTextField.layer.borderWidth = 0.5
        standartSettingsForTextFields(textFields: passwordTextField)
        passwordTextFieldConstraintsLeading = passwordTextField.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        paswordTextFieldConstrainstTrailing = passwordTextField.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        return passwordTextField
    }()

    lazy var loginButton: UIButton = {
        var config = UIButton.Configuration.filled()
        if let buttonImage = UIImage(named: "blue_pixel"){
            config.baseBackgroundColor = UIColor(patternImage: buttonImage)
        }else{
            config.baseBackgroundColor = UIColor.systemBlue
        }
        config.title = "Log In"
        var logingB = UIButton(configuration: config, primaryAction: nil)
        logingB.layer.cornerRadius = 10
        logingB.translatesAutoresizingMaskIntoConstraints = false
        logingB.configurationUpdateHandler = { button in
            switch button.state {
            case .selected, .highlighted, .disabled: button.alpha = 0.6
            default:
                button.alpha = 1
            }
        }
        logingB.addTarget(self, action: #selector(logingActionButton), for: .touchUpInside)
        return logingB
    }()

    lazy var scrollView: UIScrollView = {
        let scrollView  = UIScrollView()
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 900)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    lazy var loginImage: UIImageView = {
        let loginImage = UIImageView(image: UIImage(named: "logo"))
        loginImage.layer.cornerRadius = 10
        loginImage.clipsToBounds = true
        loginImage.translatesAutoresizingMaskIntoConstraints = false
        return loginImage
    }()

    lazy var errorPasswordNotification: UILabel = {
        let errorPasswordNotification = UILabel()
        errorPasswordNotification.text = "Incorrect password"
        errorPasswordNotification.font = UIFont(name: "regular", size: 9)
        errorPasswordNotification.textColor = .red
        errorPasswordNotification.isHidden = true
        errorPasswordNotification.translatesAutoresizingMaskIntoConstraints = false
        return errorPasswordNotification
    }()

    func standartSettingsForTextFields(textFields: UITextField) {
        textFields.backgroundColor = .systemGray6
        textFields.tintColor = UIColor(named: "MyColor")
        textFields.layer.cornerRadius = 10
        textFields.layer.borderWidth = 0.5
        textFields.font = UIFont.systemFont(ofSize: 16)
        textFields.textColor = .black
        textFields.layer.borderColor = UIColor.lightGray.cgColor
        textFields.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: textFields.frame.height))
        textFields.leftViewMode = .always
        textFields.keyboardType = .asciiCapable
        textFields.translatesAutoresizingMaskIntoConstraints = false
    }


    func textfieldIsEmpty(textField: UITextField){
        UIView.animate(withDuration: 1, delay: 0.5, animations: {
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.systemRed.cgColor
            self.view.backgroundColor = .systemRed
        })
        self.view.backgroundColor = .white
    }

    func textFieldErrors() -> Bool {
        do {
            try Authorization.authorzation.athorizationIsCorrect(login: loginTextField.text, password: passwordTextField.text)
        }catch PossibleErrors.linesIsEmpty{
            textfieldIsEmpty(textField: loginTextField)
            textfieldIsEmpty(textField: passwordTextField)
            textFieldLoginErrorAnimation()
            textFieldPasswordErrorAnimation()
            return false
        }catch PossibleErrors.loginIsEmpty{
            textfieldIsEmpty(textField: loginTextField)
            textFieldLoginErrorAnimation()
            return false
        }catch PossibleErrors.passwordIsEmpty{
            textfieldIsEmpty(textField: passwordTextField)
            textFieldPasswordErrorAnimation()
            return false
        }catch PossibleErrors.incorrectPaswword{
            UIView.animate(withDuration: 0.5, delay: 0.2, animations: {
                self.textfieldIsEmpty(textField: self.passwordTextField)
            }){_ in
                self.errorPasswordNotification.isHidden = false
            }
            textFieldPasswordErrorAnimation()
            return false
        }catch PossibleErrors.incorrectLogin{
            let alertController = UIAlertController(title: "Sorry", message: "Login is incorrect", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Do it again", style: .cancel))
            present(alertController, animated: true, completion: nil)
            return false
        }catch PossibleErrors.notEmail{
            let alertController = UIAlertController(title: "Sorry", message: "unacceptable e-mail", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Do it again", style: .cancel))
            present(alertController, animated: true, completion: nil)
            return false
        }catch {
            let alertController = UIAlertController(title: "Error", message: "Somthing wrong", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "try again", style: .cancel))
            present(alertController, animated: true, completion: nil)
            return false
        }
        return true
    }

    func textFieldLoginErrorAnimation(){
        UIView.animate(withDuration: 0.1, delay: 00, animations: {
            UIView.modifyAnimations(withRepeatCount: 5, autoreverses: true) {
                self.loginTextFieldConstraintsLeading.constant = 10
                self.loginTextFieldConstrainstTrailing.constant = -10
                self.view.layoutIfNeeded()
            }
        }) {_ in
            self.loginTextFieldConstraintsLeading.constant = 16
            self.loginTextFieldConstrainstTrailing.constant = -16
        }
    }

    func textFieldPasswordErrorAnimation(){
        UIView.animate(withDuration: 0.1, delay: 00, animations: {
            UIView.modifyAnimations(withRepeatCount: 5, autoreverses: true) {
                self.passwordTextFieldConstraintsLeading.constant = 10
                self.paswordTextFieldConstrainstTrailing.constant = -10
                self.view.layoutIfNeeded()
            }
        }) {_ in
            self.passwordTextFieldConstraintsLeading.constant = 16
            self.paswordTextFieldConstrainstTrailing.constant = -16
        }
    }

    func standartScreenView(){
        UIView.animate(withDuration: 0, delay: 0, animations: {
            self.standartSettingsForTextFields(textFields: self.loginTextField)
            self.standartSettingsForTextFields(textFields: self.passwordTextField)
            self.errorPasswordNotification.isHidden = true
        })
    }

    @objc func logingActionButton(){
        standartScreenView()
        guard textFieldErrors() else { return }
        standartScreenView()
        let pvc = ProfilViewController()
        navigationController?.pushViewController(pvc, animated: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeKeaboardEvent()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(scrollView)
        scrollView.addSubview(loginImage)
        scrollView.addSubview(loginTextField)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(errorPasswordNotification)
        subscribeKeaboardEvent()
        layoutElements()
    }

    // MARK: - Keyaboard settings

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

}

// MARK: - Extensions
extension LogInViewController {

    func layoutElements(){
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            loginImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120),
            loginImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            loginImage.heightAnchor.constraint(equalToConstant: 100),
            loginImage.widthAnchor.constraint(equalToConstant: 100),

            loginTextField.topAnchor.constraint(equalTo: loginImage.bottomAnchor, constant: 120),
            loginTextFieldConstraintsLeading,
            loginTextFieldConstrainstTrailing,
            loginTextField.heightAnchor.constraint(equalToConstant: 50),

            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 0),
            passwordTextFieldConstraintsLeading,
            paswordTextFieldConstrainstTrailing,
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),

            errorPasswordNotification.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            errorPasswordNotification.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -110),

            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo:scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
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
