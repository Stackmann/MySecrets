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
    var isRealmDBMissing = true
    @IBOutlet weak var inputPasswordField: UITextField!
    @IBOutlet weak var warningPasswordLabel: UILabel!
    @IBOutlet weak var showHiddenPasswordLabel: UILabel!{
        didSet {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(EnterPwdViewController.tapLabel))
            showHiddenPasswordLabel.isUserInteractionEnabled = true
            showHiddenPasswordLabel.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    @IBOutlet weak var enterPasswordLabel: UILabel!
    @IBOutlet weak var inputFirstPasswordField: UITextField!
    
    // MARK: - lifecycle viewController metods

    override func viewDidLoad() {
        super.viewDidLoad()
        isRealmDBMissing = !CommonFuncs.isRealmDBPresent()
        if isRealmDBMissing {
            enterPasswordLabel.text = NSLocalizedString("SetPasswordLabelText", comment: "Header for set password label")
            inputFirstPasswordField.placeholder = NSLocalizedString("newPasswordPlaceHolderText1", comment: "Placeholder for new password textfield1")
            inputPasswordField.placeholder = NSLocalizedString("newPasswordPlaceHolderText2", comment: "Placeholder for new password textfield2")
            inputFirstPasswordField.isSecureTextEntry = isPasswordHidden
        } else {
            enterPasswordLabel.text = NSLocalizedString("EnterPasswordLabelText", comment: "Header for enter password label")
            inputFirstPasswordField.isHidden = true
        }
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
                let titleAlert = NSLocalizedString("UserErrorAlertTitle", comment: "Title user's error alert")
                let messageAlert = NSLocalizedString(isRealmDBMissing ? "ErrorEmptyPasswordsText" : "ErrorEmptyPasswordText", comment: "Error empty password")
                let alert = CommonFuncs.getAlert(title: titleAlert, message: messageAlert)
                self.present(alert, animated: true, completion: nil)
                return
            } else if isRealmDBMissing, let inputFirstPasswordStr = inputFirstPasswordField.text, inputFirstPasswordStr.isEmpty {
                    let titleAlert = NSLocalizedString("UserErrorAlertTitle", comment: "Title user's error alert")
                    let messageAlert = NSLocalizedString("ErrorEmptyPasswordsText", comment: "Error empty password")
                    let alert = CommonFuncs.getAlert(title: titleAlert, message: messageAlert)
                    self.present(alert, animated: true, completion: nil)
                    return
            }
            if isRealmDBMissing, let inputFirstPasswordStr = inputFirstPasswordField.text, inputPasswordStr != inputFirstPasswordStr {
                let titleAlert = NSLocalizedString("UserErrorAlertTitle", comment: "Title user's error alert")
                let textAlert = NSLocalizedString("NewPwdIsEqualErrorText", comment: "Text user's error new passwords are not equal")
                let alert = CommonFuncs.getAlert(title: titleAlert, message: textAlert)
                self.present(alert, animated: true, completion: nil)
                return

            }
            let isContainCorrectCharacters = inputPasswordStr.isContainCorrectCharactersForRealmPassword
            if !isContainCorrectCharacters.0 {
                let titleAlert = NSLocalizedString("UserErrorAlertTitle", comment: "Title user's error alert")
                let messageAlert = NSLocalizedString("ErrorIncorrectCharacterInPasswordText", comment: "Error incorrect character")
                let alert = CommonFuncs.getAlert(title: titleAlert, message: messageAlert + "\(isContainCorrectCharacters.1 + 1)")
                self.present(alert, animated: true, completion: nil)
                return
            }
            

            if !Secrets.share.dataAvailable {
                let resultInitDB = CommonFuncs.initRealmDB(inputPasswordStr: inputPasswordStr)
                if !resultInitDB.0 {
                    let titleAlert = NSLocalizedString("UserErrorAlertTitle", comment: "Title user's error alert")
                    let alert = CommonFuncs.getAlert(title: titleAlert, message: resultInitDB.1)
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                //Secrets.share.loadData()
                if Secrets.share.dataFirstReading {
                    if !CommonFuncs.readFromRealmDB() {
                        let titleAlert = NSLocalizedString("SystemErrorAlertTitle", comment: "Title system error alert")
                        let messageAlert = NSLocalizedString("ErrorReadingDBText", comment: "Error reading from DB")
                        let alert = CommonFuncs.getAlert(title: titleAlert, message: messageAlert)
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
