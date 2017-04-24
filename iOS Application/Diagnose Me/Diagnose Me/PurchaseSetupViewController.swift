//
//  PurchaseSetupViewController.swift
//  Diagnose Me
//
//  Created by Luke Porupski on 4/11/17.
//  Copyright © 2017 Luke Porupski. All rights reserved.
//

import UIKit

class PurchaseSetupViewController: UIViewController, DataHandlerPurchaseDelegate {

    var paymentMethods = [Payment]()
    var items = [Remedy]()
    var dataHandler: DataHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //getting payment method data
        if let nav = self.navigationController as? CartNavigationController {
            if let dh = nav.dataHandler {
                self.dataHandler = dh
                dh.purchaseDelegate = self
                if let user = UserDefaults.standard.object(forKey: "user") {
                    dh.getPaymentMethods(for: user as! String)
                }
            }
        }
        else if let nav = self.navigationController as? LoginNavigationController {
            if let dh = nav.dataHandler {
                self.dataHandler = dh
                dh.purchaseDelegate = self
                if let user = UserDefaults.standard.object(forKey: "user") {
                    dh.getPaymentMethods(for: user as! String)
                }
            }
        }
        
    }
    
    
    @IBAction func useSavedButtonPressed() {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "paymentSelectionViewController") as! PaymentSelectionViewController
        
        //check if user has any saved methods
        if paymentMethods.count == 0 {
            let alert = UIAlertController(title: "No saved payment methods", message: "You have no saved payment methods. Add a method by pressing add new payment method button.", preferredStyle: .alert)
            let a = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(a)
            self.present(alert, animated: true, completion: nil)
            
        }
        else {
            vc.savedPayments = self.paymentMethods
            vc.items = self.items
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
    @IBAction func enterNewButtonPressed() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "paymentInformationViewController") as! PaymentInformationViewController
        vc.items = self.items
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didFinishPaymentMethodsRetrieval(methods: [Payment]) {
        self.paymentMethods = methods
    }
    
    

}
