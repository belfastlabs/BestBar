//
//  BarAnnotation.swift
//  BestBar
//
//  Created by Chris McLearnon on 29/08/2019.
//  Copyright © 2019 BelfastLabs. All rights reserved.
//

import Foundation
import MapKit
import FirebaseFirestore

class BarAnnotation: NSObject, MKAnnotation {
    
    let title: String!
    let subtitle: String!
    var coordinate: CLLocationCoordinate2D
    var barID: String!
    
    var dictionary: [String: Any] {
        return [
            "title": title,
            "subtitle": subtitle,
            "location": coordinate,
            "barID": barID
        ]
    }
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D, barID: String) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.barID = barID
        
        super.init()
    }
}

extension BarAnnotation {
    convenience init?(dictionary: [String : Any]) {
        guard let title = dictionary["title"] as? String,
            let subtitle = dictionary["subtitle"] as? String,
            let coordinate = CLLocationCoordinate2D.locationWithGeopoint(geopoint: (dictionary["location"] as? GeoPoint)!) as? CLLocationCoordinate2D,
            let barID = dictionary["barID"] as? String else { return nil }
        
        self.init(title: title,
                  subtitle: subtitle,
                  coordinate: coordinate,
                  barID: barID)
    }
}

class BarAnnotationList: NSObject {
    private static var barAnnotations: [BarAnnotation] = []
    
    static var count: Int {
        return BarAnnotationList.barAnnotations.count
    }
    
    public static func annotationAtIndex(index: Int) -> BarAnnotation {
        return BarAnnotationList.barAnnotations[index]
    }
    
    func populateList(map: [BarAnnotation]) {
        BarAnnotationList.barAnnotations = []
        for item in map {
            BarAnnotationList.barAnnotations.append(item)
        }
    }
}
