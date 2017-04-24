//
//  Database_Handler.swift
//  Diagnose Me
//
//  Created by Luke Porupski on 4/3/17.
//  Copyright © 2017 Luke Porupski. All rights reserved.
//

import Foundation
import Alamofire
import MapKit

protocol DataHandlerRemedyDelegate {
    func didFinishRetrieval()
}
protocol DataHandlerRemedyDetailDelegate {
    func didFinishAuctionRetrieval(items: [Auction])
    func didFinishIllnessRetrieval(items: [Illness])
}
protocol DataHandlerCartDelegate {
    func didFinishRetrieval(items: [Remedy])
    func didFinishItemRemoval()
}
protocol DataHandlerProfileDelegate {
    func didFinishOrdersRetrieval(orders: [Order])
    func didFinishDiagnosesRetrieval(diagnoses: [Illness])
}
protocol DataHandlerPurchaseDelegate {
    func didFinishPaymentMethodsRetrieval(methods: [Payment])
}
protocol DataHandlerDiagnoseDelegate {
    func didFinishIllnessRetrieval(illnesses: [Illness])
    func didFinishSymptomRetrieval(symptoms: [Symptom])
}
protocol DataHandlerIllnessDelegate {
    func didFinishSymptomRetrieval(symptoms: [Symptom])
    func didFinishRemedyRetrieval(remedies: [Remedy])
}
protocol DataHandlerAuctionDelegate {
    func didRetrieveTopBid(amount: Double)
}
protocol DataHandlerDiagnosisViewDelegate {
    func didFinishDiagnosis(illnesses: [Illness])
}


class DataHandler {
    
    var marketplaceDelegate: DataHandlerRemedyDelegate?
    var cartDelegate: DataHandlerCartDelegate?
    var profileDelegate: DataHandlerProfileDelegate?
    var purchaseDelegate: DataHandlerPurchaseDelegate?
    var diagnoseDelegate: DataHandlerDiagnoseDelegate?
    var illnessDelegate: DataHandlerIllnessDelegate?
    var remedyDetailDelegate: DataHandlerRemedyDetailDelegate?
    var auctionDelegate: DataHandlerAuctionDelegate?
    var diagnosisViewDelegate: DataHandlerDiagnosisViewDelegate?
    
    var allRemedies = [Remedy]()
    var allIllnesses = [Illness]()
    var allSymptoms = [Symptom]()
    
    init() {
        
    }
    
    
    //ACCOUNT METHODS
    
    public func createUser(with fname: String, lname: String, sex: String, weight: String, height: String, dob: String, smoke: String, username: String, password: String, email: String) -> Bool{
        
        let url = "http://www.lukeporupski.com/php/register.php?fname=\(fname)&lname=\(lname)&sex=\(sex)&weight=\(weight)&height=\(height)&dob=\(dob)&smoke=\(smoke)&username=\(username)&password=\(password)&email=\(email)"
        
        var flag = true
        
        //Sending http post request
        Alamofire.request(url, method: .get, parameters: nil).responseJSON
        {
            response in
                
                
            switch response.result {
            case .success( _):
                UserDefaults.standard.set(username, forKey: "user")
                break
            case .failure(let error):
                print("failed with error: \(error)")
                flag = false
                break
            }
        }
        
        return flag
        
    }
    
    public func logInUser(with username: String, password: String) {
        
    }
    
    
    
    
    
    
    
