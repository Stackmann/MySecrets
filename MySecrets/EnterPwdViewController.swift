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
    @IBOutlet weak var warningPasswordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        warningPasswordLabel.text = "Please use only latin characters, digits and symbols"
        warningPasswordLabel.textColor = UIColor(red: 255.0/255.0, green: 145.0/255.0, blue: 158.0/255.0, alpha: 1)
        warningPasswordLabel.numberOfLines = 0
    }

 
    @IBAction func PwdOk(_ sender: UIButton) {
        
        if let inputPasswordStr = inputPasswordField.text {
            if inputPasswordStr.isEmpty {
                let alert = CommonFuncs.getAlert(title: "Error", message: "Please enter the password!")
                self.present(alert, animated: true, completion: nil)
                return
            }
            let isContainCorrectCharacters = inputPasswordStr.isContainCorrectCharactersForRealmPassword
            if !isContainCorrectCharacters.0 {
                let alert = CommonFuncs.getAlert(title: "Error", message: "Incorrect \(isContainCorrectCharacters.1 + 1) character!")
                //let alert = CommonFuncs.getAlert(title: "Error", message: "Please use only latin characters, digits and symbols for password!")
                self.present(alert, animated: true, completion: nil)
                return
            }
            var userErrorStr = ""
            var inputPasswordStr64 = inputPasswordStr
            while inputPasswordStr64.count < 64 {
                inputPasswordStr64 = "0" + inputPasswordStr64
            }
            if let encryptKey = inputPasswordStr64.data(using: .utf8) {
                //print(encryptKey.count)
                let realmConfig = Realm.Configuration(encryptionKey: encryptKey)
                do {
                    let _ = try Realm(configuration: realmConfig)
                } catch {
                    if error.localizedDescription.contains("Realm file decryption failed") {
                        userErrorStr = "Wrong password!"
                     } else {
                        userErrorStr = "Error open database!"
                    }
                    let alert = CommonFuncs.getAlert(title: "Error", message: userErrorStr)
                    self.present(alert, animated: true, completion: nil)
                    print(error.localizedDescription)
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
