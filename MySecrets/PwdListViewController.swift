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
        var previousView = view!
        var leftAnchor : NSLayoutXAxisAnchor
        if Secrets.share.list == nil {
            performSegue(withIdentifier: "enterPwd", sender: nil)
        } else {
            for secret in Secrets.share.list! {
                if let nibsArray = Bundle.main.loadNibNamed("secretView", owner: self, options: nil),
                    let secretNibView = nibsArray[0] as? secretView {
                    secretNibView.configure(image: secret.avatar, descr: secret.describe)
                    view.addSubview(secretNibView)
                    secretNibView.translatesAutoresizingMaskIntoConstraints = false
                    
//                    let horizontalConstraint = NSLayoutConstraint(item: secretNibView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
//                    let verticalConstraint = NSLayoutConstraint(item: secretNibView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
//                    let widthConstraint = NSLayoutConstraint(item: secretNibView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 100)
//                    let heightConstraint = NSLayoutConstraint(item: secretNibView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 100)
//                    NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
                    if previousView == view! {
                        leftAnchor = previousView.leftAnchor
                    } else {
                        leftAnchor = previousView.rightAnchor
                    }
                    NSLayoutConstraint.activate([
                        secretNibView.topAnchor.constraint(equalTo: previousView.topAnchor),
                        secretNibView.leftAnchor.constraint(equalTo: leftAnchor),
                        secretNibView.widthAnchor.constraint(equalToConstant: 88),
                        secretNibView.heightAnchor.constraint(equalToConstant: 103)
                        ])
                    previousView = secretNibView

                }

            }
        }
    }

}
