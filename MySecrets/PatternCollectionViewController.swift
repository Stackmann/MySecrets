//
//  PatternCollectionViewController.swift
//  MySecrets
//
//  Created by Eric on 1/30/18.
//  Copyright © 2018 Piligrim. All rights reserved.
//

import UIKit

private let reuseIdentifier = "patternCell"

class PatternCollectionViewController: UICollectionViewController {
    
    var listPatterns = Array(Patterns.share.list.values)
    var delegat: PwdCollection?

    // MARK: - lifecycle viewController metods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(UINib(nibName: "PwdCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.tintColor = UIColor.blue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }

    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.closeActivityController), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.openactivity), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return listPatterns.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PwdCollectionViewCell
        let pattern = listPatterns[indexPath.row]
        cell.configure(with: pattern)
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if listPatterns.indices.contains(indexPath.row) {
            // Configure the cell
            let pattern = listPatterns[indexPath.row]
            delegat?.getNewRecord(with: pattern)
        }
        dismiss(animated: true, completion: nil)
    }

    // MARK: - actions

    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - self metods

    @objc private func closeActivityController()  {
        Secrets.share.dataAvailable = false
    }
    
    @objc private func openactivity()  {
        if !Secrets.share.dataAvailable {
            performSegue(withIdentifier: "enterPwd", sender: nil)
        }
    }

}
