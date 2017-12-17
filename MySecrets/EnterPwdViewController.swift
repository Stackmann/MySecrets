//
//  ModalViewController.swift
//  MySecrets
//
//  Created by Eric on 11/20/17.
//  Copyright © 2017 EricsApp. All rights reserved.
//

import UIKit

class EnterPwdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

 
    @IBAction func PwdOk(_ sender: UIButton) {
        Secrets.share.loadData()
        dismiss(animated: true, completion: nil)
    }
}