    //REMEDY METHODS
    public func getAllRemedies() {
        let url = "http://www.lukeporupski.com/php/remedies.php"
        
        Alamofire.request(url, method: .post, parameters: nil).responseJSON
            {
                response in
                
                if let result = response.value {
                    //converting it as NSDictionary
                    if let jsonData = result as? [NSDictionary] {
                        for remedy in jsonData {
                            
                            let name = remedy["name"] as? String
                            
                            let supplier = remedy["supplier"] as? String
                            let cost = remedy["direct_cost"] as? String
                            let id = remedy["remedy_id"] as? String
                            let purchasable = remedy["purchasable"] as? String
                            
                            let newRem = Remedy(name: name!, supplier: supplier!, cost: cost!, id: id!, purchasable: purchasable!)
                            
                            self.allRemedies.append(newRem)
                            
                            if self.allRemedies.count == jsonData.count {
                                self.marketplaceDelegate?.didFinishRetrieval()
                            }
                        }
                    }
                    
                }
            }
    }
    
    
    //ILLNESS AND SYMPTOM METHODS
    
    public func getAllIllnesses() {
        
        let url = "http://www.lukeporupski.com/php/illnesses.php"
        
        Alamofire.request(url, method: .post, parameters: nil).responseJSON
            {
                response in
                
                if let result = response.value {
                    //converting it as NSDictionary
                    if let jsonData = result as? [NSDictionary] {
                        for illness in jsonData {
                            
                            let id = illness["illness_id"] as? String
                            var prev = ""
                            if let p = illness["prevalence"] as? String {
                                prev = p
                            }
                            var severity = ""
                            if let s = illness["severity"] as? String {
                                severity = s
                            }
                            let name = illness["name"] as? String
                            let description = illness["description"] as? String
                            var type = ""
                            if let t = illness["type"] as? String {
                                type = t
                            }
                            var pref_gender = ""
                            if let g = illness["pref_gender"] as? String {
                                pref_gender = g
                            }
                            let newIllness = Illness(id: id!, prevalence: prev, severity: severity, name: name!, description: description!, type: type, pref_gender: pref_gender)
                            
                            self.allIllnesses.append(newIllness)
                            
                            if self.allIllnesses.count == jsonData.count {
                                self.diagnoseDelegate?.didFinishIllnessRetrieval(illnesses: self.allIllnesses)
                            }
                        }
                    }
                    
                }
        }
        
    }
    
    public func getAllSymptoms() {
        let url = "http://www.lukeporupski.com/php/symptoms.php"
        
        Alamofire.request(url, method: .post, parameters: nil).responseJSON
            {
                response in
                
                if let result = response.value {
                    if let jsonData = result as? [NSDictionary] {
                        for symptom in jsonData {
                            
                            let id = symptom["symptom_id"] as? String
                            let symptom = symptom["description"] as? String
                            let newSymptom = Symptom(id: id!, symptom: symptom!)
                            
                            self.allSymptoms.append(newSymptom)
                            
                            if self.allSymptoms.count == jsonData.count {
                                self.diagnoseDelegate?.didFinishSymptomRetrieval(symptoms: self.allSymptoms)
                            }
                        }
                    }
                    
                }
        }
    }
    
    
    public func getSymptoms(forIllness: String) {
        let url = "http://www.lukeporupski.com/php/symptomsForIllness.php?illness_id=\(forIllness)"
        print(url)
        var symptomsForIllness = [Symptom]()
        
        Alamofire.request(url, method: .post, parameters: nil).responseJSON
            {
                response in
                
                if let result = response.value {
                    if let jsonData = result as? [NSDictionary] {
                        for symptom in jsonData {
                            
                            let id = symptom["symptom_id"] as? String
                            let symptom = symptom["description"] as? String
                            let newSymptom = Symptom(id: id!, symptom: symptom!)
                            symptomsForIllness.append(newSymptom)
                            
                            if symptomsForIllness.count == jsonData.count {
                                self.illnessDelegate?.didFinishSymptomRetrieval(symptoms: symptomsForIllness)
                            }
                        }
                    }
                    
                }
        }
    }
    
    
    public func getRemedies(forIllness: String) {
        let url = "http://www.lukeporupski.com/php/remediesForIllness.php?illness_id=\(forIllness)"
        print(url)
        
        var remediesForIllness = [Remedy]()
        
        Alamofire.request(url, method: .post, parameters: nil).responseJSON
            {
                response in
                
                if let result = response.value {
                    if let jsonData = result as? [NSDictionary] {
                        for remedy in jsonData {
                            
                            let name = remedy["name"] as? String
                            let supplier = remedy["supplier"] as? String
                            let cost = remedy["direct_cost"] as? String
                            let id = remedy["remedy_id"] as? String
                            let purchasable = remedy["purchasable"] as? String
                            
                            let newRem = Remedy(name: name!, supplier: supplier!, cost: cost!, id: id!, purchasable: purchasable!)
                            
                            remediesForIllness.append(newRem)
                            
                            if remediesForIllness.count == jsonData.count {
                                self.illnessDelegate?.didFinishRemedyRetrieval(remedies: remediesForIllness)
                            }
                        }
                    }
                    
                }
        }
    }
    
