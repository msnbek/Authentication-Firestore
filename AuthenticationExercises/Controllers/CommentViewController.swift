//
//  CommentViewController.swift
//  AuthenticationExercises
//
//  Created by Mahmut Senbek on 18.10.2023.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class CommentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var comments = [Comment]()
    let commentTableView = UITableView()
    let textField = UITextField()
    let sendCommentButton = UIButton()
    var docID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTableView.delegate = self
        commentTableView.dataSource = self
        configure()
        fetchComment()
        print(docID)
    }
    
    func configure() {
        view.backgroundColor = .white
        view.addSubview(commentTableView)
        view.addSubview(textField)
        view.addSubview(sendCommentButton)
        textField.placeholder = "Enter your comment"
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 15
        textField.layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
        textField.layer.shadowOpacity = 0.3
        
        sendCommentButton.setImage(UIImage(systemName: "paperplane"), for: .normal)
        sendCommentButton.setTitleColor(.blue, for: .normal)
        sendCommentButton.backgroundColor = .clear
        
        commentTableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        
        commentTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.right.left.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.right.equalToSuperview().offset(-80)
            make.leading.equalToSuperview().offset(50)
            make.top.equalTo(commentTableView.snp.bottom).offset(2)
        }
        sendCommentButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalTo(textField.snp.centerY)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        sendCommentButton.addTarget(self, action: #selector(sendCommentButtonHandle), for: .touchUpInside)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let index = comments[indexPath.row]
        cell.commentLabel.text = index.comment
        cell.senderLabel.text = index.postedBy
        cell.backgroundColor = .yellow.withAlphaComponent(0.2)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    func fetchComment() {
        let firestoreDatabase = Firestore.firestore()
        
        firestoreDatabase.collection("comments").whereField("postID", isEqualTo: docID).getDocuments { [self] snapshot, error in
            if let err = error {
                print(err.localizedDescription)
            } else {
                comments.removeAll()
                for document in snapshot!.documents {
                    let data = document.data()
                    let comment = Comment(data: data)
                    self.comments.append(comment)
                }
                DispatchQueue.main.async {
                    self.commentTableView.reloadData()
                }
            }
        }
    }
    
    
    @objc func sendCommentButtonHandle() {
        let fireStoreDatabase = Firestore.firestore()
        guard let email = Auth.auth().currentUser?.email else { return }
        guard let commentText = textField.text else { return }
        
        let comment = [
            "comment": commentText,
            "postedBy": email,
            "postID": docID
        ]
        
        fireStoreDatabase.collection("comments").addDocument(data: comment) { error in
            if let err = error {
                print(err.localizedDescription)
            } else {
                self.fetchComment()
                self.textField.text = ""
            }
        }
    }
    
    
    
    
    
    
    
}
