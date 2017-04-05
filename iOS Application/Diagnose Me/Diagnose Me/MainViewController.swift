//
//  MainViewController.swift
//  Diagnose Me
//
//  Created by Luke Porupski on 3/1/17.
//  Copyright © 2017 Luke Porupski. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, LFLoginControllerDelegate {

    @IBOutlet weak var searchButton: UIButton!
    
    let dataHandler = DataHandler()
    let defaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        (self.navigationController as! LoginNavigationController).dataHandler = self.dataHandler
        
        if !userIsLoggedIn() {
            
            
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
            loginVC.dataHandler = self.dataHandler
            navigationController?.pushViewController(loginVC, animated: true)            
            
        }
        else {
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        searchButton.layer.cornerRadius = 5
        
    }
    
    
    func userIsLoggedIn() ->  Bool{
        return defaults.integer(forKey: "userStatus") == 1
    }
    
    
    
    
    
    //LOGIN CONTROLLER DELEGATE METHODS
    
    func loginDidFinish(email: String, password: String, type: LFLoginController.SendType) {
        
        if type == .Login {
            defaults.set(1, forKey: "userStatus")
        }
        
        else {
            
        }
    }
    
    func forgotPasswordTapped() {
        
    }

    
    
}
