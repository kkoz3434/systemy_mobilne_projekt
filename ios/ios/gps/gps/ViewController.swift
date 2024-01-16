//
//  ViewController.swift
//  gps
//
//  Created by Tomek Koszarek on 15/01/2024.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    let locationManager = CLLocationManager()
    
    var startTime: Date?

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        startTime = Date()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            latitudeLabel.text = "Latitude: \(location.coordinate.latitude)"
            longitudeLabel.text = "Longitude: \(location.coordinate.longitude)"

            if let startTime = startTime {
                let elapsedTime = Date().timeIntervalSince(startTime)
                timeLabel.text = "Time: \(elapsedTime)"
                locationManager.stopUpdatingLocation()
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

}

