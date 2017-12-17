//
//  SecretCell.swift
//  MySecrets
//
//  Created by Eric on 11/30/17.
//  Copyright © 2017 EricsApp. All rights reserved.
//

import UIKit

class SecretCell: UICollectionViewCell {
    
    @IBOutlet weak var secretDescription: UILabel!
   
    @IBOutlet weak var secretIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        secretDescription.numberOfLines = 0
    }

    func configure(image: UIImage, descr: String) {
        secretDescription.text = descr
        secretIcon.image = image
    }

}
