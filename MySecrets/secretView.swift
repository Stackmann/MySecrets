//
//  secretView.swift
//  MySecrets
//
//  Created by Eric on 11/29/17.
//  Copyright © 2017 Piligrim. All rights reserved.
//

import UIKit

class secretView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        secretDescription.numberOfLines = 0
    }

    @IBOutlet weak var secretDescription: UILabel!
    
    @IBOutlet weak var secretIcon: UIImageView!
    
    func configure(image: UIImage, descr: String) {
        secretDescription.text = descr
        secretIcon.image = image
    }
}
