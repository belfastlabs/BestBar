//
//  FirebaseClient.swift
//  BestBar
//
//  Created by Chris McLearnon on 29/08/2019.
//  Copyright © 2019 BelfastLabs. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import MapKit

final class FirebaseClient: NSObject {
    static var sharedInstance: FirebaseClient = FirebaseClient()
    
//    func fetchBarLocations() {
//        let db = Firestore.firestore()
//        let dbCall = "belfast"
//
//        db.collection(dbCall).addSnapshotListener() { (querySnapshot, err) in
//            guard let documents = querySnapshot?.documents else {
//                print("Error retrieving locations: \(err!)")
//                return
//            }
//
//            let annotationMap = documents.compactMap({
//                $0.data().flatMap({ (data) in
//                    return BarAnnotation(title: data.key["title"], locationName: <#T##String#>, coordinate: locationWithGeopoint(geopoint: <#T##GeoPoint#>))
//                })
//            })
//
//
//        }
//    }
    
    func locationWithGeopoint(geopoint: GeoPoint) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: geopoint.latitude, longitude: geopoint.longitude)
    }
}
