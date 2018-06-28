//
//  ModalViewController.swift
//  MySecrets
//
//  Created by Eric on 11/20/17.
//  Copyright © 2017 EricsApp. All rights reserved.
//

import UIKit
import RealmSwift

class EnterPwdViewController: UIViewController {

    @IBOutlet weak var inputPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

 
    @IBAction func PwdOk(_ sender: UIButton) {
        
        if let inputPasswordStr = inputPasswordField.text {
            if inputPasswordStr.isEmpty {
                let alert = CommonFuncs.getAlert(title: "Error", message: "Please enter the password!")
                self.present(alert, animated: true, completion: nil)
                return
            }
            var inputPasswordStr64 = inputPasswordStr
            while inputPasswordStr64.count < 64 {
                inputPasswordStr64 = "0" + inputPasswordStr64
            }
            if let encryptKey = inputPasswordStr64.data(using: .utf8) {
                print(encryptKey.count)
                let realmConfig = Realm.Configuration(encryptionKey: encryptKey)
                do {
                    let _ = try Realm(configuration: realmConfig)
                } catch {
                    let alert = CommonFuncs.getAlert(title: "Error", message: "Wrong password!")
                    self.present(alert, animated: true, completion: nil)
                    print(error)
                    return
                }
            }
            if !Secrets.share.dataAvailable {
                Secrets.share.loadData()
                Secrets.share.dataAvailable = true
            }
        }
        dismiss(animated: true, completion: nil)
    }
}
