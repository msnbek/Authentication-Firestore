
//
//  HomeCell.swift
//  AuthenticationExercises
//
//  Created by Mahmut Senbek on 13.10.2023.
//

import Foundation

import UIKit

protocol CustomCellDelegate {
    func textfieldText(cell: HomeCellVC)
}

class HomeCellVC: UICollectionViewCell {
    var commentAction : ((String)->(Void))?
    let imageView = UIImageView()
    let showCommentButton = UIButton()
    let idLabel = UILabel()
   
    let nameLabel = UILabel()
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func style() {
        self.isUserInteractionEnabled = true
        showCommentButton.bringSubviewToFront(contentView)

        addSubview(imageView)
        addSubview(showCommentButton)
        addSubview(nameLabel)
        addSubview(idLabel)
     
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "person.fill")
        imageView.backgroundColor = .clear
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(contentView.frame.size.height / 9)

            make.width.equalTo(contentView.frame.size.width)
            make.height.equalTo(contentView.frame.size.height / 1.5)
            
        }
        
        nameLabel.text = "xxxxxxxxx@gmail.com"
        nameLabel.textColor = .black
        nameLabel.font = .boldSystemFont(ofSize: 22)
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(imageView.snp.top).offset(-20)
        }
        
        showCommentButton.setTitle("Send Comment", for: .normal)
        showCommentButton.backgroundColor = .clear
        showCommentButton.setTitleColor(.blue, for: .normal)
        showCommentButton.addTarget(self, action: #selector(sendCommentButtonTapped), for: .touchUpInside)
        
        showCommentButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(contentView.frame.size.width / 2)
            make.height.equalTo(30)
        }
       
        idLabel.isHidden = true
        idLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func sendCommentButtonTapped() {
        commentAction?(idLabel.text!)
    }
 

    
}



