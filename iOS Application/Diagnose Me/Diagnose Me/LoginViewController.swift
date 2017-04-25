//
//  LoginViewController.swift
//  Diagnose Me
//
//  Created by Luke Porupski on 4/4/17.
//  Copyright © 2017 Luke Porupski. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var dataHandler: DataHandler?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.integer(forKey: "userStatus") == 1 {
            self.navigationController?.popViewController(animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didPressCreateAccount() {
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameField {
            passwordField.becomeFirstResponder()
            return true
        }
        else {
            self.view.endEditing(true)
            passwordField.resignFirstResponder()
            return false
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let nav = segue.destination as? LoginNavigationController {
            nav.dataHandler = self.dataHandler!
        }
    }
    

}
