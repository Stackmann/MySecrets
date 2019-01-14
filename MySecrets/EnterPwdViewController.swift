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
    
    var isPasswordHidden = true
    @IBOutlet weak var inputPasswordField: UITextField!
    @IBOutlet weak var warningPasswordLabel: UILabel!
    @IBOutlet weak var showHiddenPasswordLabel: UILabel!{
        didSet {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(EnterPwdViewController.tapLabel))
            showHiddenPasswordLabel.isUserInteractionEnabled = true
            showHiddenPasswordLabel.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    // MARK: - lifecycle viewController metods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputPasswordField.isSecureTextEntry = isPasswordHidden
        warningPasswordLabel.text = NSLocalizedString("EnterPasswordWarning", comment: "Warning for using correct symbols in password")
        warningPasswordLabel.textColor = UIColor(red: 255.0/255.0, green: 145.0/255.0, blue: 158.0/255.0, alpha: 1)
        warningPasswordLabel.numberOfLines = 0

        showHiddenPasswordLabel.text = NSLocalizedString("EnterPasswordShowPasswordSymbols", comment: "Message that can switch visibility input symbols")
        showHiddenPasswordLabel.textColor = UIColor(red: 29.0/255.0, green: 193.0/255.0, blue: 38.0/255.0, alpha: 1)
    }

    // MARK: - actions

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
                self.present(alert, animated: true, completion: nil)
                return
            }
            

            if !Secrets.share.dataAvailable {
                let resultInitDB = CommonFuncs.initRealmDB(inputPasswordStr: inputPasswordStr, suffixInMsg: "")
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
    
    @objc private func tapLabel(sender:UITapGestureRecognizer) {
        isPasswordHidden = !isPasswordHidden
        inputPasswordField.isSecureTextEntry = isPasswordHidden
        let enterPasswordMessageId = isPasswordHidden ? "EnterPasswordShowPasswordSymbols" : "EnterPasswordHiddenPasswordSymbols"
            showHiddenPasswordLabel.text = NSLocalizedString(enterPasswordMessageId, comment: "Message that can switch visibility input symbols")
    }
}
