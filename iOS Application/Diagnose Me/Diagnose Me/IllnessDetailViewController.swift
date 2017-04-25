//
//  IllnessDetailViewController.swift
//  Diagnose Me
//
//  Created by Luke Porupski on 4/20/17.
//  Copyright © 2017 Luke Porupski. All rights reserved.
//

import UIKit

class IllnessDetailViewController: UIViewController, DataHandlerIllnessDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var symptomsTableView: UITableView!
    @IBOutlet weak var remediesTableView: UITableView!
    
    var symptoms = [Symptom]()
    var remedies = [Remedy]()
    var illness: Illness? {
        didSet {
            self.navigationItem.title = illness?.name
        }
    }
    
    var dataHandler: DataHandler?
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 116/255, green: 241/255, blue: 116/255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        if let ill = self.illness {
            self.navigationItem.title = illness?.name
        }
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        symptomsTableView.delegate = self
        symptomsTableView.dataSource = self
        
        remediesTableView.delegate = self
        remediesTableView.dataSource = self
        
        //setting up data handler
            let nav = self.navigationController as! LoginNavigationController
            if let dh = nav.dataHandler {
                self.dataHandler = dh
                dh.illnessDelegate = self
                if let i = illness {
                    self.descriptionLabel.text = illness?.description
                    dh.getSymptoms(forIllness: i.id)
                    dh.getRemedies(forIllness: i.id)
                }
            }
    }
    
    
    
    
    //delegate methods
    func didFinishRemedyRetrieval(remedies: [Remedy]) {
        self.remedies = remedies
        self.remediesTableView.reloadData()
    }
    func didFinishSymptomRetrieval(symptoms: [Symptom]) {
        self.symptoms = symptoms
        self.symptomsTableView.reloadData()
    }
    
    
    
    
    //TABLE VIEW METHODS
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case symptomsTableView:
            if symptoms.count == 0 {
                let cell = UITableViewCell()
                cell.textLabel?.text = "No Symptom Data Available"
                return cell
            }
            else{
                let data = symptoms[indexPath.row]
                
                let identifier = "symptomCell"
                if let cell = symptomsTableView.dequeueReusableCell(withIdentifier: identifier) {
                    cell.textLabel?.text = data.symptom
                    return cell
                }
                else {
                    let cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
                    cell.textLabel?.text = data.symptom
                    return cell
                }
            }
        case remediesTableView:
            if remedies.count == 0 {
                let cell = UITableViewCell()
                cell.textLabel?.text = "No Remedy Data Available"
                return cell
            }
            else{
                let data = remedies[indexPath.row]
                
                let identifier = "remedyCell"
                if let cell = remediesTableView.dequeueReusableCell(withIdentifier: identifier) {
                    cell.textLabel?.text = "\(data.name)"
                    cell.detailTextLabel?.text = "$\(data.cost)"
                    return cell
                }
                else {
                    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: identifier)
                    cell.textLabel?.text = "\(data.name)"
                    cell.detailTextLabel?.text = "$\(data.cost)"
                    return cell
                }
            }
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case symptomsTableView:
            break
        case remediesTableView:
            let selected_remedy = remedies[indexPath.row]
            let rvc = self.storyboard?.instantiateViewController(withIdentifier: "remedyDetailViewController") as! RemedyDetailViewController
            rvc.remedy = selected_remedy
            self.navigationController?.pushViewController(rvc, animated: true)
        default:
            break
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
        case symptomsTableView:
            if symptoms.count == 0 {
                return 1
            }
            return symptoms.count
        case remediesTableView:
            if remedies.count == 0 {
                return 1
            }
            return remedies.count
        default:
            return 0
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
