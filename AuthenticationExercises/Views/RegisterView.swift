//
//  View.swift
//  AuthenticationExercises
//
//  Created by Mahmut Senbek on 12.10.2023.
//

import UIKit
import SnapKit

class RegisterView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    let registerLogo : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        imageView.image = UIImage(systemName: "checkmark.message") // image'a system'dan fotoğraf yerlestirdik.
        imageView.tintColor = .white // image'ın tint rengini değiştirdik.
        return imageView
        
    }()
    
    var emailContainerView : UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "envelope")
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView)
        containerView.addSubview(emailTextField)
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        containerView.addSubview(dividerView)
        
        imageView.snp.makeConstraints({ make in
            make.leading.equalTo(containerView.snp.leading).offset(8)
            make.centerY.equalTo(containerView.snp.centerY)
            make.height.equalTo(26)
            make.width.equalTo(26)
        })
        
        emailTextField.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(15)
            make.centerY.equalTo(containerView.snp.centerY)
            make.bottom.equalTo(containerView.snp.bottom).offset(-8)
            make.trailing.equalTo(containerView.snp.trailing).offset(-8)
        }
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(3)
            make.height.equalTo(0.7)
            make.width.equalTo(370)
            make.leading.equalTo(containerView.snp.leading)
        }
        return containerView
    }()
    //MARK: - EmailTextField
    static  let emailTextField : UITextField = {
        
        let textField = UITextField()
        textField.textColor = UIColor.black
        textField.borderStyle = .none
        let attributedText = NSAttributedString(string: "E-mail",attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.7)])
        textField.attributedPlaceholder = attributedText
        return textField
        
    }()
    
    //MARK: - Password Container View
    var passwordContainerView : UIView = {
        
        let containerView = UIView()
        containerView.backgroundColor = .clear
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "square.and.pencil")
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView)
        containerView.addSubview(passwordTextField)
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(dividerView)
        
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.leading).offset(8)
            make.centerY.equalTo(containerView.snp.centerY)
            make.height.equalTo(26)
            make.width.equalTo(26)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(15)
            make.centerY.equalTo(containerView.snp.centerY)
            make.bottom.equalTo(containerView.snp.bottom).offset(-8)
            make.trailing.equalTo(containerView.snp.trailing).offset(-8)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom)
            make.height.equalTo(0.7)
            make.width.equalTo(370)
            make.leading.equalTo(containerView.snp.leading)
        }
        return containerView
        
        
    }()
    //MARK: - Password TextField
    static let passwordTextField : UITextField = {
        
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.textColor = .black
        textField.borderStyle = .none
        textField.textContentType = .oneTimeCode
        let attributedText = NSAttributedString(string: "Password",attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.7)])
        textField.attributedPlaceholder = attributedText
        return textField
        
    }()
    
    let signInButton : UIButton = {
        
        let button = UIButton(type: .system)
        //  let attributedTitle = NSMutableAttributedString(string: "Click To Become Member", attributes: [.foregroundColor : UIColor.white, .font : UIFont.boldSystemFont(ofSize: 14)])
        // button.setAttributedTitle(attributedTitle, for: UIControl.State.normal)
        button.setTitle("Have you registered before?", for: UIControl.State.normal)
        button.backgroundColor = .clear
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.isEnabled = true
        button.setTitleColor(.black.withAlphaComponent(0.8), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        
        return button
        
    }()
    
    let registerButton : UIButton = {
        
        let button = UIButton(type: .system)
        
        button.setTitle("Register", for: UIControl.State.normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        button.layer.cornerRadius = 7
        button.layer.borderWidth = 0.1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        button.layer.shadowOpacity = 0.5
        return button
    }()
    
    
}
