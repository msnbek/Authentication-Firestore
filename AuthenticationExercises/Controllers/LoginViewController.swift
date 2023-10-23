//
//  LoginViewController.swift
//  AuthenticationExercises
//
//  Created by Mahmut Senbek on 12.10.2023.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    var myView = LoginView()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    @objc func signButtonClicked() {
        guard let emailText = LoginView.emailTextField.text, !emailText.isEmpty else {
            makeAlert(titleInput: "Error", messageInput: "Please enter an email.")
            return
        }
        
        guard let passwordText = LoginView.passwordTextField.text, !passwordText.isEmpty else {
            makeAlert(titleInput: "Error", messageInput: "Please enter a password.")
            return
        }
        
        Auth.auth().signIn(withEmail: emailText, password: passwordText) { [self] authResult, error in
            if let err = error {
                makeAlert(titleInput: "Error", messageInput: err.localizedDescription)
            } else {
                guard let user = Auth.auth().currentUser else {
                    makeAlert(titleInput: "Error", messageInput: "No authenticated user.")
                    return
                }
                
                // Debug
                print("User: \(user)")
                print("Is email verified: \(user.isEmailVerified)")
                
                if user.isEmailVerified {
                    let vc = SetProfileViewController()
                    navigationController?.pushViewController(vc, animated: true)
                    vc.email = emailText
                } else {
                    makeAlert(titleInput: "Verify", messageInput: "Verify your email.")
                }
            }
        }
    }
    
    
    
    @objc func forgotPasswordButtonTapped() {
        let alertController = UIAlertController(title: "Reset Password", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Your Mail"
            textField.font = .systemFont(ofSize: 24)
            textField.textAlignment = .center
        }
        let saveAction = UIAlertAction(title: "Reset", style: .default, handler: { alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            if textField.text != "" {
                Auth.auth().sendPasswordReset(withEmail: textField.text ?? "x@x.com") { [self] error in
                    if let err = error {
                        makeAlert(titleInput: "Error", messageInput: err.localizedDescription)
                    }else {
                        makeAlert(titleInput: "OK!", messageInput: "Reset password link sended to email.")
                    }
                }
            }
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
    @objc func backButtonTapped() {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    func makeAlert(titleInput : String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    func configureUI() {
        view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        view.addSubview(myView.emailContainerView)
        view.addSubview(myView.passwordContainerView)
        view.addSubview(myView.signInButton)
        view.addSubview(myView.forgotPassword)
        view.addSubview(myView.backButton)
        navigationController?.navigationBar.isHidden = true
        myView.signInButton.addTarget(self, action: #selector(signButtonClicked), for: .touchUpInside)
        myView.forgotPassword.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        myView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        myView.emailContainerView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(270)
            make.leading.equalTo(view.snp.leading).offset(8)
            make.trailing.equalTo(view.snp.trailing).offset(-8)
            make.height.equalTo(60)
        }
        
        myView.passwordContainerView.snp.makeConstraints { make in
            make.top.equalTo(myView.emailContainerView.snp.bottom).offset(12)
            make.leading.equalTo(view.snp.leading).offset(8)
            make.trailing.equalTo(view.snp.trailing).offset(-8)
            make.height.equalTo(60)
        }
        
        myView.signInButton.snp.makeConstraints { make in
            make.top.equalTo(myView.passwordContainerView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        myView.forgotPassword.snp.makeConstraints { make in
            make.top.equalTo(myView.signInButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.height.equalTo(20)
        }
        myView.backButton.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(40)
            make.top.equalTo(view.snp.top).offset(73)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
    }
    
}
