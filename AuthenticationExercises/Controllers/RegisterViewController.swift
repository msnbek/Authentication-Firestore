//
//  ViewController.swift
//  AuthenticationExercises
//
//  Created by Mahmut Senbek on 12.10.2023.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    let myView = RegisterView()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @objc func registerButtonClicked() {
        guard let emailText = RegisterView.emailTextField.text else {return}
        guard let passwordText = RegisterView.passwordTextField.text else {return}
        
        Auth.auth().createUser(withEmail: emailText, password: passwordText) { [self] authData, error in
            if let err = error {
                makeAlert(titleInput: "Error", messageInput: err.localizedDescription)
            }else {
                Auth.auth().currentUser?.sendEmailVerification(completion: { [self] error in
                    if let err = error {
                        makeAlert(titleInput: "Title", messageInput: err.localizedDescription)
                    }else {
                        let alert = UIAlertController(title: "Registered", message: "Email verification sended.", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Ok!", style: .default) { (action) in
                            let vc = LoginViewController()
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        alert.addAction(action)
                        self.present(alert,animated: true)
                    }
                })
                
            }
        }
    }
    
    
    @objc func haveYouRegisteredBeforeButtonTapped() {
        
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureUI() {
        // navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor.yellow.withAlphaComponent(0.5)
        view.addSubview(myView.emailContainerView)
        view.addSubview(myView.passwordContainerView)
        view.addSubview(myView.registerLogo)
        view.addSubview(myView.registerButton)
        view.addSubview(myView.signInButton)
        myView.registerButton.addTarget(self, action: #selector(registerButtonClicked), for: .touchUpInside)
        myView.signInButton.addTarget(self, action: #selector(haveYouRegisteredBeforeButtonTapped), for: .touchUpInside)
        
        myView.registerLogo.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(120)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(125)
        }
        
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
        
        myView.registerButton.snp.makeConstraints { make in
            make.top.equalTo(myView.passwordContainerView.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.centerY.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        
        myView.signInButton.snp.makeConstraints { make in
            make.top.equalTo(myView.registerButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.height.equalTo(20)
        }
    }
    
    func makeAlert(titleInput : String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
