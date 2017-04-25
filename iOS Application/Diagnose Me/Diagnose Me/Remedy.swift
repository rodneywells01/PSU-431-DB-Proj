//
//  Remedy.swift
//  Diagnose Me
//
//  Created by Luke Porupski on 4/6/17.
//  Copyright © 2017 Luke Porupski. All rights reserved.
//

import Foundation

class Remedy {
    
    var name: String
    var supplier: String
    var cost: String
    var id: String
    var purchasable: String
    
    init(name: String, supplier: String, cost: String, id: String, purchasable: String) {
        self.name = name
        self.supplier = supplier
        self.cost = cost
        self.id = id
        self.purchasable = purchasable
    }
}
