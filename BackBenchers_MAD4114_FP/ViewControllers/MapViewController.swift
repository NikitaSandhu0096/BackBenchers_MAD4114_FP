//
//  MapViewController.swift
//  BackBenchers_MAD4114_FP
//
//  Created by Nikita Sandhu on 2020-06-18.
//  Copyright © 2020 Nikita Sandhu. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var myMap: MKMapView!
    
    var locationManager = CLLocationManager()
    var myAnnotations = [CLLocation]()
    var points = [CLLocationCoordinate2D]()
    var time = Timer()
    
    var currentLocation = CLLocation()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        myMap.showsUserLocation = true
        myMap.delegate = self
        addPin()
        
        
        // Do any additional setup after loading the view.
    }
    @objc func addPin(){
        let location = CLLocation(latitude: 43.589046, longitude: -79.644119)
        myAnnotations.append(location)
        let myAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2D(latitude: myAnnotations[0].coordinate.latitude, longitude: myAnnotations[0].coordinate.longitude)
        myAnnotation.title = "Current Location"
        myMap.addAnnotation(myAnnotation)
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let zoomArea = MKCoordinateRegion(center: self.myMap.userLocation.coordinate, span: MKCoordinateSpan (latitudeDelta: 0.05, longitudeDelta: 0.05));
        self.myMap.setRegion(zoomArea, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let id = MKMapViewDefaultAnnotationViewReuseIdentifier
        if let v = mapView.dequeueReusableAnnotationView(
        withIdentifier: id, for: annotation) as? MKMarkerAnnotationView {
            
            v.titleVisibility = .visible
            v.subtitleVisibility = .visible
            v.markerTintColor = .orange
            v.glyphText = "!"
            v.glyphTintColor = .systemPink
            return v
        }
        return nil
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
