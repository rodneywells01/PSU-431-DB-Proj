//
//  SymtomTableViewController.swift
//  Diagnose Me
//
//  Created by Luke Porupski on 4/17/17.
//  Copyright © 2017 Luke Porupski. All rights reserved.
//

import UIKit

class SymptomTableViewController: UIViewController, UITableViewDataSource, UIScrollViewDelegate, UITableViewDelegate, UISearchControllerDelegate {
    
    var symptoms: [Symptom] = []
    var filteredSymptoms: [Symptom] = []
    var selectedSymptoms: [Symptom] = []
    var selectedIDs: [String] = []
    @IBOutlet weak var diagnosisButton: UIButton!
    
    
    @IBOutlet weak var tableView: UITableView!
    var diagnoseButton = UIButton()
    
    let searchController = UISearchController(searchResultsController: nil)
    var dataHandler: DataHandler?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 116/255, green: 241/255, blue: 116/255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.title = "Symptoms"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        //setting up diagnose button
        diagnoseButton.frame = CGRect(x: 100, y: view.frame.height - 60, width: view.frame.width - 200, height: 45)
        diagnoseButton.backgroundColor = UIColor(red: 116/255, green: 241/255, blue: 116/255, alpha: 1.0)
        diagnoseButton.addTarget(self, action: #selector(didPressDiagnoseButton), for: .touchUpInside)
        diagnoseButton.layer.cornerRadius = 5
        diagnoseButton.layer.zPosition = 10
        diagnoseButton.isEnabled = true
        diagnoseButton.setTitle("Diagnose", for: .normal)
        diagnoseButton.setTitleColor(UIColor.white, for: .normal)
        //self.view.addSubview(diagnoseButton)
        
        //setting up search bar
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        tableView.scrollsToTop = true
        definesPresentationContext = true
        //search bar setup
        searchController.searchBar.barTintColor = UIColor(red: 116/255, green: 241/255, blue: 116/255, alpha: 1.0)
        searchController.searchBar.autocorrectionType = .no
        searchController.searchBar.tintColor = UIColor(red: 116/255, green: 241/255, blue: 116/255, alpha: 1.0)
        searchController.searchBar.searchBarStyle = UISearchBarStyle.minimal
        searchController.searchBar.returnKeyType = .done
    }
    @IBAction func didPressDiagnosisButton() {
        
        if let dh = self.dataHandler {
            
            //let activity = UIActivityIndicatorView()
            //activity.center = self.view.center
            //self.view.addSubview(activity)
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "diagnosisTableViewController") as! DiagnosisTableViewController
            vc.dataHandler = dh
            vc.symptoms = self.selectedSymptoms
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        else {
            if let nav = self.navigationController as? LoginNavigationController {
                if let dh = nav.dataHandler {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "diagnosisTableViewController") as! DiagnosisTableViewController
                    vc.dataHandler = dh
                    vc.symptoms = self.selectedSymptoms
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
        }
        
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.2, animations: {
            
            self.diagnoseButton.frame.origin.y = self.view.frame.height
        })
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        UIView.animate(withDuration: 0.2, animations: {
            self.diagnoseButton.frame.origin.y = self.view.frame.height - 60
        })
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.2, animations: {
            self.diagnoseButton.frame.origin.y = self.view.frame.height - 60
        })
    }
    
    //SEARCH METHODS
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredSymptoms = symptoms.filter { symptom in
            return symptom.symptom.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    func searchButtonTapped() {
        
        self.tableView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: true)
        self.searchController.searchBar.becomeFirstResponder()
        
    }
    func didPressDiagnoseButton() {
        if let dh = self.dataHandler {
            
            //let activity = UIActivityIndicatorView()
            //activity.center = self.view.center
            //self.view.addSubview(activity)
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "diagnosisTableViewController") as! DiagnosisTableViewController
            vc.dataHandler = dh
            vc.symptoms = self.selectedSymptoms
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        else {
            if let nav = self.navigationController as? LoginNavigationController {
                if let dh = nav.dataHandler {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "diagnosisTableViewController") as! DiagnosisTableViewController
                    vc.dataHandler = dh
                    vc.symptoms = self.selectedSymptoms
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
        }
    }
    
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return selectedSymptoms.count
        }
        else {
            if searchController.isActive && searchController.searchBar.text != "" {
                return filteredSymptoms.count
            }
            return symptoms.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            var rowData: Symptom
            
            rowData = selectedSymptoms[indexPath.row]
            
            let cell = UITableViewCell()
            cell.textLabel?.text = rowData.symptom
            cell.detailTextLabel?.text = "$\(rowData.id)"
            cell.accessoryType = .checkmark
            return cell
        }
        else {
            var rowData: Symptom
            if searchController.isActive && searchController.searchBar.text != "" {
                rowData = filteredSymptoms[indexPath.row]
            }
            else {
                rowData = symptoms[indexPath.row]
            }
            
            let cell = UITableViewCell()
            cell.textLabel?.text = rowData.symptom
            cell.detailTextLabel?.text = "$\(rowData.id)"
            if self.selectedIDs.contains(rowData.id) {
                cell.accessoryType = .checkmark
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Selected"
        }
        return "All Symptoms"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            selectedSymptoms.remove(at: indexPath.row)
            selectedIDs.remove(at: indexPath.row)
            tableView.reloadSections([0, 1], with: .fade)
        }
        else if indexPath.section == 1 {
            var rowData: Symptom
            
            if searchController.isActive && searchController.searchBar.text != "" {
                rowData = filteredSymptoms[indexPath.row]
            }
            else {
                rowData = symptoms[indexPath.row]
            }
            if !(selectedIDs.contains(rowData.id)) {
                selectedSymptoms.append(rowData)
                selectedIDs.append(rowData.id)
                tableView.reloadSections([0, 1], with: .fade)
            }
            else {
                let x = selectedIDs.index(of: rowData.id)
                selectedSymptoms.remove(at: x!)
                selectedIDs.remove(at: x!)
                tableView.reloadSections([0, 1], with: .fade)
            }
        }
    }

}
extension SymptomTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
}
