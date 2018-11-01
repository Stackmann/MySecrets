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
        
        let imageNamesString = "market64,key64,idcard64,security64x64,user64x64,world64x64,rdp64x64,credit_card_48x48,credit-cards_48x48,lock_48x48,secure-payment_48x48,user_id_48x48,youtube57x57,twitter57x57,skype57x57,pinterest57x57,linkedin57x57,instagram57x57,googleplus57x57,flickr57x57,facebook57x57,Google40x40,Yahoo40x40,visa-card-icon,email64x64,bank64,gmail64x64,payPal64x64,whatsapp64x64,youtube64x64,apple64x64,android64x64,ebay64x64,dropbox64x64,amazon64x64,stackoverflow64x64,googleChrome64x64,hangouts64x64,wallet64x64,viber64x64,slack64x64,shopping_cart64x64,blogger64x64,chat64x64,contact64x64,creditCard_Amex64x64,creditCard_Cirrus64x64,creditCard_MasterCard64x64,creditCard_Visa64x64,database64x64,firefox64x64,folder64x64,google_Chrome64x64,home64x64,internet_Explorer64x64,mobile64x64,opera64x64,photo64x64,print64x64,safari64x64,send_Mail64x64"
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
