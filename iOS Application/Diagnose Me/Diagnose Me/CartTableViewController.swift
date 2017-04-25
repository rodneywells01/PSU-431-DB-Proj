//
//  CartTableViewController.swift
//  Diagnose Me
//
//  Created by Luke Porupski on 4/6/17.
//  Copyright © 2017 Luke Porupski. All rights reserved.
//

import UIKit

class CartTableViewController: UITableViewController, DataHandlerCartDelegate {

    var cartItems = [Remedy]()
    var dataHandler: DataHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //getting cart data
        if let nav = self.navigationController as? CartNavigationController {
            if let dh = nav.dataHandler {
                self.dataHandler = dh
                dh.cartDelegate = self
                if let user = UserDefaults.standard.object(forKey: "user") {
                    dh.getCartItems(for: user as! String)
                }
            }
        }
        
        self.clearsSelectionOnViewWillAppear = false
        
        //setting up navbar
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 116/255, green: 241/255, blue: 116/255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.title = "Cart"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        let closeCartButton = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(didPressCloseCartButton))
        self.navigationItem.setLeftBarButton(closeCartButton, animated: true)
        
        let checkoutButton = UIBarButtonItem(title: "Check Out", style: .done, target: self, action: #selector(didPressCheckoutButton))
        self.navigationItem.setRightBarButton(checkoutButton, animated: true)
    
        
    }

    func didPressCloseCartButton(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func didPressCheckoutButton(){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "purchaseSetupViewController") as! PurchaseSetupViewController
        vc.items = self.cartItems
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    func didUpdateQuantity(for item: String) {
        
    }
    
    
    //DELEGATE METHODS
    
    func didFinishRetrieval(items: [Remedy]) {
        self.cartItems = items
        self.tableView.reloadData()
    }
    
    func didFinishItemRemoval() {
        let alert = UIAlertController(title: "Success", message: "Item successfully removed from cart", preferredStyle: .actionSheet)
        let ac = UIAlertAction(title: "Close", style: .default, handler: nil)
        alert.addAction(ac)
        present(alert, animated: true, completion: nil)
        self.tableView.reloadData()
    }
    
    
    
    
    //TABLE VIEW METHODS
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var rowData: Remedy
        rowData = cartItems[indexPath.row]
        
        let cell = UITableViewCell()
        cell.textLabel?.text = rowData.name
        cell.detailTextLabel?.text = rowData.cost
        
        return cell
    }
    
    
    //EDITING METHODS
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.destructive, title: "Remove" , handler: { (action:UITableViewRowAction, indexPath:IndexPath) -> Void in
            
            let item = self.cartItems[indexPath.row]
            if let nav = self.navigationController as? CartNavigationController {
                if let dh = nav.dataHandler {
                    if let user = UserDefaults.standard.object(forKey: "user") {
                        self.cartItems.remove(at: indexPath.row)
                        dh.removeCartItem(item: item.id, user: user as! String)
                    }
                }
            }
            
        })
        return [deleteAction]
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        
        
    }
    
    func didFinishCartPurchase() {
        
    }
    
}
