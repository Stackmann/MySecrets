//
//  PwdCollectionViewCell.swift
//  MySecrets
//
//  Created by Eric on 1/31/18.
//  Copyright © 2018 Piligrim. All rights reserved.
//

import UIKit

class PwdCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var describePatternLabel: UILabel!
    
    func configure(with pattern: PatternRecord) {
        avatarImageView.image = UIImage(data: pattern.avatar)
        describePatternLabel.text = pattern.describe
    }
}
