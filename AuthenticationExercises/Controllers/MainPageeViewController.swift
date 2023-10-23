//
//  MainPageeViewController.swift
//  AuthenticationExercises
//
//  Created by Mahmut Senbek on 13.10.2023.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import SDWebImage

class MainPageeViewController: UIViewController{
    
    let homeCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        collectionView.register(HomeCellVC.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .clear
        collectionView.isUserInteractionEnabled = true
        return collectionView
    }()
    
    
    var userModel = [User]()
    var postModel = [Post]()
    let addButton = UIButton()
    var currentUserEmail = ""
    var postID : String?
    var postsIDs = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUser()
        fetchPosts()
        getCurrentUser()
    }
    
    func getCurrentUser() {
        guard let currentUser = Auth.auth().currentUser?.email else { return }
        self.currentUserEmail = currentUser
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(addButton)
        
        navigationController?.navigationBar.isHidden = true
        // Constraints for addButton
        addButton.setTitle("Add Post", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.backgroundColor = .clear
        addButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.top.equalTo(view.snp.top).offset(70)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        view.addSubview(homeCollectionView)
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        // Constraints for collectionView
        homeCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(130)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-98)
        }
        
        
    }
    
    @objc func addButtonTapped() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func fetchUser() {
        guard let email = Auth.auth().currentUser?.email else { return }
        
        Firestore.firestore().collection("users").document(email).collection("userInfo").document("information").addSnapshotListener { [weak self] snapshot, error in
            guard let data = snapshot?.data(), let self = self else { return }
            let user = User(data: data)
            self.userModel.append(user)
            
            DispatchQueue.main.async {
                self.homeCollectionView.reloadData()
            }
        }
    }
    
    func fetchPosts() {
        Firestore.firestore().collectionGroup("info").addSnapshotListener { [weak self] querySnapshot, error in
            guard let self = self else { return }
            if let err = error {
                self.makeAlert(titleInput: "Error", messageInput: err.localizedDescription)
                return
            }
            self.postModel.removeAll()
            for document in querySnapshot!.documents {
                postsIDs.append(document.documentID)
                let postData = document.data()
                let post = Post(data: postData)
                self.fetchUserForPost(post: post)
            }
        }
    }
    
    func fetchUserForPost(post: Post) {
        Firestore.firestore().collection("users").document(post.email).collection("userInfo").document("information").getDocument { [weak self] snapshot, error in
            guard let self = self else { return }
            if let err = error {
                print(err.localizedDescription)
                return
            }
            if let data = snapshot?.data() {
                let user = User(data: data)
                self.userModel.append(user) // Kullanıcı bilgisini userModel dizisine ekleyin
                self.postModel.append(post) // Post bilgisini postModel dizisine ekleyin
                DispatchQueue.main.async {
                    self.homeCollectionView.reloadData()
                }
            }
        }
    }
    
    
    
    
    
    func makeAlert(titleInput : String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    
    
    
    
    
    
}


extension MainPageeViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("postsImages")
        if let data = image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("images/\(currentUserEmail)/\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { storageMetaData, error in
                if let err = error {
                    self.makeAlert(titleInput: "Error", messageInput: err.localizedDescription)
                }else {
                    imageReference.downloadURL { [self] url, error in
                        if let err = error {
                            self.makeAlert(titleInput: "Error", messageInput: err.localizedDescription)
                        }else {
                            guard let imageUrl = url?.absoluteString else {return}
                            var _:DocumentReference? = nil
                            let postUuid = UUID().uuidString
                            let firestoreDatabase = Firestore.firestore()
                            let post = [
                                "postImagesUrl": imageUrl,
                                "postUUID" :postUuid,
                                "email" : currentUserEmail,
                                "time" : FieldValue.serverTimestamp()
                            ]
                            firestoreDatabase.collection("users").document(currentUserEmail).collection("userInfo").document("posts").collection("info").document().setData(post,merge: true)
                        }
                    }
                }
            }
        }
        self.dismiss(animated: true)
        
        
    }
    
}

extension MainPageeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCellVC
        cell.backgroundColor = .gray.withAlphaComponent(0.1)
        
        let postIndex = postModel[indexPath.row]
        cell.nameLabel.text = postsIDs[indexPath.row]
        func passId(completion : @escaping (_ data : String) -> Void) {
            completion(postsIDs[indexPath.row])
        }
        if let user = userModel.first(where: { $0.email == postIndex.email }) {
            cell.nameLabel.text = user.username
        } else {
            cell.nameLabel.text = "Unknown User"
        }
        cell.imageView.sd_setImage(with: URL(string: postIndex.postImagesUrl))
        cell.idLabel.text = postIndex.postUUID
        
        cell.commentAction = { postID in
            let vc = CommentViewController()
            print(postID)
            vc.docID = postID
            vc.modalPresentationStyle = .popover
            self.present(vc, animated: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height / 2.2)
    }
    
    
}