    public func getIllnessesForRemedy(id: String) {
        let url = "http://www.lukeporupski.com/php/illnessesForRemedy.php?remedy_id=\(id)"
        var ills = [Illness]()
        
        Alamofire.request(url, method: .post, parameters: nil).responseJSON
            {
                response in
                
                if let result = response.value {
                    //converting it as NSDictionary
                    if let jsonData = result as? [NSDictionary] {
                        for illness in jsonData {
                            
                            let id = illness["illness_id"] as? String
                            var prev = ""
                            if let p = illness["prevalence"] as? String {
                                prev = p
                            }
                            var severity = ""
                            if let s = illness["severity"] as? String {
                                severity = s
                            }
                            let name = illness["name"] as? String
                            let description = illness["description"] as? String
                            var type = ""
                            if let t = illness["type"] as? String {
                                type = t
                            }
                            var pref_gender = ""
                            if let g = illness["pref_gender"] as? String {
                                pref_gender = g
                            }
                            let newIllness = Illness(id: id!, prevalence: prev, severity: severity, name: name!, description: description!, type: type, pref_gender: pref_gender)
                            ills.append(newIllness)
                            
                            if ills.count == jsonData.count {
                                self.remedyDetailDelegate?.didFinishIllnessRetrieval(items: ills)
                            }
                        }
                    }
                    
                }
        }
    }
    
    
    
    
    
    //USER INFO METHODS
    
    public func getPaymentMethods(for user: String) {
        
        let url = "http://www.lukeporupski.com/php/getPaymentMethods.php?user=\(user)"
        
        var methods = [Payment]()
        
        
        Alamofire.request(url, method: .post, parameters: nil).responseJSON
            {
                response in
                
                if let result = response.value {
                    //converting it as NSDictionary
                    if let jsonData = result as? [NSDictionary] {
                        for method in jsonData {
                            
                            let number = method["card_number"] as? String
                            let address = method["address"] as? String
                            
                            let newMethod = Payment(cNum: number!, add: address!)
                            
                            methods.append(newMethod)
                            
                            if methods.count == jsonData.count {
                                self.purchaseDelegate?.didFinishPaymentMethodsRetrieval(methods: methods)
                            }
                            
                            
                        }
                        
                    }
                }
        }
        
    }
    
    public func addPaymentMethod(user: String, cNum: String, address: String) -> Bool {
        
        let url = "http://www.lukeporupski.com/php/addPaymentMethod.php?user=\(user)&card_number=\(cNum)&address=\(address)"
        
        var flag = true
        
        //Sending http post request
        Alamofire.request(url, method: .get, parameters: nil).responseJSON
            {
                response in
                
                
                switch response.result {
                case .success( _):
                    break
                case .failure(let error):
                    print("failed with error: \(error)")
                    flag = false
                    break
                }
        }
        
        return flag
        
    }
    
