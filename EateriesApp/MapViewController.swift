//
//  MapViewController.swift
//  EateriesApp
//
//  Created by Dev Apps4Selling on 14/01/2019.
//  Copyright © 2019 Dev Apps4Selling. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController, MKMapViewDelegate {

    
    var restaraunt: Restaurant!
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(restaraunt.location!) { (placemarks, error) in
            guard error == nil else { return }
            guard let placemarks = placemarks else { return }
            
            let placemark = placemarks.first!
            
            let annotation = MKPointAnnotation()
            annotation.title = self.restaraunt.name
            annotation.subtitle = self.restaraunt.type
            
            guard let location = placemark.location else { return }
            annotation.coordinate = location.coordinate
            
            self.mapView.showAnnotations([annotation], animated: true)
            self.mapView.selectAnnotation(annotation, animated: true)
        }
    }
    

    func mapView(_ mapView: MKMapView,  viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        let annotationIdentifier = "restAnnotation"
        var annotaionView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        
        if annotaionView == nil {
            annotaionView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotaionView?.canShowCallout = true
        }
        let rightImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        rightImage.image = UIImage(data: restaraunt.image! as Data )
        annotaionView?.rightCalloutAccessoryView = rightImage
        
//        annotaionView?.pinTintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        
        return annotaionView
    }

}
