//
//  BarCalloutViewController.swift
//  BestBar
//
//  Created by Chris McLearnon on 12/09/2019.
//  Copyright © 2019 BelfastLabs. All rights reserved.
//

import UIKit
import MapKit

class BarCalloutViewController: UIView {

    @IBOutlet weak var barTitleLabel: UILabel!
    @IBOutlet weak var barSubtitleLabel: UILabel!
    
    override open func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let hitTest = super.hitTest(point, with: event)
        {
            superview?.bringSubviewToFront(self)
            return hitTest
        }
        return nil
    }
    

    @IBAction func detailButtonTapped(_ sender: Any) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
