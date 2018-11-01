//
//  AvatarCollectionViewCell.swift
//  MySecrets
//
//  Created by User on 10/7/18.
//  Copyright © 2018 Piligrim. All rights reserved.
//

import UIKit

class AvatarCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    
    func configure(with nameOfImage: String) {
        avatarImageView.image = UIImage(named: nameOfImage)
    }

}
