//
//  SecretEditTableViewController.swift
//  MySecrets
//
//  Created by Eric on 12/20/17.
//  Copyright © 2017 Piligrim. All rights reserved.
//

import UIKit

class CreditCardEditTableViewController: UITableViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var bankTextField: UITextField!
    @IBOutlet weak var cardNumberField: UITextField!
    @IBOutlet weak var expiredField: UITextField!
    @IBOutlet weak var cvvField: UITextField!
    @IBOutlet weak var pinField: UITextField!
    @IBOutlet weak var holderField: UITextField!
    @IBOutlet weak var notesField: UITextField!

    var chosenRecordIndex: Int!
    private let datePicker = UIDatePicker()

    // MARK: lifecycle metods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        if chosenRecordIndex >= 0 {
            configure()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.tintColor = UIColor.blue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }

    // MARK: - Actions

    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - self metods
    
    func setupUI() {
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        cardNumberField.keyboardType = .decimalPad
        datePicker.datePickerMode = .date
        expiredField.inputView = datePicker
        expiredField.inputAccessoryView = returnToolBar()
        cvvField.keyboardType = .decimalPad
        pinField.keyboardType = .decimalPad
    }
    
    func configure() {
        if let arraySecrets = Secrets.share.list, arraySecrets.indices.contains(chosenRecordIndex){
            // Configure the tableView
            let secret = arraySecrets[chosenRecordIndex]
            if let image = UIImage(data: secret.avatar) {
                avatarImageView.image = image
            }
            descriptionField.text = secret.describe
            bankTextField.text = secret.stringFields["Bank"]
            cardNumberField.text = secret.stringFields["NumberCard"]
            //expiredField.text = secret.dateFields["Expired"]
            if let cvv = secret.decimalFields["CVV"] {
                cvvField.text = "\(cvv)"
            }
            if let pin = secret.decimalFields["PIN"] {
                pinField.text = "\(pin)"
            }
            holderField.text = secret.stringFields["Holder"]
            notesField.text = secret.stringFields["Notes"]
        }
    }

    private func returnToolBar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        //        toolBar.sizeToFit()
        toolBar.frame = CGRect(x: toolBar.frame.origin.x,
                               y: toolBar.frame.origin.y,
                               width: toolBar.frame.width,
                               height: 32)
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Готово",
                                         style: .plain,
                                         target: self,
                                         action: #selector(self.updateChosenDate))
        
        doneButton.tintColor = UIColor.green
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
    @objc private func updateChosenDate() {
        expiredField.resignFirstResponder()
        
        let chosenDate = datePicker.date
        print(chosenDate)
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        let chosenDateString = formatter.string(from: chosenDate)
        
        expiredField.text = chosenDateString
    }

}
