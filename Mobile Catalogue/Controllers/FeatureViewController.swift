//
//  FeatureViewController.swift
//  Mobile Catalogue
//
//  Created by Praveen Ojha on 1/8/18.
//  Copyright © 2018 Praveen Ojha. All rights reserved.
//

import UIKit

private let reuseIdentifier = "featureCell"

class FeatureTableViewController: UITableViewController {

    let featureData = ["Feature1", "Feature2", "Feature3", "Feature4", "Feature5"]
    
    var selectedMVP: MVPModel? {
        didSet {
            print(selectedMVP!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//        self.navigationController?.delegate = self
        tableView.register(UINib(nibName: "FeatureCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 150
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationItem.title = selectedMVP?.title
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return featureData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "featureCell", for: indexPath)

         //Configure the cell...
//        cell.textLabel?.text = featureData[indexPath.row]
//
//        //this is for color
//        cell.textLabel?.textColor = UIColor(hexString: selectedMVP!.fgColor)
//        cell.backgroundColor = UIColor(hexString: selectedMVP!.bgColor)
        
        return cell
    }

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

}
