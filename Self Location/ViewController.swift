//
//  ViewController.swift
//  Self Location
//
//  Created by Abhishek Thakur on 01/05/19.
//  Copyright © 2019 Abhishek Thakur. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapview: MKMapView!
    let locationManger = CLLocationManager()
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        let coord = locationManger.location?.coordinate
        
        if let lat = coord?.latitude{
            if let long = coord?.longitude{
                DataStore().StoredDataPoint(latitude: String(lat), longitude: String(long))
                UpdateSavedPin()
        }
        
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    locationManger.delegate = self
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
        
    }
    func UpdateSavedPin(){
        if let oldCoords = DataStore().GetLastLocation(){
            let annoRem = mapview.annotations.filter{$0 !== mapview.userLocation}
            mapview.removeAnnotations(annoRem)
            let annotation = MKPointAnnotation()
            annotation.coordinate.latitude = Double(oldCoords.latitude)!
            annotation.coordinate.longitude = Double(oldCoords.longtitude)!
            annotation.title = "I was here!!"
            annotation.subtitle = "Remember?"
            mapview.addAnnotation(annotation)
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            print("Location not enabled")
            return
        }
        print("Location Allowed")
        mapview.showsUserLocation = true
    }

}

