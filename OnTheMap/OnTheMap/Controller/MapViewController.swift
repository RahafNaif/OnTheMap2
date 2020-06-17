//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Rahaf Naif on 24/10/1441 AH.
//  Copyright © 1441 Rahaf Naif. All rights reserved.
//

import UIKit
import MapKit

class MapViewController : UIViewController, MKMapViewDelegate{
  
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var annotations = [MKPointAnnotation]()
        
        let locations = parseAPI.getRequest(completionHandler:{  (StudentLocationList, error) in

        
        for dictionary in locations {
            
            let lat = CLLocationDegrees(dictionary["latitude"] as! Double)
            let long = CLLocationDegrees(dictionary["longitude"] as! Double)
            
            // The lat and long are used to create a CLLocationCoordinates2D instance.
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = dictionary["firstName"] as! String
            let last = dictionary["lastName"] as! String
            let mediaURL = dictionary["mediaURL"] as! String
            
            // Here we create the annotation and set its coordiate, title, and subtitle properties
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            // Finally we place the annotation in an array of annotations.
            annotations.append(annotation)
            
        }
        self.mapView.addAnnotations(annotations)
        })
        
    }
        
}
        
    

    

