//
//  ProfileViewController.swift
//  Diagnose Me
//
//  Created by Luke Porupski on 4/11/17.
//  Copyright © 2017 Luke Porupski. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DataHandlerProfileDelegate {

    var dataHandler: DataHandler?
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    //tableviews
    @IBOutlet weak var diagnosesTable: UITableView!
    @IBOutlet weak var ordersTable: UITableView!
    
    //data
    var diagnoses = [Illness]()
    var orders = [Order]()
    var orderItems = [Remedy]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //setting up tables
        diagnosesTable.dataSource = self
        diagnosesTable.delegate = self
        
        ordersTable.dataSource = self
        ordersTable.delegate = self
        
        
        //setting up data handler
        if let dh = dataHandler {
            dh.profileDelegate = self
            
            if let user = UserDefaults.standard.object(forKey: "user") {
                
                self.usernameLabel.text = user as! String
                
                dh.getOrders(for: user as! String)
                
                dh.getDiagnoses(for: user as! String)
                
            }
        }
        
        
    }
    
    @IBAction func didPressCloseProfileButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    //DELEGATE METHODS
    
    func didFinishOrdersRetrieval(orders: [Order]) {
        self.orders = orders
        ordersTable.reloadData()
        //get order items here
    }
    
    func didFinishDiagnosesRetrieval(diagnoses: [Illness]) {
        self.diagnoses = diagnoses
        diagnosesTable.reloadData()
    }
    
    
    
    //TABLE VIEW METHODS
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case diagnosesTable:
            let data = diagnoses[indexPath.row]
            
            let identifier = "diagnosisCell"
            if let cell = diagnosesTable.dequeueReusableCell(withIdentifier: identifier) {
                cell.textLabel?.text = data.name
                cell.detailTextLabel?.text = data.type
                return cell
            }
            else {
                let cell = UITableViewCell(style: .value2, reuseIdentifier: identifier)
                cell.textLabel?.text = data.name
                cell.detailTextLabel?.text = data.type
                return cell
            }
        case ordersTable:
            let data = orders[indexPath.row]
            //let formatter = DateFormatter()
            
            let identifier = "orderCell"
            if let cell = ordersTable.dequeueReusableCell(withIdentifier: identifier) {
                cell.textLabel?.text = "\(data.date) : \(data.id)"
                cell.detailTextLabel?.text = data.status
                return cell
            }
            else {
                let cell = UITableViewCell(style: .value2, reuseIdentifier: identifier)
                cell.textLabel?.text = "\(data.date) : \(data.id)"
                cell.detailTextLabel?.text = data.status
                return cell
            }
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
        case diagnosesTable:
            return diagnoses.count
        case ordersTable:
            return orders.count
        default:
            return 0
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}
