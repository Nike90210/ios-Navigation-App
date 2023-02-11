
import UIKit

class ProfileHeaderView: UIView {

    static let idForHeader = "HeaderID"

    lazy var statusTextForChange: String = "..."

    private var statusTextLeading: NSLayoutConstraint!
    private var statusTextTrailing: NSLayoutConstraint!

    private lazy var fullNameLabel: UILabel = {
        let fullNameLabel = UILabel(frame: .zero)
        fullNameLabel.text = "Magic of knowlage"
        fullNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        fullNameLabel.textColor = .black
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return fullNameLabel
    }()

    lazy var statusLabel: UILabel = {
        let statusLabel = UILabel(frame: .zero)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.backgroundColor = .lightText
        statusLabel.text = "What you want to know ?"
        statusLabel.textColor = .black
        statusLabel.font = UIFont(name: "Regular", size: 10)
        return statusLabel
    }()

    lazy var statusButton: UIButton = {
        let statusButton = UIButton(frame: .zero)
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        statusButton.setTitle("Show status", for: .normal)
        statusButton.addTarget(self, action: #selector(buttonForAction), for: .touchUpInside)
        statusButton.setTitleColor(UIColor.white, for: .normal)
        statusButton.backgroundColor = .blue
        statusButton.layer.cornerRadius = 4
        statusButton.layer.shadowOffset.width = 4
        statusButton.layer.shadowOffset.height = 4
        statusButton.layer.shadowRadius = 4
        statusButton.layer.shadowColor = UIColor.black.cgColor
        statusButton.layer.shadowOpacity = 0.7
        return statusButton
    }()

    lazy var statusTexField: UITextField = {
        let statusTexField = UITextField(frame:  .zero)
        statusTexField.textColor = .black
        statusTexField.backgroundColor = .white
        statusTexField.font = UIFont(name: "regular", size: 15)
        statusTexField.layer.borderColor = UIColor.blue.cgColor
        statusTexField.layer.borderWidth = 1
        statusTexField.layer.cornerRadius = 6
        statusTexField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: statusTexField.frame.height))
        statusTexField.leftViewMode = .always
        statusTextLeading = statusTexField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 160)
        statusTextTrailing = statusTexField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        statusTexField.translatesAutoresizingMaskIntoConstraints = false
        return statusTexField
    }()

    @objc func buttonForAction(){
        standartTextFieldView(textField: statusTexField)
        guard textFieldErrorAnimation() else { return }
        guard let textToPrint = statusLabel.text else { return }
        print(textToPrint)
        statusLabel.text = statusTextForChange
    }

    // Методы для анимации TextField

    func textFieldErrorAnimation() -> Bool {
        if statusTexField.text == "" {
            emptyTextFieldCollorBorder(textField: statusTexField)
            earthquakeTextField()
        }else {
            let newText = statusTexField.text
            statusTextForChange = newText ?? ""
        }
        return true
    }

    func emptyTextFieldCollorBorder(textField: UITextField){
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            textField.layer.borderColor = UIColor.systemPurple.cgColor
            textField.layer.borderWidth = 4
        }){_ in
            UIView.animate(withDuration: 0.5, animations: {
                textField.layer.borderColor = UIColor.blue.cgColor
                textField.layer.borderWidth = 2
            })
        }
    }

    func standartTextFieldView(textField: UITextField){
        UIView.animate(withDuration: 1, delay: 0, animations: {
            textField.layer.borderColor = UIColor.blue.cgColor
        })
    }

    func earthquakeTextField(){
        UIView.animate(withDuration: 0.07, delay: 0, animations: {
            UIView.modifyAnimations(withRepeatCount: 3, autoreverses: true) {
                self.statusTextLeading.constant = 150
                self.statusTextTrailing.constant = -25
                self.layoutIfNeeded()
            }
        }){ _ in
            self.statusTextLeading.constant = 160
            self.statusTextTrailing.constant = -16
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }

    override init(frame: CGRect){
        super.init(frame: .zero)
        backgroundColor = .white
        addSubview(statusTexField)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(statusButton)
        setConstrains()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileHeaderView {

    func setConstrains(){
        NSLayoutConstraint.activate([
            fullNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            fullNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 130 + 16 + 16),

            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 40),
            statusLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16 + 130 + 16),

            statusTexField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 10),
            statusTextLeading,
            statusTextTrailing,
            statusTexField.heightAnchor.constraint(equalToConstant: 40),

            statusButton.topAnchor.constraint(equalTo: statusTexField.bottomAnchor, constant: 16),
            statusButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            statusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            statusButton.heightAnchor.constraint(equalToConstant: 50),
            statusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
    }
}


