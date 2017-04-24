//
//  PaymentSelectionViewController.swift
//  Diagnose Me
//
//  Created by Luke Porupski on 4/11/17.
//  Copyright © 2017 Luke Porupski. All rights reserved.
//

import UIKit

class PaymentSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var savedPayments = [Payment]()
    
    var selectedPayment: Payment?
    var selectedIndex: IndexPath?
    var items = [Remedy]()
    
    @IBOutlet weak var tableview: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.allowsMultipleSelection = false
        
    }

    @IBAction func didPressContinueButton() {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "purchaseViewController") as! PurchaseViewController
        vc.paymentMethod = self.selectedPayment
        vc.items = self.items
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //TABLE VIEW METHODS
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let payment = savedPayments[indexPath.row]
        
        let cellIdentifier = "PaymentCell"
        
        if let cell = tableview.dequeueReusableCell(withIdentifier: cellIdentifier) {
            cell.textLabel?.text = payment.card_number
            cell.detailTextLabel?.text = payment.address
            return cell
        }
        else {
            let cell = UITableViewCell(style: .value2, reuseIdentifier: cellIdentifier)
            cell.textLabel?.text = payment.card_number
            cell.detailTextLabel?.text = payment.address
            return cell
        }
        
        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedPayments.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //unselect old one
        if let index = selectedIndex {
            let old = self.tableview.cellForRow(at: index)
            old?.accessoryType = .none
        }
        selectedIndex = indexPath
        
        self.tableview.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
        self.selectedPayment = savedPayments[indexPath.row]
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.tableview.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
    }
    
}
