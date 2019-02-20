//
//  DetailViewController.swift
//  FilmLocations
//
//  Created by John Edwards on 2/19/19.
//  Copyright © 2019 John Edwards. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    var film: Film?
    let initLocation = CLLocation(latitude: 37.773972, longitude: -122.431297)
    let regionRadius: CLLocationDistance = 7_500
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        centerMapOnLocation(location: initLocation)
        addMapLocations()
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func addMapLocations() {
        var mapItems = [MKAnnotation]()
        if let thisFilm = self.film {
            let locations = Array(thisFilm.moreInfo.locations.values)
            for location in locations {
                let marker = MKPointAnnotation()
                marker.title = location.locName
                marker.coordinate = CLLocationCoordinate2DMake(location.latitude, location.longitude)
                mapItems.append(marker)
            }
        }
        mapView.addAnnotations(mapItems)
    }
}

// MARK: - MKMapViewDelegate
extension DetailViewController : MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
}
