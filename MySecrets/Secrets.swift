//
//  Secrets.swift
//  MySecrets
//
//  Created by Eric on 11/29/17.
//  Copyright © 2017 Piligrim. All rights reserved.
//

import Foundation
import UIKit

struct RecordPass {
    var describe : String
    var field1 : String
    var field2 : String
    var exp : Date
    var pass : String
    var avatar : UIImage
}

//struct RecordPass: Codable {
//    var describe : String
//    var field1 : String
//    var field2 : String
//    var exp : Date
//    var pass : String
//    var avatar : Data
//}

class Secrets {
    static let share = Secrets()
    
    var list : [RecordPass]?
    
    func loadData() {
        if var arrayOfSecrets = list { arrayOfSecrets.removeAll() }
        
        guard let avatar1 = UIImage(named: "if_credit_card_49367") else { return }
        guard let avatar2 = UIImage(named: "if_credit-cards_47679") else { return }
        guard let avatar3 = UIImage(named: "if_lock_49374") else { return }
        //guard let avatarData = UIImagePNGRepresentation(avatar) else { return }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        guard let date1 = formatter.date(from: "2017/11/16 14:53") else { return }
        let firstPass = RecordPass(describe: "MyCard1", field1: "2222 3333 4444 5555", field2: "Eric", exp: date1, pass: "qwerty", avatar: avatar1)
        let secondPass = RecordPass(describe: "MyCard2", field1: "2222 3333 4444 5555", field2: "Eric", exp: date1, pass: "qwerty", avatar: avatar2)
        let thirdPass = RecordPass(describe: "MyCard3", field1: "2222 3333 4444 5555", field2: "Eric", exp: date1, pass: "qwerty", avatar: avatar3)
        
        //list = [firstPass, secondPass, thirdPass]
        list = [firstPass, secondPass]
    }
    
}
