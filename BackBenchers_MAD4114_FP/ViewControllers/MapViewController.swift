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
    
    var currentLocation = CLLocation()
    
    var notes = [Notes]()
    
    func fetchNotes() {
        guard let data = Notes.fetchNotes() else {
            return
        }
        notes = data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        myMap.showsUserLocation = true
        myMap.delegate = self
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchNotes()
        addPins()
    }
    
    @objc func addPins(){
        
        for note in notes {
            let myAnnotation = MKPointAnnotation()
            myAnnotation.coordinate = CLLocationCoordinate2D(latitude: note.lat, longitude: note.long)
            myAnnotation.title = note.title!.isEmpty ? note.data : note.title
            myMap.addAnnotation(myAnnotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let zoomArea = MKCoordinateRegion(center: self.myMap.userLocation.coordinate, span: MKCoordinateSpan (latitudeDelta: 1, longitudeDelta: 1));
        self.myMap.setRegion(zoomArea, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let id = MKMapViewDefaultAnnotationViewReuseIdentifier
        if let v = mapView.dequeueReusableAnnotationView( withIdentifier: id, for: annotation) as? MKMarkerAnnotationView {

            v.titleVisibility = .visible
            v.subtitleVisibility = .visible
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
