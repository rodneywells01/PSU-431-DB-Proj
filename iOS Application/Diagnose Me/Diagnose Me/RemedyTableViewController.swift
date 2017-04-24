//
//  RemedyTableViewController.swift
//  Diagnose Me
//
//  Created by Luke Porupski on 4/5/17.
//  Copyright © 2017 Luke Porupski. All rights reserved.
//

import UIKit
import Alamofire

class RemedyTableViewController: UITableViewController, UISearchControllerDelegate, DataHandlerRemedyDelegate {

    var remedies: [Remedy] = []
    var filteredRemedies: [Remedy] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    var dataHandler: DataHandler?
    
    
    //buttons
    var searchButton: UIBarButtonItem?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 116/255, green: 241/255, blue: 116/255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.title = "Marketplace"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let handler = self.dataHandler {
            handler.marketplaceDelegate = self
            handler.getAllRemedies()
        }

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
        
        //adding gesture to scroll to top when navbar tapped
        let tap = UIGestureRecognizer(target: self, action: #selector(didTapNavbar))
        //self.navigationController?.view.addGestureRecognizer(tap)

        let cImage = resizeImage(image: #imageLiteral(resourceName: "cart_white"), targetSize: CGSize(width: 28.0, height: 28.0))
        let cartButton = UIBarButtonItem(image: cImage, style: .plain, target: self, action: #selector(didPressCartButton))
        
        self.navigationItem.setRightBarButton(cartButton, animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    //search methods
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredRemedies = remedies.filter { remedy in
            return remedy.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    func searchButtonTapped() {
        
        self.tableView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: true)
        self.searchController.searchBar.becomeFirstResponder()
        
    }
    
    func didPressCartButton(){
        
        let cartVC = self.storyboard?.instantiateViewController(withIdentifier: "cartNavigationController") as! CartNavigationController
        if let dh = self.dataHandler {
            cartVC.dataHandler = dh
        }
        present(cartVC, animated: true, completion: nil)
    }
    
    func didTapNavbar(){
        self.tableView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: true)
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredRemedies.count
        }
        
        return remedies.count
    }
    
    
    //DATA RETRIEVAL
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var rowData: Remedy
        
        if searchController.isActive && searchController.searchBar.text != "" {
            rowData = filteredRemedies[indexPath.row]
        }
        else {
            rowData = remedies[indexPath.row]
        }
        
        let identifier = "remedyCell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            cell.textLabel?.text = "\(rowData.name)"
            cell.detailTextLabel?.text = "$\(rowData.cost)"
            return cell
        }
        else {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: identifier)
            cell.textLabel?.text = "\(rowData.name)"
            cell.detailTextLabel?.text = "$\(rowData.cost)"
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "remedyDetailViewController") as! RemedyDetailViewController
        var rem: Remedy
        if searchController.isActive && searchController.searchBar.text != "" {
            rem = filteredRemedies[indexPath.row]
        }
        else {
            rem = remedies[indexPath.row]
        }
        
        //set up detail view
        vc.remedy = rem
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio,height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    //delegate methods
    func didFinishRetrieval() {
        self.remedies = dataHandler!.allRemedies
        self.tableView.reloadData()
    }

}

extension RemedyTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
}
