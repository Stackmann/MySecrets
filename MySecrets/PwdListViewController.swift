//
//  PwdListViewController.swift
//  MySecrets
//
//  Created by Eric on 11/29/17.
//  Copyright © 2017 Piligrim. All rights reserved.
//

import UIKit

class PwdListViewController: UIViewController {

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
        if Secrets.share.list == nil {
            performSegue(withIdentifier: "enterPwd", sender: nil)
        } else {
            for secret in Secrets.share.list! {
                if let nibsArray = Bundle.main.loadNibNamed("secretView", owner: self, options: nil),
                    let secretNibView = nibsArray[0] as? secretView {
                    secretNibView.configure(image: secret.avatar, descr: secret.describe)
                    view.addSubview(secretNibView)
                }

            }
        }
    }

}
