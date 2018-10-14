//
//  AvatarView.swift
//  MySecrets
//
//  Created by User on 9/16/18.
//  Copyright © 2018 Piligrim. All rights reserved.
//

import UIKit

class AvatarView: UIImageView, UIKeyInput {
    var hasText = true

    private var _inputView: UIView?
    override var inputView: UIView? {
        get {
            return _inputView
        }
        set {
            _inputView = newValue
        }
    }
    
    func insertText(_ text: String) {
        
    }
    
    func deleteBackward() {
        
    }
    
    override var canBecomeFirstResponder: Bool {return true}
}
