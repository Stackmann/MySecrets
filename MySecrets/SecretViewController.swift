//
//  SecretViewController.swift
//  MySecrets
//
//  Created by Eric on 12/22/17.
//  Copyright © 2017 Piligrim. All rights reserved.
//

import UIKit

class SecretViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBOutlet weak var recordImageView: UIImageView!
    
    override func viewWillLayoutSubviews() {
        recordImageView.contentMode = .scaleAspectFit
    }
}
