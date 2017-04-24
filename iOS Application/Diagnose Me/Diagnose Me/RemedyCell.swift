//
//  RemedyCell.swift
//  Diagnose Me
//
//  Created by Luke Porupski on 4/5/17.
//  Copyright © 2017 Luke Porupski. All rights reserved.
//

import UIKit

class RemedyCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var supplierLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!

    var name, supplier, cost: String?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let n = name {
            self.nameLabel.text = n
        }
        if let s = supplier {
            self.supplierLabel.text = s
        }
        if let c = cost {
            self.costLabel.text = c
        }
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    
}
