//
//  PaymentInformationViewController.swift
//  Diagnose Me
//
//  Created by Luke Porupski on 4/11/17.
//  Copyright © 2017 Luke Porupski. All rights reserved.
//

import UIKit

class PaymentInformationViewController: UIViewController {

    @IBOutlet weak var cardNumberField: UITextField!
    @IBOutlet weak var streetField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    
    var items = [Remedy]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func didPressContinueButton(){
        
        if let nav = self.navigationController as? CartNavigationController {
            if let dh = nav.dataHandler {
                if let user = UserDefaults.standard.object(forKey: "user") {
                    if streetField.text != "" && cityField.text != "" && stateField.text != "" {
                        let add = streetField.text! + ", " + cityField.text! + ", " + stateField.text!
                        if !(dh.addPaymentMethod(user: user as! String, cNum: cardNumberField.text!, address: add)) {
                            let alert = UIAlertController(title: "Unable to add payment method", message: "Please retry", preferredStyle: .alert)
                            let a = UIAlertAction(title: "Okay", style: .default, handler: nil)
                            alert.addAction(a)
                            self.present(alert, animated: true, completion: nil)
                        }
                        else {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "purchaseViewController") as! PurchaseViewController
                            vc.paymentMethod = Payment(cNum: cardNumberField.text!, add: add)
                            vc.items = self.items
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
            }
        }
        else if let nav = self.navigationController as? LoginNavigationController {
            if let dh = nav.dataHandler {
                if let user = UserDefaults.standard.object(forKey: "user") {
                    if streetField.text != "" && cityField.text != "" && stateField.text != "" {
                        let add = streetField.text! + ", " + cityField.text! + ", " + stateField.text!
                        if !(dh.addPaymentMethod(user: user as! String, cNum: cardNumberField.text!, address: add)) {
                            let alert = UIAlertController(title: "Unable to add payment method", message: "Please retry", preferredStyle: .alert)
                            let a = UIAlertAction(title: "Okay", style: .default, handler: nil)
                            alert.addAction(a)
                            self.present(alert, animated: true, completion: nil)
                        }
                        else {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "purchaseViewController") as! PurchaseViewController
                            vc.paymentMethod = Payment(cNum: cardNumberField.text!, add: add)
                            vc.items = self.items
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
            }
        }
        
    }

}
