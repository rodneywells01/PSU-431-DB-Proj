//
//  MainViewController.swift
//  Diagnose Me
//
//  Created by Luke Porupski on 3/1/17.
//  Copyright © 2017 Luke Porupski. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, DataHandlerDiagnoseDelegate {

    
    let dataHandler = DataHandler()
    let defaults = UserDefaults.standard
    
    let activityIndicator = UIActivityIndicatorView()
    
    //controllers
    var marketplaceController: RemedyTableViewController?
    var bodyTableViewController: BodyTableViewController?
    
    var symptomTableViewController: SymptomTableViewController?
    let illnessTableViewController: IllnessTableViewController = IllnessTableViewController()
    
    @IBOutlet weak var symptomSearchButton: UIButton!
    @IBOutlet weak var diseaseSearchButton: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 116/255, green: 241/255, blue: 116/255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.title = ""
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        
        (self.navigationController as! LoginNavigationController).dataHandler = self.dataHandler
        
        if !userIsLoggedIn() {
            
            
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
            loginVC.dataHandler = self.dataHandler
            navigationController?.pushViewController(loginVC, animated: true)            
            
        }
        else {
            
        }
        
        if dataHandler.allIllnesses.count == 0 {
            activityIndicator.center = self.view.center
            activityIndicator.startAnimating()
            activityIndicator.hidesWhenStopped = true
            view.addSubview(activityIndicator)
        }
        
        //get symptom and illness data
        self.dataHandler.diagnoseDelegate = self
        self.dataHandler.getAllSymptoms()
        self.dataHandler.getAllIllnesses()
        
        
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpControllers()
        
        //add profile button to navbar
        if let user = defaults.object(forKey: "user") {
            let profileButton = UIBarButtonItem(title: user as? String, style: .plain, target: self, action: #selector(didPressProfileButton))
            self.navigationItem.setRightBarButton(profileButton, animated: true)
        }
        
        symptomSearchButton.layer.borderWidth = 1
        diseaseSearchButton.layer.borderWidth = 1
        symptomSearchButton.layer.borderColor = UIColor(red: 116/255, green: 241/255, blue: 116/255, alpha: 1.0).cgColor
        diseaseSearchButton.layer.borderColor = UIColor(red: 116/255, green: 241/255, blue: 116/255, alpha: 1.0).cgColor

        diseaseSearchButton.layer.cornerRadius = 10
        symptomSearchButton.layer.cornerRadius = 10
    }
    
    
    func userIsLoggedIn() ->  Bool{
        return defaults.integer(forKey: "userStatus") == 1
    }
    
    
    func setUpControllers(){
        
        //instantiate and set up marketplace controller
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "remedyTableViewController") as? RemedyTableViewController {
            self.marketplaceController = vc
            vc.dataHandler = self.dataHandler
        }
        
        //set up disease and symptom table view controllers
        self.symptomTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "symptomTableViewController") as? SymptomTableViewController
        
        //instantiate and set up body search controller
        self.bodyTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "bodyTableViewController") as? BodyTableViewController
    }
    
    
    func forgotPasswordTapped() {
        
    }

    
    //BUTTON PRESS METHODS
    
    func didPressProfileButton(){
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "profileViewController") as? ProfileViewController{
            
            vc.dataHandler = self.dataHandler
            present(vc, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func didPressMarketplaceButton(){
        if let vc = self.marketplaceController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    @IBAction func didPressAllSymptomsButton() {
        if let stvc = self.symptomTableViewController {
            self.navigationController?.pushViewController(stvc, animated: true)
        }
    }
    
    
    @IBAction func didPressAllIllnessesButton() {
        self.navigationController?.pushViewController(self.illnessTableViewController, animated: true)
        
    }
    
    @IBAction func didPressBodyRegionButton() {
        if let btvc = self.bodyTableViewController {
            self.navigationController?.pushViewController(btvc, animated: true)
        }
        else{
            let btvc = self.storyboard?.instantiateViewController(withIdentifier: "bodyTableViewController")
            self.navigationController?.pushViewController(btvc!, animated: true)
        }
        
    }
    
    
    //DELEGATE METHODS
    func didFinishSymptomRetrieval(symptoms: [Symptom]) {
        if let stvc = self.symptomTableViewController {
            stvc.symptoms = symptoms.sorted(by: { $0.symptom < $1.symptom })
            if let tv = stvc.tableView {
                tv.reloadData()
            }
        }
        
    }
    func didFinishIllnessRetrieval(illnesses: [Illness]) {
        activityIndicator.stopAnimating()
        illnessTableViewController.illnesses = illnesses.sorted(by: {$0.name < $1.name})
        illnessTableViewController.tableView.reloadData()
    }
    
    
}
