//
//  PwdCollectionViewController.swift
//  MySecrets
//
//  Created by Eric on 11/30/17.
//  Copyright © 2017 EricsApp. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class PwdCollectionViewController: UICollectionViewController, UISearchResultsUpdating {

    private var chosenRecordIndex = -1
    private var chosenFilteredRecordIndex = -1
    private var filteredList = [RecordPass]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.becomeFirstResponder()
        
        self.navigationItem.titleView = searchController.searchBar
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
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
        } else if let searchPattern = searchController.searchBar.text, searchPattern == "" ||
            searchController.searchBar.text == nil {
            filteredList = Secrets.share.list
            chosenRecordIndex = -1
            self.collectionView!.reloadData()
        }

    }

    
    @IBAction func openSettings(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showSettings", sender: nil)
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
            case "id" : performSegue(withIdentifier: "showIdRecord", sender: nil)
            case "creditcard" : performSegue(withIdentifier: "showCardRecord", sender: nil)
            default : performSegue(withIdentifier: "showCommonRecord", sender: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let chosenVC = segue.destination as? CreditCardViewController {
            chosenVC.chosenRecordIndex = chosenRecordIndex
        } else if let chosenVC = segue.destination as? IdCardViewController {
            chosenVC.chosenRecordIndex = chosenRecordIndex
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
}
