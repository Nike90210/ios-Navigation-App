
import UIKit

class ProfileHeaderView: UIView {

    static let idForHeader = "HeaderID"

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
        statusLabel.backgroundColor = .white
        statusLabel.text = "what you want to know?"
        statusLabel.textColor = .black
        statusLabel.font = UIFont(name: "Regular", size: 10)
        return statusLabel
    }()

    lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show status", for: .normal)
        button.addAction(UIAction{_ in
            print( self.statusLabel.text ?? "" )
        }, for: .touchUpInside)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset.width = 4
        button.layer.shadowOffset.height = 4
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        return button
    }()

    lazy var statusTexField: UITextField = {
        let statusTexField = UITextField()
        statusTexField.translatesAutoresizingMaskIntoConstraints = false
        statusTexField.textColor = .black
        statusTexField.backgroundColor = .white
        statusTexField.clipsToBounds = true
        statusTexField.font = UIFont(name: "regular", size: 15)
        statusTexField.layer.borderColor = UIColor.blue.cgColor
        statusTexField.layer.borderWidth = 1
        statusTexField.layer.cornerRadius = 6
        return statusTexField
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override init(frame: CGRect){
        super.init(frame: .zero)
        backgroundColor = .white
        addSubview(statusTexField)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(button)
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
            statusTexField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16 + 130 + 16),
            statusTexField.heightAnchor.constraint(equalToConstant: 40),
            statusTexField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            button.topAnchor.constraint(equalTo: statusTexField.bottomAnchor, constant: 16),
            button.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
    }
}


