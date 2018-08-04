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
    var maxRowOfLabelCount = 5
    
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
    @IBOutlet weak var patternImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        configureController()
    }

    // MARK: - add metodes
    
    func configureController() {
        if chosenRecordIndex >= 0, Secrets.share.list.indices.contains(chosenRecordIndex)  {
            let chosenRecord = Secrets.share.list[chosenRecordIndex]
            
            descriptionValue.text = chosenRecord.describe
            descriptionValue.textColor = UIColor.white
            
            if let patern = Patterns.share.list[chosenRecord.idPattern] {
                let labels = [label1, label2, label3, label4, label5, label1Value, label2Value, label3Value, label4Value, label5Value]
                var count = 0
                for patternField in patern.fields {
                    labels[count]?.text = patternField.key
                    labels[count]?.textColor = UIColor.white
                    if patternField.value == "String", let valueStr = chosenRecord.stringFields[patternField.key] {
                        labels[count + maxRowOfLabelCount]?.textAlignment = NSTextAlignment.left
                        labels[count + maxRowOfLabelCount]?.text = valueStr
                        labels[count + maxRowOfLabelCount]?.textColor = UIColor.yellow
                    } else {
                        labels[count + maxRowOfLabelCount]?.text = ""
                    }
                    count += 1
                }
                while count < maxRowOfLabelCount {
                    labels[count]?.isHidden = true
                    labels[count + maxRowOfLabelCount]?.isHidden = true
                    count += 1
                }
                if let image = UIImage(data: patern.avatar) {
                    patternImageView.image = image
                }
            }

        }
    }
    
}
