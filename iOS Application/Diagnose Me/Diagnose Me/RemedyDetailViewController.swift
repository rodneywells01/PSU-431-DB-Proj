//
//  RemedyDetailViewController.swift
//  Diagnose Me
//
//  Created by Luke Porupski on 4/5/17.
//  Copyright © 2017 Luke Porupski. All rights reserved.
//

import UIKit

class RemedyDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DataHandlerRemedyDetailDelegate {

    //buttons
    
    
    //remedy details
    var remedy: Remedy?
    let defaults = UserDefaults.standard
    var auctions = [Auction]()
    var illnesses = [Illness]()
    
    
    //bottom views
    @IBOutlet weak var purchasableView: UIView!
    
    
    //remedy detail labels
    
    @IBOutlet weak var auctionTableView: UITableView!
    @IBOutlet weak var illnessTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        if let nav = self.navigationController as? LoginNavigationController {
            if let dh = nav.dataHandler {
                if let rem = self.remedy {
                    dh.remedyDetailDelegate = self
                    dh.getAuctions(forRemedyID: rem.id)
                    dh.getIllnessesForRemedy(id: rem.id)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let rem = remedy {
            self.navigationItem.title = rem.name
        }
        
        
        
        //set up navbar
        self.navigationItem.backBarButtonItem?.title = "Marketplace"
        self.navigationItem.leftBarButtonItem?.title = "Marketplace"
        
        auctionTableView.delegate = self
        auctionTableView.dataSource = self
        illnessTableView.delegate = self
        illnessTableView.dataSource = self
        

    }
    
    func didFinishAuctionRetrieval(items: [Auction]) {
        self.auctions = items
        self.auctionTableView.reloadData()
        
    }
    
    func didFinishIllnessRetrieval(items: [Illness]) {
        self.illnesses = items
        self.illnessTableView.reloadData()
        
    }
    
    
    @IBAction func didPressBuyNowButton() {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "purchaseSetupViewController") as! PurchaseSetupViewController
        if let nav = self.navigationController as? LoginNavigationController {
            vc.dataHandler = nav.dataHandler
            if let r = self.remedy {
                vc.items = [r]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    
    @IBAction func didPressAddToCartButton() {
        
        let nav = self.navigationController as! LoginNavigationController
        if let rem = self.remedy {
            if let user = self.defaults.object(forKey: "user") {
                if (nav.dataHandler?.addCartItem(item: rem.id, user: user as! String))! {
                    let alert = UIAlertController(title: "Success", message: "\((self.remedy?.name)!) added to cart", preferredStyle: .actionSheet)
                    let ac = UIAlertAction(title: "Close", style: .default, handler: nil)
                    alert.addAction(ac)
                    self.present(alert, animated: true, completion: nil)
                }
                else { //unable to add to cart for user
                    
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case auctionTableView:
            
            let data = auctions[indexPath.row]
            let identifier = "auctionCell"
            if let cell = auctionTableView.dequeueReusableCell(withIdentifier: identifier) {
                cell.textLabel?.text = "$\(data.reserve_price!)"
                cell.detailTextLabel?.text = "Ends $\(data.end_date!)"
                return cell
            }
            else {
                let cell = UITableViewCell(style: .subtitle, reuseIdentifier: identifier)
                cell.textLabel?.text = "$\(data.reserve_price!)"
                cell.detailTextLabel?.text = "Ends \(data.end_date!)"
                return cell
            }
            
        case illnessTableView:
            
            let data = illnesses[indexPath.row]
            let identifier = "illnessCell"
            if let cell = illnessTableView.dequeueReusableCell(withIdentifier: identifier) {
                cell.textLabel?.text = "\(data.name)"
                cell.detailTextLabel?.text = "\(data.description)"
                return cell
            }
            else {
                let cell = UITableViewCell(style: .subtitle, reuseIdentifier: identifier)
                cell.textLabel?.text = "\(data.name)"
                cell.detailTextLabel?.text = "\(data.description)"
                return cell
            }
            
        default:
            return UITableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case auctionTableView:
            return auctions.count
        case illnessTableView:
            return illnesses.count
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == auctionTableView {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "auctionViewController") as! AuctionViewController
            vc.auction = auctions[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
