//
//  Order.swift
//  Diagnose Me
//
//  Created by Luke Porupski on 4/11/17.
//  Copyright © 2017 Luke Porupski. All rights reserved.
//

import Foundation

class Order {
    
    var date: String
    var repurchase_date: Date?
    var id: String
    var status: String
    
    private let formatter = DateFormatter()
    
    init(d: String, r: String, i: String, s:String) {
        
        formatter.dateFormat = "yyyy/MM/dd"
        self.date = d
        //self.date = formatter.date(from: d)!
        self.repurchase_date = formatter.date(from: r)
        self.id = i
        self.status = s
        
    }
    
    init(d: String, i: String, s: String) {
        
        formatter.dateFormat = "yyyy/MM/dd"
        self.date = d
        //self.date = formatter.date(from: d)!
        self.id = i
        self.status = s
        
    }
    
}
