//
//  DetailViewController.swift
//  TempApp
//
//  Created by Wade Sellers on 6/23/23.
//

import UIKit
import MapKit
import CoreLocation

class DetailViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var routesLabel: UILabel!
    
    let locationManager = CLLocationManager()
    var selectedAnnotation = MKPointAnnotation()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.addAnnotation(selectedAnnotation)
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        nameLabel.text = "Stop: \(selectedAnnotation.title!)"
        routesLabel.text = selectedAnnotation.subtitle
    }
    

    //locationManager Delegate functions
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.mapView.showAnnotations(mapView.annotations, animated: true)
        locationManager.stopUpdatingLocation()
    }

}
