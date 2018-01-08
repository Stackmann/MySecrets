//
//  SecretViewController.swift
//  MySecrets
//
//  Created by Eric on 12/22/17.
//  Copyright © 2017 Piligrim. All rights reserved.
//

import UIKit

class CreditCardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureController()
        //OCRAStd
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureController() {
        cardNumber.textAlignment = NSTextAlignment.left
        cardNumber.text = "1111 2222 3333 4444"
        cardNumber.font = UIFont(name: "OCRAStd", size: 35)
        cardNumber.textColor = UIColor.white
        
        validDate.textAlignment = NSTextAlignment.left
        validDate.text = "06/23"
        validDate.font = UIFont(name: "OCRAStd", size: 20)
        validDate.textColor = UIColor.white
        
        cardHolder.textAlignment = NSTextAlignment.left
        cardHolder.text = "ОЛЕГ ЯРОШЕНКО"
        cardHolder.font = UIFont(name: "OCRAStd", size: 20)
        cardHolder.textColor = UIColor.white

    }
    
    @IBOutlet weak var recordImageView: UIImageView!
    @IBOutlet weak var cardNumber: UILabel!
    @IBOutlet weak var validDate: UILabel!
    @IBOutlet weak var cardHolder: UILabel!
    
}
