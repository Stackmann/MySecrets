//
//  ModalViewController.swift
//  MySecrets
//
//  Created by Eric on 11/20/17.
//  Copyright © 2017 Piligrim. All rights reserved.
//

import UIKit

class EnterPwdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

 
    @IBAction func PwdOk(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
