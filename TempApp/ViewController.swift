//
//  ViewController.swift
//  TempApp
//
//  Created by Wade Sellers on 6/23/23.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    let address = "https://api.wmata.com/Bus.svc/json/jStops/"
    let apiKey = "?api_key=e13626d03d8e4c03ac07f95541b3091b"
    let region = "&Lat=38.89731&Lon=-77.00626&Radius=2000"

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        let query = "\(address)\(apiKey)\(region)"
        DispatchQueue.global(qos: .userInitiated).async {
            [unowned self] in
            if let url = URL(string: query) {
                if let data = try? Data(contentsOf: url) {
                    let json = try! JSON(data: data)
                    self.parse(json: json)
                    return
                }
            }
            self.loadError()
        }
    }
    
    //mapView delegate functions
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.first!
        let center = currentLocation.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: center, span: span)
        self.mapView.setRegion(region, animated: true)
    }
    
    func parse(json: JSON) {
        for result in json["Stops"].arrayValue {
            let latitude = result["Lat"].doubleValue
            let longitude = result["Lon"].doubleValue
            let location = CLLocationCoordinate2D(latitude:latitude, longitude: longitude)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            mapView.addAnnotation(annotation)
        }
    }
    
    func loadError() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Loading Error", message: "There was a problem loading the bus stop data", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }


}

