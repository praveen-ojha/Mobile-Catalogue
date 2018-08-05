//
//  FeatureViewController.swift
//  Mobile Catalogue
//
//  Created by Praveen Ojha on 1/8/18.
//  Copyright © 2018 Praveen Ojha. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "featureCell"

class FeatureTableViewController: AccordionTableViewController {
    
    var alreadyExpandedCell: AccordionTableViewCell?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

//    let securityData = [
//        FeatureModel(title: "User Id/Password Login", tech: "Native", content: ""),
//        FeatureModel(title: "Biometrics Login", tech: "Native", content: ""),
//        FeatureModel(title: "Card Activation", tech: "Native", content: ""),
//        FeatureModel(title: "Retrieve User Id", tech: "Native", content: ""),
//        FeatureModel(title: "Password Reset", tech: "Native", content: ""),
//        FeatureModel(title: "Enhanced Face Id", tech: "Angular", content: ""),
//        FeatureModel(title: "Enhanced Biometric", tech: "Angular", content: ""),
//        FeatureModel(title: "OTP - SoftToken", tech: "Native", content: ""),
//        FeatureModel(title: "Push Notification", tech: "Angular", content: ""),
//        FeatureModel(title: "User Id/Password Login", tech: "Native", content: "")
//        ]
//
//    let informationData = [
//        FeatureModel(title: "Accounts Dashboard", tech: "Native", content: ""),
//        FeatureModel(title: "Account Details", tech: "Native", content: ""),
//        FeatureModel(title: "Account Activities", tech: "Native", content: ""),
//        FeatureModel(title: "Credit Card Details", tech: "Angular", content: ""),
//        FeatureModel(title: "Credit Card Transactions", tech: "Angular", content: ""),
//        FeatureModel(title: "Loan On Phone", tech: "Angular", content: ""),
//        FeatureModel(title: "Rewards Summary", tech: "Angular", content: ""),
//        FeatureModel(title: "Loan Account Summary", tech: "Native", content: ""),
//        FeatureModel(title: "Time Deposit Summary", tech: "Angular", content: "")
//    ]
//
//    let txnData = [
//        FeatureModel(title: "Pay to Cards (Self and Other Bank Owned)", tech: "Native", content: ""),
//        FeatureModel(title: "Bill Payment", tech: "Native", content: ""),
//        FeatureModel(title: "Repay Loans", tech: "Native", content: ""),
//        FeatureModel(title: "Transfer Between Own Accounts", tech: "Native", content: ""),
//        FeatureModel(title: "Domestic Transfers - Citi Accounts", tech: "Native", content: ""),
//        FeatureModel(title: "Domestic Transfers - Outside Citi", tech: "Native", content: ""),
//        FeatureModel(title: "International Transfers", tech: "Native", content: "")
//        ]
//
//    let svcData = [
//        FeatureModel(title: "Card Activation", tech: "Angular", content: ""),
//        FeatureModel(title: "Notification Enrollment", tech: "Hybrid", content: ""),
//        FeatureModel(title: "XXXXXXXXXXX", tech: "Hybrid", content: "")
//    ]
    
//    var features = [FeatureModel]()
    
    var features = [Feature]()
    
    var selectedMVP: MVP? {
        didSet {
            //1. For Hardcoded data in file
//            if selectedMVP!.title == "Services" {
//                features = svcData
//            } else if selectedMVP!.title == "Transactions" {
//                features = txnData
//            } else if selectedMVP!.title == "Information" {
//                features = informationData
//            } else {
//                features = securityData
//            }
            // 2. Data from CoreData
            loadFeatures()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "FeatureCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationItem.title = selectedMVP?.title
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return features.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "featureCell", for: indexPath) as! FeatureCell

        
         //Configure the cell...
        cell.headerView.backgroundColor = UIColor(hexString: selectedMVP!.backgroundColor!)
        cell.txtTitle.textColor = UIColor(hexString: selectedMVP!.foregroundColor!)
        cell.txtTechnology.textColor = UIColor(hexString: selectedMVP!.foregroundColor!)
        cell.detailView.backgroundColor = UIColor(hexString: selectedMVP!.foregroundColor!)
        cell.detailText.textColor = UIColor(hexString: selectedMVP!.backgroundColor!)
        
        let feature = features[indexPath.row]
        
        cell.txtTitle.text = feature.name
        cell.txtTechnology.text = feature.platform
        cell.detailText.text = feature.detail
        
        //MARK: - HARDCODED FEATURES ONE TIME DATA PUSH - UNCOMMENT BELOW and Run once for all available MVPs
//        let newFeature = Feature(context: context)
//        newFeature.name = feature.title
//        newFeature.platform = feature.tech
//        newFeature.detail = "This section will list all details about " + feature.title
//        newFeature.parentMVP = selectedMVP
//        saveFeatures()
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return expandedIndexPaths.contains(indexPath) ? 150.0 : 50.0
    }
    
    //MARK: - CoreData Load and Save features
    func saveFeatures() {
        do {
            try context.save()
        } catch {
            print ("Error saving features,\(error)")
        }
    }
    
    func loadFeatures() {
        
        let predicate =  NSPredicate(format: "parentMVP.title MATCHES %@", selectedMVP!.title!)
        
        let request: NSFetchRequest<Feature> = Feature.fetchRequest()
        request.predicate = predicate
        
        //Adding Predicate
        
        
        do {
            features = try context.fetch(request)
        } catch {
            print ("Error saving data,\(error)")
        }
    }
    
}
