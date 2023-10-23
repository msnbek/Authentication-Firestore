//
//  LogoutViewController.swift
//  AuthenticationExercises
//
//  Created by Mahmut Senbek on 12.10.2023.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class SetProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var setProfileView = SetProfileView()
    var email = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    /*
     @objc func logoutButtonTapped() {
     do {
     try Auth.auth().signOut()
     if let navigationController = self.navigationController {
     navigationController.popViewController(animated: true)
     }
     } catch {
     print(error.localizedDescription)
     }
     }
     */
    func configureUI() {
        view.addSubview(setProfileView.profileImageView)
        view.addSubview(setProfileView.nameTextField)
        view.addSubview(setProfileView.usernameTextField)
        view.addSubview(setProfileView.createButton)
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        setProfileView.profileImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        setProfileView.profileImageView.addGestureRecognizer(tapGesture)
        
        setProfileView.createButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        setProfileView.profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(view.frame.size.width / 3.5)
            make.height.equalTo(150)
            make.width.equalTo(150)
        }
        
        setProfileView.nameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(view.frame.size.width / 2)
            make.top.equalTo(setProfileView.profileImageView.snp.bottom).offset(50)
        }
        
        setProfileView.usernameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(view.frame.size.width / 2)
            make.top.equalTo(setProfileView.nameTextField.snp.bottom).offset(50)
        }
        
        setProfileView.createButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(view.frame.size.width / 3)
            make.height.equalTo(50)
            make.top.equalTo(setProfileView.usernameTextField.snp.bottom).offset(50)
        }
    }
    
    //MARK: - Create Button Tapped
    @objc func createButtonTapped() {
        guard let nameText = setProfileView.nameTextField.text, !nameText.isEmpty else {
            makeAlert(titleInput: "Error", messageInput: "Please enter an name.")
            return
        }
        
        
        guard let usernameText = setProfileView.usernameTextField.text, !usernameText.isEmpty else {
            makeAlert(titleInput: "Error", messageInput: "Please enter a nickname")
            return
        }
        
        if setProfileView.profileImageView.image != UIImage(systemName: "person") {
            let storage = Storage.storage()
            let storageReference = storage.reference()
            let mediaFolder = storageReference.child("profilepictures")
            
            if let data = setProfileView.profileImageView.image?.jpegData(compressionQuality: 0.5) {
                let uuid = UUID().uuidString
                let imageReference = mediaFolder.child("\(uuid).jpg")
                imageReference.putData(data, metadata: nil) { storageMetaData, error in
                    print("test")
                    if let err = error {
                        self.makeAlert(titleInput: "Error", messageInput: err.localizedDescription)
                        
                    }else {
                        imageReference.downloadURL { [self] url, error in
                            if let err = error {
                                self.makeAlert(titleInput: "Error", messageInput: err.localizedDescription)
                            }else {
                                guard let imageUrl = url?.absoluteString else {return}
                                
                                var _ :DocumentReference? = nil
                                guard let currentUser = Auth.auth().currentUser?.uid else {return}
                                let firestoreDatabase = Firestore.firestore()
                                let user = [
                                    "email" : email,
                                    "profileImageUrl" : imageUrl,
                                    "name" : nameText,
                                    "username": usernameText,
                                    "uid" : currentUser
                                ]
                                firestoreDatabase.collection("users").document(email).collection("userInfo").document("information").setData(user, merge: true)
                                
                                let vc = MainTabBarController()
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc,animated: true)
                                
                            }
                        }
                    }
                }
            }
            
        }else {
            makeAlert(titleInput: "Upload your photo.", messageInput: "Please take a picture.")
        }
        
        
    }
    //MARK: - Image Tapped
    
    @objc func imageTapped() {
        print("picker tapped")
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker,animated: true)
        
    }
    
    //MARK: - ImagePicker Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        setProfileView.profileImageView.image = info[.originalImage] as? UIImage
        setProfileView.profileImageView.contentMode = .scaleAspectFill
        setProfileView.profileImageView.clipsToBounds = true
        setProfileView.profileImageView.layer.cornerRadius = setProfileView.profileImageView.frame.size.width / 2
        self.dismiss(animated: true)
    }
    
    func makeAlert(titleInput : String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    
    
    
}
