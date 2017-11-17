//
//  ViewController.swift
//  MySecrets
//
//  Created by Eric on 11/17/17.
//  Copyright © 2017 Piligrim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let arrayInt : Array<Int> = [100,250,410,7,19]
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(arrayInt) {
            print(encoded)
        }
        
        guard let avatar = UIImage(named: "error1") else { return }
        guard let avatarData = UIImagePNGRepresentation(avatar) else { return }
        var arrayRecords : Array<RecordPass> = []
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        guard let date1 = formatter.date(from: "2017/11/16 14:53") else { return }
        let firstPass = RecordPass(describe: "MyCard1", field1: "2222 3333 4444 5555", field2: "Eric", exp: date1, pass: "qwerty", avatar: avatarData)
        let secondPass = RecordPass(describe: "MyCard2", field1: "2222 3333 4444 5555", field2: "Eric", exp: date1, pass: "qwerty", avatar: avatarData)
        let thirdPass = RecordPass(describe: "MyCard3", field1: "2222 3333 4444 5555", field2: "Eric", exp: date1, pass: "qwerty", avatar: avatarData)
        arrayRecords.append(firstPass)
        arrayRecords.append(secondPass)
        arrayRecords.append(thirdPass)
        
        if let encoded = try? encoder.encode(arrayRecords) {
            print(encoded)
        }

    }

    struct RecordPass: Codable {
        var describe : String
        var field1 : String
        var field2 : String
        var exp : Date
        var pass : String
        var avatar : Data
    }

}

