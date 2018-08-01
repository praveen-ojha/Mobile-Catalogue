//
//  MVPCollectionViewController.swift
//  Mobile Catalogue
//
//  Created by Praveen Ojha on 31/7/18.
//  Copyright © 2018 Praveen Ojha. All rights reserved.
//

import UIKit

private let reuseIdentifier = "mvpCustomCell"

class MVPCollectionViewController: UICollectionViewController {
    
    let mvpData = [
            [MVPModel(imageName: "Security", txtLabel: "Security", bgColor: "F2F3F4", fgColor: "373D3F"),MVPModel(imageName: "Information", txtLabel: "Information", bgColor: "0C374D", fgColor: "EFD469")],
            [MVPModel(imageName: "Transactions", txtLabel: "Transactions", bgColor: "C02F1D", fgColor: "FFFFFF"),MVPModel(imageName: "Services", txtLabel: "Services", bgColor: "B5C689", fgColor: "FFFFFF")]
    ]

    // BG: F2F3F4 / FG: 373D3F
    // 0C374D/EFD469
    // C02F1D / FFFFFF
    //B5C689 / FFFFFF
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        //collectionView?.register(MVPCollectionViewCell.self, forCellWithReuseIdentifier: "mvpCustomCell")
        collectionView?.register(UINib(nibName: "MVPCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MVPCollectionViewCell
    
        //configure the cell
        cell.configure(with: mvpData[indexPath.section][indexPath.row])
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item selected,\(indexPath)")
    }

    // MARK: UICollectionViewDelegate

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

}
