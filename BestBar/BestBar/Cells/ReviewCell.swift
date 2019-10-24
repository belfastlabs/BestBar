//
//  ReviewCell.swift
//  BestBar
//
//  Created by Chris McLearnon on 23/10/2019.
//  Copyright © 2019 BelfastLabs. All rights reserved.
//

import Foundation
import UIKit
import Cosmos

class ReviewCell: UICollectionViewCell {
    @IBOutlet weak var reviewHeadingLabel: UILabel!
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var reviewText: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
}
