//
//  AvatarCollectionView.swift
//  MySecrets
//
//  Created by User on 9/18/18.
//  Copyright © 2018 Piligrim. All rights reserved.
//

import UIKit

class AvatarCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {

    var collectionView: UICollectionView!
    var collectionImageName: [String]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let imageNamesString = "market64,key64,idcard64,security64x64,user64x64,world64x64,rdp64x64"
        self.collectionImageName = imageNamesString.components(separatedBy: ",").map{$0}
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.itemSize = CGSize(width: 64, height: 64)
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "avatarCell")
        collectionView.register(UINib(nibName: "AvatarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "avatarCell")

        //collectionView.backgroundColor = UIColor.red
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: collectionView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: collectionView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as! AvatarCollectionViewCell
        cell.configure(with: collectionImageName[indexPath.row])
        return cell
    }
}
