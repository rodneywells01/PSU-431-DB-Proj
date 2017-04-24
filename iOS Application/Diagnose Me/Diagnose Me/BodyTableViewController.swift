//
//  BodyTableViewController.swift
//  Diagnose Me
//
//  Created by Luke Porupski on 4/23/17.
//  Copyright © 2017 Luke Porupski. All rights reserved.
//

import UIKit

class BodyTableViewController: UITableViewController {

    let regions = ["Allergy & Immunology", "Blood & Circulation", "Brain & Nervous System", "Cancer", "Digestive System", "Endocrine System", "Eye/Ear/Nose/Throat", "Heart & Vascular Disorders", "Infectious Diseases", "Musculoskeletal", "Psychology", "Reproductive System", "Respiratory", "Skin, Nails & Hair Disorders", "Other"]
    
    var subTable: AffectedAreaTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subTable = self.storyboard?.instantiateViewController(withIdentifier: "affectedAreaTableView") as! AffectedAreaTableViewController

        self.navigationItem.title = "Affected Region"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
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
        return regions.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = regions[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let st = self.subTable {
            subTable?.selectedArea = regions[indexPath.row]
            self.navigationController?.pushViewController(st, animated: true)
        }
        
    }
    

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
