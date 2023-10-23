//
//  UserModel.swift
//  AuthenticationExercises
//
//  Created by Mahmut Senbek on 13.10.2023.
//

import UIKit

struct User {
    
    let email: String
    let name: String
    let profileImageUrl: String
    let uid: String
    let username: String
    //  var postImages : UIImage?
    init(data: [String: Any]) {
        self.email = data["email"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.profileImageUrl = data["profileImageUrl"] as? String ?? ""
        self.uid = data["uid"] as? String ?? ""
        self.username = data["username"] as? String ?? ""
        //  self.postImages = data["postImages"] as? UIImage
        
    }
    
}
struct Post {
    var postImagesUrl : String
    var userComment : String?
    var postUUID : String
    var email : String
    var time : Date?
    
    init(data : [String : Any]) {
        self.postImagesUrl = data["postImagesUrl"] as? String ?? ""
        self.userComment = data["userComment"] as? String ?? ""
        self.postUUID = data["postUUID"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.time = data["date"] as? Date
    }
    
}

struct Comment {
    var comment : String
    var postedBy : String
    var docID : String
    
    
    init(data : [String : Any]) {
        self.comment = data["comment"] as? String ?? ""
        self.postedBy = data["postedBy"] as? String ?? ""
        self.docID = data["docID"] as? String ?? ""
    }
}

