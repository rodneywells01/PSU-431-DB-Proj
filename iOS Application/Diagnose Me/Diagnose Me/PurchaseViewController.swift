//
//  PurchaseViewController.swift
//  Diagnose Me
//
//  Created by Luke Porupski on 4/11/17.
//  Copyright © 2017 Luke Porupski. All rights reserved.
//

import UIKit

class PurchaseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var purchaseMode: String?
    var paymentMethod: Payment?
    var items = [Remedy]()
    @IBOutlet weak var itemsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.itemsTableView.reloadData()
    }
    
    @IBAction func confirmPurchaseButtonPressed() {
        
        if let nav = self.navigationController as? CartNavigationController {
            if let dh = nav.dataHandler {
                if let user = UserDefaults.standard.object(forKey: "user") {
                    
                    if purchaseMode == "cart" {
                        dh.executeCartPurchase(user: user as! String, address: (paymentMethod?.address)!)
                    }
                    else {
                        dh.executeBuyItNow(item: items[0].id, user: user as! String, address: (paymentMethod?.address)!)
                    }
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "itemCell")
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.cost)"
        return cell
        
        
    }

}
