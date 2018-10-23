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
    var delegat: AssetsAvatarSelected?
    
    init(frame: CGRect, delegat: AssetsAvatarSelected) {
        super.init(frame: frame)
        
        self.delegat = delegat
        
        let imageNamesString = "market64,key64,idcard64,security64x64,user64x64,world64x64,rdp64x64,credit_card_48x48,credit-cards_48x48,lock_48x48,secure-payment_48x48,user_id_48x48,Chrome,youtube57x57,twitter57x57,skype57x57,pinterest57x57,linkedin57x57,instagram57x57,googleplus57x57,flickr57x57,facebook57x57,Google40x40,Yahoo40x40,visa-card-icon,email64x64,bank64"
        self.collectionImageName = imageNamesString.components(separatedBy: ",").map{$0}
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.itemSize = CGSize(width: 48, height: 48)
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "avatarCell")
        collectionView.register(UINib(nibName: "AvatarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "avatarCell")

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

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionImageName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as! AvatarCollectionViewCell
        cell.configure(with: collectionImageName[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegat?.setNewAvatar(with: collectionImageName[indexPath.row])
    }
}