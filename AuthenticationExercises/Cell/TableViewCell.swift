//
//  TableViewCell.swift
//  AuthenticationExercises
//
//  Created by Mahmut Senbek on 18.10.2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    let commentLabel = UILabel()
    let senderLabel = UILabel()
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        configureUI()
    }
    
    func configureUI() {
        addSubview(commentLabel)
        addSubview(senderLabel)
        
        commentLabel.textColor = .black
        commentLabel.textAlignment = .center
        
        commentLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(contentView.snp.top).offset(10)
        }
        
        senderLabel.textColor = .black
        senderLabel.textAlignment = .center
        
        senderLabel.snp.makeConstraints { make in
            make.top.equalTo(commentLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
}
