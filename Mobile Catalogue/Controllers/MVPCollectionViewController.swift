//
//  MVPCollectionViewController.swift
//  Mobile Catalogue
//
//  Created by Praveen Ojha on 31/7/18.
//  Copyright © 2018 Praveen Ojha. All rights reserved.
//

import UIKit
import Foundation


private let reuseIdentifier = "mvpCustomCell"

class MVPCollectionViewController: UICollectionViewController, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    var isTransitionedToChild = false
    
    let transition = BubbleTransition()
    
    var transitionCenter = CGPoint(x: 0, y: 0)
    var selectedItemBgColor: String = "FFFFFF"
    
    let mvpData = [
            [MVPModel(imageName: "Security", title: "Security", bgColor: "F2F3F4", fgColor: "373D3F"),MVPModel(imageName: "Information", title: "Information", bgColor: "0C374D", fgColor: "EFD469")],
            [MVPModel(imageName: "Transactions", title: "Transactions", bgColor: "C02F1D", fgColor: "FFFFFF"),MVPModel(imageName: "Services", title: "Services", bgColor: "B5C689", fgColor: "FFFFFF")]
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
        collectionView?.register(UINib(nibName: "MVPCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        self.navigationController?.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateNavBar(withHexCode: "D4D4D4", withTitleHexCode: "555555")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("view disappeared bhai")
    }
//    //MARK: - Nav Bar Setup Methods
    func updateNavBar(withHexCode colorHexCode: String, withTitleHexCode titleColorHexCode: String){
        guard let navBar = navigationController?.navigationBar else {fatalError("Navigation controller doesnot exist")}
        navBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor(hexString: titleColorHexCode)]
        let navBarColour = UIColor(hexString: colorHexCode)
        navBar.barTintColor = navBarColour
        navBar.tintColor = UIColor(hexString: titleColorHexCode)
        
//                //        navBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor(hexString: titleColorHexCode)]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! FeatureTableViewController
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .custom
        //self.modalPresentationStyle = .fullScreen
        
        if let indexPath = collectionView?.indexPathsForSelectedItems?.first {
            controller.selectedMVP = mvpData[indexPath.section][indexPath.row]
            controller.view.backgroundColor = UIColor(hexString: mvpData[indexPath.section][indexPath.row].bgColor)
            updateNavBar(withHexCode: mvpData[indexPath.section][indexPath.row].bgColor, withTitleHexCode: mvpData[indexPath.section][indexPath.row].fgColor)
        }
        
        
        //TODO:- need to understand interactiveTransition.attach(to: controller)
    }

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

        guard let selectedCell = collectionView.cellForItem(at: indexPath) else { fatalError() }
        
        transitionCenter = selectedCell.center
        
        selectedItemBgColor = ((selectedCell as! MVPCollectionViewCell).cellView.backgroundColor?.toHexString())!
        
        performSegue(withIdentifier: "goToFeature", sender: self)
    }
    
    //MARK: - Animation
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        if !isTransitionedToChild {
        switch operation {
        case .push:
            print("push")
            transition.transitionMode = .present
            transition.bubbleColor = UIColor(hexString: selectedItemBgColor)
            transition.startingPoint = transitionCenter
        default:
            print("default")
            transition.transitionMode = .pop
            //transition.bubbleColor = UIColor(hexString: "D4D4D4")
            transition.bubbleColor = UIColor(hexString: selectedItemBgColor)
            transition.startingPoint = transitionCenter//CGPoint(x: 10, y: 10)
        }
        
//        } else {
//
//        }

//        isTransitionedToChild = !isTransitionedToChild
         //transitionButton.center

        return transition
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
