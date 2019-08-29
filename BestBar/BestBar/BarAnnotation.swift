//
//  BarAnnotation.swift
//  BestBar
//
//  Created by Chris McLearnon on 29/08/2019.
//  Copyright © 2019 BelfastLabs. All rights reserved.
//

import Foundation
import MapKit

class BarAnnotation: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
//    var dictionary: [String: Any] {
//        return [
//            "title": title,
//            "subtitle": locationName,
//            "location": coordinate,
//        ]
//    }
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
