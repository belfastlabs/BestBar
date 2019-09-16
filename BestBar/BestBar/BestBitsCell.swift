//
//  BestBitsCell.swift
//  BestBar
//
//  Created by Chris McLearnon on 13/09/2019.
//  Copyright © 2019 BelfastLabs. All rights reserved.
//

import Foundation
import UIKit

class BestBitsCell: UICollectionViewCell {
    
    @IBOutlet weak var bestBitLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8.0
    }
}
