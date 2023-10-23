//
//  HomePageView.swift
//  AuthenticationExercises
//
//  Created by Mahmut Senbek on 13.10.2023.
//

import UIKit

class HomePageView : UIView {
    override init(frame: CGRect) {
        super .init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
    }
    
    func configure(){
        let collectionView : UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 20
            collectionView.register(HomeCellVC.self, forCellWithReuseIdentifier: "cell")
            collectionView.backgroundColor = .clear
            collectionView.isUserInteractionEnabled = true
            return collectionView
        }()
    }
    
    
    
}
