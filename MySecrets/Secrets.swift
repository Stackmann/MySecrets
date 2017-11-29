//
//  Secrets.swift
//  MySecrets
//
//  Created by Eric on 11/29/17.
//  Copyright © 2017 Piligrim. All rights reserved.
//

import Foundation
import UIKit

struct RecordPass: Codable {
    var describe : String
    var field1 : String
    var field2 : String
    var exp : Date
    var pass : String
    var avatar : Data
}

class Secrets {
    var list : [RecordPass]?
    
    init() {
        guard let avatar = UIImage(named: "error1") else { return }
        guard let avatarData = UIImagePNGRepresentation(avatar) else { return }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        guard let date1 = formatter.date(from: "2017/11/16 14:53") else { return }
        let firstPass = RecordPass(describe: "MyCard1", field1: "2222 3333 4444 5555", field2: "Eric", exp: date1, pass: "qwerty", avatar: avatarData)
        let secondPass = RecordPass(describe: "MyCard2", field1: "2222 3333 4444 5555", field2: "Eric", exp: date1, pass: "qwerty", avatar: avatarData)
        let thirdPass = RecordPass(describe: "MyCard3", field1: "2222 3333 4444 5555", field2: "Eric", exp: date1, pass: "qwerty", avatar: avatarData)

        self.list = [firstPass, secondPass, thirdPass]
        
    }
    
}
