//
//  DataStore.swift
//  Self Location
//
//  Created by Abhishek Thakur on 02/05/19.
//  Copyright © 2019 Abhishek Thakur. All rights reserved.
//

import Foundation
struct StorageKeys {
    static let storedLat = "StoredLat"
    static let storedLong = "StoredLong"
}

class DataStore {
    func GetDefaults () ->  UserDefaults {
        return UserDefaults.standard
    }
    func StoredDataPoint (latitude: String, longitude: String){
        let def  = GetDefaults()
        def.setValue(latitude, forKey: StorageKeys.storedLat)
        def.setValue(longitude, forKey: StorageKeys.storedLong)
        def.synchronize()
        print(latitude + " " + longitude)
    }
    func GetLastLocation () -> VisitedPoint? {
        let defaults = GetDefaults()
        if let lat = defaults.string(forKey: StorageKeys.storedLat){
            if let long = defaults.string(forKey: StorageKeys.storedLong){
                return VisitedPoint(lat: lat, long: long)
            }
        }
        return nil
    }
}

