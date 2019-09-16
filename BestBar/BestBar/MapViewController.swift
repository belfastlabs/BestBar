//
//  MapViewController.swift
//  BestBar
//
//  Created by Chris McLearnon on 23/08/2019.
//  Copyright © 2019 BelfastLabs. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class MapViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    let initialLocation = CLLocation(latitude: 54.6004, longitude: -5.9262)
    var annotationSet: [MKAnnotation] = []
    var barAnnotationList = BarAnnotationList()
    
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
        fetchBarLocations()
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
    
    func fetchBarLocations() {
        let db = Firestore.firestore()
        let dbCall = "belfast"
        
        db.collection(dbCall).addSnapshotListener() { (querySnapshot, err) in
            guard let documents = querySnapshot?.documents else {
                print("Error retrieving locations: \(err!)")
                return
            }
            
            let annotationMap = documents.compactMap({
                $0.data().flatMap({ (data) in
                    return BarAnnotation(dictionary: data)
                })
            })
            
            DispatchQueue.main.async {
                for annotation in annotationMap {
                    self.mapView.addAnnotation(annotation)
                }
                self.barAnnotationList.populateList(map: annotationMap)
            }
        }
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
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let vc = UIStoryboard(name: "BarDetailView", bundle: nil).instantiateViewController(withIdentifier: "BarDetailViewController") as! BarDetailViewController
        vc.barTitle = ((view.annotation?.title)!)!
        vc.barSubtitle = ((view.annotation?.subtitle)!)!
        self.present(vc, animated: true, completion: nil)
    }
}
