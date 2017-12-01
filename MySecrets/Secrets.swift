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
    static let share = Secrets()
    
    var list : [RecordPass]?
    
    func loadData() {
        if var arrayOfSecrets = list { arrayOfSecrets.removeAll() }
        
        guard let avatar1 = UIImage(named: "if_credit_card_49367") else { return }
        guard let avatar2 = UIImage(named: "if_credit-cards_47679") else { return }
        guard let avatar3 = UIImage(named: "if_lock_49374") else { return }
        guard let avatar4 = UIImage(named: "if_secure-payment_47685") else { return }
        guard let avatar5 = UIImage(named: "if_user_info_49399") else { return }
        guard let avatarData1 = UIImagePNGRepresentation(avatar1) else { return }
        guard let avatarData2 = UIImagePNGRepresentation(avatar2) else { return }
        guard let avatarData3 = UIImagePNGRepresentation(avatar3) else { return }
        guard let avatarData4 = UIImagePNGRepresentation(avatar4) else { return }
        guard let avatarData5 = UIImagePNGRepresentation(avatar5) else { return }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        guard let date1 = formatter.date(from: "2017/11/16 14:53") else { return }
        let firstPass = RecordPass(describe: "MyCard1", field1: "2222 3333 4444 5555", field2: "Eric", exp: date1, pass: "qwerty", avatar: avatarData1)
        let secondPass = RecordPass(describe: "MyCard2", field1: "2222 3333 4444 5555", field2: "Eric", exp: date1, pass: "qwerty", avatar: avatarData2)
        let thirdPass = RecordPass(describe: "MyCard3", field1: "2222 3333 4444 5555", field2: "Eric", exp: date1, pass: "qwerty", avatar: avatarData3)
        let fourPass = RecordPass(describe: "Ключ от хаты", field1: "2222 3333 4444 5555", field2: "Eric", exp: date1, pass: "qwerty", avatar: avatarData4)
        let fivePass = RecordPass(describe: "Удостоверение", field1: "2222 3333 4444 5555", field2: "Eric", exp: date1, pass: "qwerty", avatar: avatarData5)

        list = [firstPass, secondPass, thirdPass, fourPass, fivePass]
        
        //        let encoder = JSONEncoder()
        
        //        if let encoded = try? encoder.encode(mySecrets.list) {
        //            print(encoded)
        //        }

    }
    
}
