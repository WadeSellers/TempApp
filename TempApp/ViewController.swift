//
//  ViewController.swift
//  TempApp
//
//  Created by Wade Sellers on 6/23/23.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }


}

