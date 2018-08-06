//
//  MVPCollectionViewController.swift
//  Mobile Catalogue
//
//  Created by Praveen Ojha on 31/7/18.
//  Copyright © 2018 Praveen Ojha. All rights reserved.
//

import UIKit
import Foundation
import CoreData
import FirebaseDatabase
import SVProgressHUD

private let reuseIdentifier = "mvpCustomCell"

class MVPCollectionViewController: UICollectionViewController, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    //Core data context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //var isTransitionedToChild = false
    
    let transition = BubbleTransition()
    
    var transitionCenter = CGPoint(x: 0, y: 0)
    var selectedItemBgColor: String = "FFFFFF"
    
    //HardCoded Data
//    let mvpData = [
//            [MVPModel(imageName: "Security", title: "Security", bgColor: "F2F3F4", fgColor: "373D3F"),MVPModel(imageName: "Information", title: "Information", bgColor: "0C374D", fgColor: "EFD469")],
//            [MVPModel(imageName: "Transactions", title: "Transactions", bgColor: "C02F1D", fgColor: "FFFFFF"),MVPModel(imageName: "Services", title: "Services", bgColor: "B5C689", fgColor: "FFFFFF")]
//    ]
    
    var mvpData = [[MVP]]()
    
    var mvps = [MVP]()

    // BG: F2F3F4 / FG: 373D3F
    // 0C374D/EFD469
    // C02F1D / FFFFFF
    //B5C689 / FFFFFF
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        // Register cell classes
        collectionView?.register(UINib(nibName: "MVPCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        loadMVPs()
        
        self.navigationController?.delegate = self
        // Do any additional setup after loading the view.
        
        //MARK: Added swipe down gesture
        let down = UISwipeGestureRecognizer(target : self, action : #selector(self.downSwipe))
        down.direction = .down
        down.numberOfTouchesRequired = 3
        collectionView?.addGestureRecognizer(down)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateNavBar(withHexCode: "D4D4D4", withTitleHexCode: "555555")
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
            controller.view.backgroundColor = UIColor(hexString: mvpData[indexPath.section][indexPath.row].backgroundColor!)
            updateNavBar(withHexCode: mvpData[indexPath.section][indexPath.row].backgroundColor!, withTitleHexCode: mvpData[indexPath.section][indexPath.row].foregroundColor!)
        }
        
        
        //TODO:- need to understand interactiveTransition.attach(to: controller)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        //return 2
        
        let sectionNum: Int = mvps.count / 2
        if sectionNum == 0 {
            let title = UILabel(frame: CGRect(x: 0, y: 20, width: 200, height: 40))
            title.textColor = UIColor.black
            title.text = "No Data available!!"
            title.textAlignment = .center
            
//            let button = UIButton(type: .roundedRect) // let preferred over var here
//            button.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
//            button.backgroundColor = UIColor.lightGray
//            //button.setTitleColor(UIColor.blue, for: .normal)
//            button.setTitle("Synch", for: .normal)
//            button.tintColor = UIColor.black
//
//            button.addTarget(self, action: #selector(buttonTapAction(_:)), for: .touchUpInside)
//            self.view.addSubview(button)
            collectionView.addSubview(title)
        }
        return sectionNum
        
    }
    
    @objc func buttonTapAction(_ sender:UIButton!)
    {
        //print("Button is working")
    }
    
    @objc func downSwipe(){
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Are you sure!", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Code", style: .default){ (action) in
            SVProgressHUD.show(withStatus: "checking...")
            let code = textField.text!
            if code != "neurocysticercosis" {
                //Wrong alert
                let failAlert = UIAlertController(title: "Hard luck!", message: "", preferredStyle: .alert)
                let failAlertAction = UIAlertAction(title: ":(", style: .default){ (action) in
                    //do nothing
                }
                    failAlert.addAction(failAlertAction)
                self.present(failAlert, animated: true, completion: nil)
                SVProgressHUD.dismiss()
            } else {
                //Data Synch process
                self.dataSynch()
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "code"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MVPCollectionViewCell
        
        //configure the cell
        cell.configure(with: mvpData[indexPath.section][indexPath.row])
        
        //MARK: - One time job to push data into table uncomment below for preparation of data
//        let mvp = MVP(context: context)
//        mvp.title = mvpData[indexPath.section][indexPath.row].title
//        mvp.icon = mvpData[indexPath.section][indexPath.row].imageName
//        mvp.foregroundColor = mvpData[indexPath.section][indexPath.row].fgColor
//        mvp.backgroundColor = mvpData[indexPath.section][indexPath.row].bgColor
//        saveMVPs()
        
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
            transition.transitionMode = .present
            transition.bubbleColor = UIColor(hexString: selectedItemBgColor)
            transition.startingPoint = transitionCenter
        default:
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
    
    //MARK: - core data methods to save and retrieve data
    func saveMVPs() {
        do {
            try context.save()
        } catch {
            print ("Error saving data,\(error)")
        }
    }
    
    func loadMVPs() {
        let request: NSFetchRequest<MVP> = MVP.fetchRequest()
        do {
            mvps = try context.fetch(request)
            if mvps.count == 0 {
                return
            }
            var dataCtr = -1
            for ctr in 1...mvps.count {
                if ctr % 2 != 0 {
                    mvpData.append([])
                    dataCtr = dataCtr + 1
                }
                mvpData[dataCtr].append(mvps[ctr-1])
            }
        } catch {
            print ("Error retrieving MVPs,\(error)")
        }
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
    
    //MARK: - Pushing data from cloud
    func dataSynch() {
        
        //cleaning DB first
        for ctr in 0..<mvps.count {
            let mvp = mvps[ctr]
            //TODO: first get the features deleted
            //By right if the MVP is deleted then child should also get deleted - check this
            context.delete(mvp)
        }
        
        let mvpDB = Database.database().reference().child("MVP")
        mvpDB.observe(.childAdded) { (snapshot) in
            let snapShotValue = snapshot.value as! Dictionary<String,String>
            let mvp : MVP = MVP(context: self.context)
            mvp.title = snapShotValue["title"]!
            mvp.icon = snapShotValue["icon"]!
            mvp.foregroundColor = snapShotValue["foregroundColor"]!
            mvp.backgroundColor = snapShotValue["backgroundColor"]
            
            //SOMEWHERE HERE TO FETCH THE FEATURES
            let featureDB = Database.database().reference().child(mvp.title!)
            featureDB.observe(.childAdded){ (featureSnapshot) in
                let featureSSValue = featureSnapshot.value as! Dictionary<String,String>
                let feature : Feature = Feature(context: self.context)
                feature.name = featureSSValue["name"]
                feature.platform = featureSSValue["platform"]
                feature.detail = featureSSValue["detail"]
                feature.parentMVP = mvp
                self.saveMVPs()
            }
            
            self.saveMVPs()
        }
        SVProgressHUD.dismiss(withDelay: 5)
    }

}
