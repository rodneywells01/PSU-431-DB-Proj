//
//  SignupViewController.swift
//  Diagnose Me
//
//  Created by Luke Porupski on 4/4/17.
//  Copyright © 2017 Luke Porupski. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordConfirmField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressCancelButton() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func didPressContinueButton() {
        
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let dest = segue.destination as? SignupContinuedViewController {
            
            dest.username = usernameField.text
            dest.password = passwordField.text
            
        }
    }
 

}
