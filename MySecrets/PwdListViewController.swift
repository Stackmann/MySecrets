//
//  PwdListViewController.swift
//  MySecrets
//
//  Created by Eric on 11/29/17.
//  Copyright © 2017 Piligrim. All rights reserved.
//

import UIKit

class PwdListViewController: UIViewController {

    var mySecrets = Secrets()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //        if let secrets = mySecrets.list {
        //            for secret in secrets {
        //
        //            }
        //        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performSegue(withIdentifier: "enterPwd", sender: nil)
    }

}
