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

        warningPasswordLabel.text = "Use only latin characters, digits and symbols"
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
            

            if !Secrets.share.dataAvailable {
                let resultInitDB = CommonFuncs.initRealmDB(inputPasswordStr: inputPasswordStr)
                if !resultInitDB.0 {
                    let alert = CommonFuncs.getAlert(title: "Error", message: resultInitDB.1)
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                //Secrets.share.loadData()
                if Secrets.share.dataFirstReading {
                    if !CommonFuncs.readFromRealmDB() {
                        let alert = CommonFuncs.getAlert(title: "Error", message: "Error reading from DB. Try to recreate DB!")
                        self.present(alert, animated: true, completion: nil)
                        return
                    } else {
                        for secret in Secrets.share.list {
                            Secrets.share.lastNum = max(secret.num, Secrets.share.lastNum)
                        }
                    }
                    Secrets.share.dataFirstReading = false
                }
                Secrets.share.dataAvailable = true
            }
        }
        dismiss(animated: true, completion: nil)
    }
}
