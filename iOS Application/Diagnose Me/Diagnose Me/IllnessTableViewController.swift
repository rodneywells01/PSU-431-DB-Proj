//
//  IllnessTableViewController.swift
//  Diagnose Me
//
//  Created by Luke Porupski on 4/17/17.
//  Copyright © 2017 Luke Porupski. All rights reserved.
//

import UIKit

class IllnessTableViewController: UITableViewController, UISearchControllerDelegate {

    var illnesses: [Illness] = []
    var filteredIllnesses: [Illness] = []
    var selectedIllness: Illness?
    var detailController: IllnessDetailViewController?
    
    let searchController = UISearchController(searchResultsController: nil)
    var dataHandler: DataHandler?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 116/255, green: 241/255, blue: 116/255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.title = "Illnesses"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        
    }
    
    
    //SEARCH METHODS
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredIllnesses = illnesses.filter { illness in
            return illness.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    func searchButtonTapped() {
        
        self.tableView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: true)
        self.searchController.searchBar.becomeFirstResponder()
        
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredIllnesses.count
        }
        return illnesses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var rowData: Illness
            
        if searchController.isActive && searchController.searchBar.text != "" {
            rowData = filteredIllnesses[indexPath.row]
        }
        else {
            rowData = illnesses[indexPath.row]
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "iCell") {
            cell.textLabel?.text = rowData.name
            cell.detailTextLabel?.text = rowData.description
            return cell
        }
        else {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "iCell")
            cell.textLabel?.text = rowData.name
            cell.detailTextLabel?.text = rowData.description
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "All Illnesses"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var rowData: Illness
        
        if searchController.isActive && searchController.searchBar.text != "" {
            rowData = filteredIllnesses[indexPath.row]
        }
        else {
            rowData = illnesses[indexPath.row]
        }
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "iDetail") as! IllnessDetailViewController
        vc.dataHandler = self.dataHandler
        vc.illness = rowData
        self.navigationController?.pushViewController(vc, animated: true)
        //vc.dataHandler = self.dataHandler
        //vc.illness = rowData
        //self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension IllnessTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