    public func getOrders(for user: String) {
        
        let url = "http://www.lukeporupski.com/php/getOrderItems.php?user=\(user)"
        
        var orders = [Order]()
        
        
        Alamofire.request(url, method: .post, parameters: nil).responseJSON
            {
                response in
                
                if let result = response.value {
                    //converting it as NSDictionary
                    if let jsonData = result as? [NSDictionary] {
                        for order in jsonData {
                            
                            let date = order["order_date"] as? String
                            let repurchase_date = order["repurchase_date"] as? String
                            let id = order["order_id"] as? String
                            let status = order["status"] as? String
                            
                            let newOrder = Order(d: date!, r: repurchase_date!, i: id!, s: status!)
                            
                            orders.append(newOrder)
                            
                            if orders.count == jsonData.count {
                                self.profileDelegate?.didFinishOrdersRetrieval(orders: orders)
                            }
                            
                            
                        }
                        
                    }
                }
        }
        
    }
    
    public func getDiagnoses(for user: String) {
        
        
        
    }
    
    public func diagnoseForSymptoms(symptoms: [Symptom]) {
        
        var url = "http://www.lukeporupski.com/php/getDiagnosis.php?items[]="
        var illnesses = [Illness]()
        url += "\(symptoms[0].id)"
        if symptoms.count > 1 {
            for s in symptoms[1..<symptoms.count] {
                url += "&items[]=\(s.id)"
            }
        }
        
        Alamofire.request(url, method: .post, parameters: nil).responseJSON
            {
                response in
                
                if let result = response.value {
                    if let jsonData = result as? [NSDictionary] {
                        for illness in jsonData {
                            
                            let id = illness["illness_id"] as? String
                            var prev = ""
                            if let p = illness["prevalence"] as? String {
                                prev = p
                            }
                            var severity = ""
                            if let s = illness["severity"] as? String {
                                severity = s
                            }
                            let name = illness["name"] as? String
                            let description = illness["description"] as? String
                            var type = ""
                            if let t = illness["type"] as? String {
                                type = t
                            }
                            var pref_gender = ""
                            if let g = illness["pref_gender"] as? String {
                                pref_gender = g
                            }
                            let newIllness = Illness(id: id!, prevalence: prev, severity: severity, name: name!, description: description!, type: type, pref_gender: pref_gender)
                            illnesses.append(newIllness)
                            
                            if illnesses.count == jsonData.count {
                                self.diagnosisViewDelegate?.didFinishDiagnosis(illnesses: illnesses)
                            }
                            
                        }
                        
                    }
                }
        }
    }
    
    
    
    //CART / PURCHASE METHODS
    
    public func getCartItems(for user: String){
        
        let url = "http://www.lukeporupski.com/php/cartItems.php?user=\(user)"
        
        var cItems = [Remedy]()
        
        
        Alamofire.request(url, method: .post, parameters: nil).responseJSON
            {
                response in
                
                if let result = response.value {
                    //converting it as NSDictionary
                    if let jsonData = result as? [NSDictionary] {
                        for remedy in jsonData {
                            
                            let name = remedy["name"] as? String
                            
                            let supplier = remedy["supplier"] as? String
                            let cost = remedy["direct_cost"] as? String
                            let id = remedy["remedy_id"] as? String
                            let purchasable = remedy["purchasable"] as? String
                            
                            let newRem = Remedy(name: name!, supplier: supplier!, cost: cost!, id: id!, purchasable: purchasable!)
                            
                            cItems.append(newRem)
                            
                            if cItems.count == jsonData.count {
                                self.cartDelegate?.didFinishRetrieval(items: cItems)
                            }
                            
                            
                        }
                        
                    }
                }
        }
    }
    
    
    public func addCartItem(item: String, user: String) -> Bool{
        
        let url = "http://www.lukeporupski.com/php/addCartItem.php?item=\(item)&user=\(user)"
        
        var flag = true
        
        //Sending http post request
        Alamofire.request(url, method: .get, parameters: nil).responseJSON
        {
                response in
                
                
                switch response.result {
                case .success( _):
                    break
                case .failure(let error):
                    print("failed with error: \(error)")
                    flag = false
                    break
                }
        }
        
        return flag
        
    }
    
    
    public func removeCartItem(item: String, user: String) -> Bool {
        
        let url = "http://www.lukeporupski.com/php/removeCartItem.php?item=\(item)&user=\(user)"
        
        var flag = true
        
        //Sending http post request
        Alamofire.request(url, method: .get, parameters: nil).responseJSON
            {
                response in
                
                
                switch response.result {
                case .success( _):
                    self.cartDelegate?.didFinishItemRemoval()
                    break
                case .failure(let error):
                    print("failed with error: \(error)")
                    flag = false
                    break
                }
        }
        
        return flag
    }
    
