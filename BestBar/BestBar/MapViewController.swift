//
//  MapViewController.swift
//  BestBar
//
//  Created by Chris McLearnon on 23/08/2019.
//  Copyright © 2019 BelfastLabs. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    let initialLocation = CLLocation(latitude: 54.6004, longitude: -5.9262)
    var annotationSet: [MKAnnotation] = []
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        // Do any additional setup after loading the view.
        self.locationManager.requestAlwaysAuthorization()
        mapView.mapType = .mutedStandard
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        centerMapOnLocation(location: initialLocation)
        setupAnnotations()
    }
    
    func setupAnnotations() {
        let national = BarAnnotation(title: "The National",
                                     locationName: "Boutique bar within city centre",
                                     coordinate: CLLocationCoordinate2D(latitude: 54.6004, longitude: -5.9262))
        mapView.addAnnotation(national)
        
        let merchant = BarAnnotation(title: "THe Merchant Hotel",
                                     locationName: "Luxurious and premium setting",
                                     coordinate: CLLocationCoordinate2D(latitude: 54.6012, longitude: -5.9257))
        mapView.addAnnotation(merchant)
        
        let spaniard = BarAnnotation(title: "The Spaniard",
                                     locationName: "Small and full of charm",
                                     coordinate: CLLocationCoordinate2D(latitude: 54.6010, longitude: -5.9263))
        mapView.addAnnotation(spaniard)
        
        let dirtyOnion = BarAnnotation(title: "Dirty Onion",
                                       locationName: "Rustic and industrail drinking experience",
                                       coordinate: CLLocationCoordinate2D(latitude: 54.6017, longitude: -5.9266))
        mapView.addAnnotation(dirtyOnion)
        
        let clothEar = BarAnnotation(title: "The Cloth Ear",
                                     locationName: "One of Belfast's oldest pubs",
                                     coordinate: CLLocationCoordinate2D(latitude: 54.6012, longitude: -5.9263))
        mapView.addAnnotation(clothEar)
        
        let thirstyGoat = BarAnnotation(title: "The Thirsty Goat",
                                        locationName: "Perfect for those with a thirst",
                                        coordinate: CLLocationCoordinate2D(latitude: 54.6013, longitude: -5.9262))
        mapView.addAnnotation(thirstyGoat)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        annotation.title = "My Location"
        annotation.subtitle = "Test Location"
        
        mapView.addAnnotation(annotation)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 250
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
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

extension MapViewController: MKMapViewDelegate {
    // 1
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? BarAnnotation else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}
