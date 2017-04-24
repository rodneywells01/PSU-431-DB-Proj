//
//  Payment.swift
//  Diagnose Me
//
//  Created by Luke Porupski on 4/11/17.
//  Copyright © 2017 Luke Porupski. All rights reserved.
//

import Foundation

class Payment {
    
    var card_number: String
    var address: String
    
    init(cNum: String, add: String) {
        self.card_number = cNum
        self.address = add
    }
}
