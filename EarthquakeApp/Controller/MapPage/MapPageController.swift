//
//  MapPageController.swift
//  EarthquakeApp
//
//  Created by xzy on 2024/1/31.
//

import UIKit
import MapKit

class MapPageController: UIViewController {
    
    var feature: Features?
    
    private var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.UIInit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let geometry = feature?.geometry {
            if geometry.type == "Point" {
                if let coordinates = geometry.coordinates {
                    if coordinates.count > 1 {
                        let coordinate = CLLocationCoordinate2D(latitude: coordinates[1], longitude: coordinates[0])
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = coordinate
                        annotation.title = feature?.properties?.place ?? ""
                        annotation.subtitle = ""
                        self.mapView.addAnnotation(annotation)
                        
                        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000000, longitudinalMeters: 1000000)
                        self.mapView.setRegion(region, animated: true)
                    }
                }
            }
        }
    }
    
    private func UIInit() {
        // init map view
        self.mapView = MKMapView(frame: self.view.bounds)
        self.view.addSubview(self.mapView)
    }
    
    deinit {
        print("MapPageController dealloc")
    }
    
}
