//
//  PwdCollectionViewController.swift
//  MySecrets
//
//  Created by Eric on 11/30/17.
//  Copyright © 2017 EricsApp. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class PwdCollectionViewController: UICollectionViewController, UISearchResultsUpdating, PwdCollection {

    private var chosenRecordIndex = -1
    private var chosenFilteredRecordIndex = -1
    private var patternToCreate: PatternRecord?
    private var filteredList = [RecordPass]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true //very important thing, otherwise wont segue to modal and crash if pressed cancel button in searchbar

        searchController.searchBar.becomeFirstResponder()
        
        self.navigationItem.titleView = searchController.searchBar
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        NotificationCenter.default.addObserver(self, selector: #selector(editUpdateCollectionIfNeed), name: NSNotification.Name(rawValue: "editCurrentRecordEvent"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(deleteUpdateCollectionIfNeed), name: NSNotification.Name(rawValue: "deleteCurrentRecordEvent"), object: nil)

//        for family: String in UIFont.familyNames
//        {
//            print("\(family)")
//            for names: String in UIFont.fontNames(forFamilyName: family)
//            {
//                print("== \(names)")
//            }
//        }
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !Secrets.share.dataAvailable {
            performSegue(withIdentifier: "enterPwd", sender: nil)
        } else if let pattern = patternToCreate {
            switch pattern.kind {
            case .idcard:
                performSegue(withIdentifier: "editIdCardRecord", sender: nil)
            case .creditcard:
                performSegue(withIdentifier: "editCreditCardRecord", sender: nil)
            default:
                performSegue(withIdentifier: "editCommonRecord", sender: nil)
            }
            patternToCreate = nil
        } else if let searchPattern = searchController.searchBar.text, searchPattern == "" ||
            searchController.searchBar.text == nil {
            filteredList = Secrets.share.list
            chosenRecordIndex = -1
            self.collectionView!.reloadData()
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let chosenVC = segue.destination as? CreditCardViewController {
            chosenVC.chosenRecordIndex = chosenRecordIndex
        } else if let chosenVC = segue.destination as? IdCardViewController {
            chosenVC.chosenRecordIndex = chosenRecordIndex
        } else if let chosenVC = segue.destination as? CommonViewController {
            chosenVC.chosenRecordIndex = chosenRecordIndex
        } else if let chosenVC = segue.destination as? UINavigationController,
            let chosenCVC = chosenVC.topViewController as? PatternCollectionViewController {
            chosenCVC.delegat = self
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: nil, object: nil)
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "secretCell", for: indexPath) as! SecretCell
        if filteredList.indices.contains(indexPath.row){
            // Configure the cell
            let secret = filteredList[indexPath.row]
            if let image = UIImage(data: secret.avatar) {
                cell.configure(image: image, descr: secret.describe)
            }
        }

        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if filteredList.indices.contains(indexPath.row){
            // Configure the cell
            let secret = filteredList[indexPath.row]
            chosenFilteredRecordIndex = indexPath.row
            for (index, secretST) in Secrets.share.list.enumerated() {
                if secretST.num == secret.num {
                    chosenRecordIndex = index
                    break
                }
            }
            switch secret.idPattern {
            case "idcard" : performSegue(withIdentifier: "showIdCardRecord", sender: nil)
            case "creditcard" : performSegue(withIdentifier: "showCardRecord", sender: nil)
            default : performSegue(withIdentifier: "showCommonRecord", sender: nil)
            }
        }
    }
    

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    // MARK: PwdCollectionDelegate
    func getNewRecord(with pattern: PatternRecord) {
        patternToCreate = pattern
    }

    // MARK: - Search bar updater
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let lowerCasedQuery = searchController.searchBar.text?.lowercased() else { return }
        if lowerCasedQuery == "" {
            if filteredList.count != Secrets.share.list.count {
                filteredList = Secrets.share.list
                collectionView?.reloadSections([0])
            }
        } else {
            let filtered = Secrets.share.list.filter { recordPass -> Bool in
                let lowerCasedName = recordPass.describe.lowercased()
                return lowerCasedName.contains(lowerCasedQuery)
            }
            filteredList = filtered
            collectionView?.reloadSections([0])
        }
        
    }
    
    // MARK: - Actions
    
    @IBAction func openSettings(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showSettings", sender: nil)
    }

    @IBAction func addNewRecord(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addNewRecord", sender: nil)
    }
    
    // MARK: - own metods
    
    @objc private func editUpdateCollectionIfNeed() {
        if !CommonFuncs.saveToRealmDB() {
            let alert = CommonFuncs.getAlert(title: "Error", message: "Error saving to DB. Try to reinstall aplication!")
            self.present(alert, animated: true, completion: nil)
        }
        if let lowerCasedQuery = searchController.searchBar.text?.lowercased(), lowerCasedQuery != "" {
            updateSearchResults(for: searchController)
        } else if chosenRecordIndex >= 0, chosenFilteredRecordIndex >= 0 {
            let currentRecord = Secrets.share.list[chosenRecordIndex]
            filteredList[chosenFilteredRecordIndex] = currentRecord
            collectionView?.reloadSections([0])
        }
    }

    @objc private func deleteUpdateCollectionIfNeed() {
        if !CommonFuncs.saveToRealmDB() {
            let alert = CommonFuncs.getAlert(title: "Error", message: "Error saving to DB. Try to reinstall aplication!")
            self.present(alert, animated: true, completion: nil)
        }
        if let lowerCasedQuery = searchController.searchBar.text?.lowercased(), lowerCasedQuery != "" {
            updateSearchResults(for: searchController)
        } else if chosenRecordIndex >= 0, chosenFilteredRecordIndex >= 0 {
            filteredList = Secrets.share.list
            chosenRecordIndex = -1
            collectionView?.reloadSections([0])
        }
    }
}

protocol PwdCollection {
    func getNewRecord(with pattern: PatternRecord)
}