    public func getTopBid(auction_id: String) {
        
        
        let url = "http://www.lukeporupski.com/php/getTopBid.php?auction_id=\(auction_id)"
        
        
        Alamofire.request(url, method: .post, parameters: nil).responseJSON
            {
                response in
                
                if let result = response.value {
                    if let val = result as? Double {
                        self.auctionDelegate?.didRetrieveTopBid(amount: val)
                    }
                    else {
                        self.auctionDelegate?.didRetrieveTopBid(amount: -1.0)
                    }
                    
                }
        }
        
        
        
        
    }
    
    public func executeAuctionBid(auction_id: String, amount: String, user: String) {
        
        let url = "http://www.lukeporupski.com/php/executeAuctionBid.php?auction_id=\(auction_id)&user=\(user)&amount=\(amount)"
        Alamofire.request(url, method: .get, parameters: nil).responseJSON
            {
                response in
                
                switch response.result {
                case .success( _):
                    break
                case .failure(let error):
                    print("failed with error: \(error)")
                    break
                }
        }
        
    }
    
    public func executeBuyItNow(item: String, user: String, address: String) {
        
        
        
    }
    
    public func executeCartPurchase(user: String, address: String) {
        
        let url = "http://www.lukeporupski.com/php/executeCartPurchase.php?user=\(user)&address=\(address)"
        Alamofire.request(url, method: .get, parameters: nil).responseJSON
            {
                response in
                
                switch response.result {
                case .success( _):
                    break
                case .failure(let error):
                    print("failed with error: \(error)")
                    break
                }
        }
        
    }
    
    public func executeAuctionPurchase(auction_id: String) {
        
        let url = "http://www.lukeporupski.com/php/executeAuctionPurchase.php?auction_id=\(auction_id)"
        Alamofire.request(url, method: .get, parameters: nil).responseJSON
            {
                response in
                
                switch response.result {
                case .success( _):
                    break
                case .failure(let error):
                    print("failed with error: \(error)")
                    break
                }
        }
    }
    
    public func getAuctions(forRemedyID: String) {
        let url = "http://www.lukeporupski.com/php/auctionsForRemedy.php?remedy_id=\(forRemedyID)"
        
        var auctions = [Auction]()
        
        
        Alamofire.request(url, method: .post, parameters: nil).responseJSON
            {
                response in
                
                if let result = response.value {
                    //converting it as NSDictionary
                    if let jsonData = result as? [NSDictionary] {
                        for auction in jsonData {
                            
                            let auction_id = auction["auction_id"] as? String
                            
                            let remedy_id = auction["remedy_id"] as? String
                            let end_date = auction["end_date"] as? String
                            let reserve_price = auction["reserve_price"] as? String
                            let newAuc = Auction(id: auction_id!, reserve_price: reserve_price!, end_date: end_date!, remedy_id: remedy_id!)
                            
                            auctions.append(newAuc)
                            
                            if auctions.count == jsonData.count {
                                self.remedyDetailDelegate?.didFinishAuctionRetrieval(items: auctions)
                            }
                            
                        }
                        
                    }
                }
        }
    }
    
    
    
    //DOCTOR / INSURANCE METHODS
    public func getSpecialists(forDisease disease: String, loc: CLLocationCoordinate2D){
        
    }
    
    
}
