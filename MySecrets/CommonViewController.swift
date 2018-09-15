//
//  CommonViewController.swift
//  MySecrets
//
//  Created by User on 8/1/18.
//  Copyright © 2018 Piligrim. All rights reserved.
//

import UIKit

class CommonViewController: UIViewController {
    var chosenRecordIndex: Int = -1
    var maxRowOfLabelCount = 6
    
    @IBOutlet weak var descriptionValue: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label1Value: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label2Value: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label3Value: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label4Value: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label5Value: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var patternImageView: UIImageView!
    @IBOutlet weak var label6Value: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(deleteReturnToMainList), name: NSNotification.Name(rawValue: "deleteCurrentRecordEvent"), object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        configureController()
    }

    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.closeActivityController), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.openactivity), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)

    }

    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let chosenNC = segue.destination as? UINavigationController {
            if let chosenVC = chosenNC.topViewController as? CommonEditTableViewController {
                chosenVC.chosenRecordIndex = chosenRecordIndex
            }
        }
    }

    // MARK: - add metodes
    
    func configureController() {
        if chosenRecordIndex >= 0, Secrets.share.list.indices.contains(chosenRecordIndex)  {
            let chosenRecord = Secrets.share.list[chosenRecordIndex]
            
            descriptionValue.text = chosenRecord.describe
            descriptionValue.textColor = UIColor.white
            
            if let pattern = Patterns.share.list[chosenRecord.idPattern] {
                let labels = [label1, label2, label3, label4, label5, label6, label1Value, label2Value, label3Value, label4Value, label5Value, label6Value]
                var count = 0
                for patternField in pattern.fields {
                    labels[count]?.text = pattern.localizedFields[patternField]
                    labels[count]?.textColor = UIColor.white
                    count += 1
                }
                count = 0
                for patternField in pattern.fields {
                    if let typeField = pattern.typesOfFields[patternField] {
                        if typeField == "String", let valueStr = chosenRecord.stringFields[patternField] {
                            labels[count + maxRowOfLabelCount]?.textAlignment = NSTextAlignment.left
                            labels[count + maxRowOfLabelCount]?.text = valueStr
                            labels[count + maxRowOfLabelCount]?.textColor = UIColor.yellow
                        } else if typeField == "Int", let valueInt = chosenRecord.decimalFields[patternField] {
                            labels[count + maxRowOfLabelCount]?.textAlignment = NSTextAlignment.left
                            labels[count + maxRowOfLabelCount]?.text = "\(valueInt)"
                            labels[count + maxRowOfLabelCount]?.textColor = UIColor.yellow
                        } else {
                            labels[count + maxRowOfLabelCount]?.text = ""
                        }
                    }
                    count += 1
                }
                while count < maxRowOfLabelCount {
                    labels[count]?.isHidden = true
                    labels[count + maxRowOfLabelCount]?.isHidden = true
                    count += 1
                }
                if let image = UIImage(data: pattern.avatar) {
                    patternImageView.image = image
                }
            }

        }
    }

    @objc private func deleteReturnToMainList() {
        navigationController?.popToRootViewController(animated: true)
    }

    @IBAction func editAction(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showCommonEditController", sender: nil)
    }

    @objc private func closeActivityController()  {
        Secrets.share.dataAvailable = false
    }
    
    @objc private func openactivity()  {
        if !Secrets.share.dataAvailable {
            performSegue(withIdentifier: "enterPwd", sender: nil)
        }
    }
}
