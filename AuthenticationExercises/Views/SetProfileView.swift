//
//  SetProfileView.swift
//  AuthenticationExercises
//
//  Created by Mahmut Senbek on 13.10.2023.
//

import UIKit

class SetProfileView : UIView {
    override init(frame: CGRect) {
        super .init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
    }
    
    let profileImageView : UIImageView = {
        
        let image = UIImageView()
        image.image = UIImage(systemName: "person")
        image.tintColor = .clear
        image.contentMode = .scaleAspectFit
        image.tintColor = .gray
        image.layer.borderWidth = 1.0
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds = true
        
        return image
    }()
    
    let nameTextField : UITextField = {
        
        let textField = UITextField()
        let attributed = NSAttributedString(string: "Enter your name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.7), .font : UIFont.boldSystemFont(ofSize: 14)])
        textField.attributedPlaceholder = attributed
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 0.3
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        textField.layer.shadowOpacity = 0.5
        return textField
        
    }()
    
    let usernameTextField : UITextField = {
        
        let textField = UITextField()
        let attributed = NSAttributedString(string: "Enter nickname", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.7), .font : UIFont.boldSystemFont(ofSize: 14)])
        textField.attributedPlaceholder = attributed
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 0.3
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        textField.layer.shadowOpacity = 0.5
        
        return textField
        
    }()
    
    let createButton : UIButton = {
        let button = UIButton()
        button.setTitle("Create Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.4, height: 0.4)
        button.layer.shadowOpacity = 0.5
        
        return button
    }()
}
