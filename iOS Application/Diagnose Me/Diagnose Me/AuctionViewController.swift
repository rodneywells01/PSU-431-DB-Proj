//
//  AuctionViewController.swift
//  Diagnose Me
//
//  Created by Luke Porupski on 4/23/17.
//  Copyright © 2017 Luke Porupski. All rights reserved.
//

import UIKit

class AuctionViewController: UIViewController, DataHandlerAuctionDelegate {

    @IBOutlet weak var topBidLabel: UILabel!
    @IBOutlet weak var bidAmountLabel: UITextField!
    var topBidAmount: Double = 0.0
    var auction: Auction?
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let nav = self.navigationController as? LoginNavigationController {
            if let dh = nav.dataHandler {
                if let auc = self.auction {
                    dh.auctionDelegate = self
                    dh.getTopBid(auction_id: auc.id!)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bidAmountLabel.keyboardType = .numberPad
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    @IBAction func didPressBidButton() {
        if let val = self.bidAmountLabel.text {
            if let nav = self.navigationController as? LoginNavigationController {
                if let dh = nav.dataHandler {
                    if let user = UserDefaults.standard.object(forKey: "user") {
                        if let auc = self.auction {
                            dh.auctionDelegate = self
                            if let numVal = Double(val) {
                                if numVal > topBidAmount {
                                    dh.executeAuctionBid(auction_id: auc.id!, amount: val, user: user as! String)
                                    topBidAmount = numVal
                                    topBidLabel.text = "Top Bid: $\(topBidAmount)"
                                    
                                    let alert = UIAlertController(title: "Bid Confirmed", message: "Your bid of $\(topBidAmount) has been made.", preferredStyle: .alert)
                                    let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
                                    self.present(alert, animated: true, completion: nil)
                                    self.view.endEditing(true)
                                }
                            }
                            
                        }
                    }
                    
                }
            }
        }
        
    }
    
    
    func didRetrieveTopBid(amount: Double) {
        self.topBidLabel.text = "Top Bid: $\(amount)"
        self.topBidAmount = amount
    }

}
