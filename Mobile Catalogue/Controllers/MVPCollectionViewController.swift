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
    
    @IBOutlet weak var transitionBtn: UIButton!
    var isPresenting: Bool = true
    
    let transition = BubbleTransition()
    let interactiveTransition = BubbleInteractiveTransition()
    
    var transitionCenter = CGPoint(x: 0, y: 0)
    var selectedItemBgColor: String = "FFFFFF"
    
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

        self.navigationController?.delegate = self
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

        guard let selectedCell = collectionView.cellForItem(at: indexPath) else { fatalError() }
        
        transitionCenter = selectedCell.center
        
        selectedItemBgColor = ((selectedCell as! MVPCollectionViewCell).cellView.backgroundColor?.toHexString())!
        
        performSegue(withIdentifier: "goToFeature", sender: self)
    
//        let storyboard = UIStoryboard(name:"Main", bundle:nil)
//        let viewcontroller = storyboard.instantiateViewController(withIdentifier: "FeatureTableViewController")
//        viewcontroller.transitioningDelegate = self
//        viewcontroller.modalPresentationStyle = .custom
//        self.show(viewcontroller, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .custom
        //interactiveTransition.attach(to: controller)
    }
    
    // MARK: UIViewControllerTransitioningDelegate
    
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        isPresenting = true
//        transition.transitionMode = .present
//        transition.startingPoint = transitionBtn.center //transitionButton.center
//        transition.bubbleColor = UIColor.red// transitionButton.backgroundColor!
//        return transition
//    }
//
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        isPresenting = false
//        transition.transitionMode = .dismiss
//        transition.startingPoint = transitionBtn.center
//        transition.bubbleColor = UIColor.red// transitionButton.backgroundColor!
//        return transition
//    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = transitionCenter //transitionButton.center
        transition.bubbleColor = UIColor(hexString: selectedItemBgColor)
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
