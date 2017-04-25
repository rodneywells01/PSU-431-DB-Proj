//
//  Symptom.swift
//  Diagnose Me
//
//  Created by Luke Porupski on 4/6/17.
//  Copyright © 2017 Luke Porupski. All rights reserved.
//

import Foundation

class Symptom {
    
    var id: String
    var symptom: String
    
    init(id: String, symptom: String) {
        self.id = id
        self.symptom = symptom
    }
}
