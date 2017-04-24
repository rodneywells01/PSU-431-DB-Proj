//
//  Illness.swift
//  Diagnose Me
//
//  Created by Luke Porupski on 4/6/17.
//  Copyright © 2017 Luke Porupski. All rights reserved.
//

import Foundation

class Illness {
    
    var id: String
    var prevalence: String
    var severity: String
    var name: String
    var description: String
    var type: String
    var pref_gender: String
    
    init(id: String, prevalence: String, severity: String, name: String, description: String, type: String, pref_gender: String) {
        self.id = id
        self.prevalence = prevalence
        self.severity = severity
        self.name = name
        self.description = description
        self.type = type
        self.pref_gender = pref_gender
    }
    
}
