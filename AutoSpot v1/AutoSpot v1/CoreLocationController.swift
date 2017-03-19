//
//  CoreLocationController.swift
//  AutoSpot v1
//
//  Created by Andy Peng on 2/19/15.
//  Copyright (c) 2015 Andy Peng/Daniel Shafrir. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class CoreLocationController: NSObject, CLLocationManagerDelegate {
    var locationManager:CLLocationManager = CLLocationManager()
    var carLocationLatitude: Double?
    var carLocationLongitude: Double?
    var distToCarLat: Double?
    var distToCarLong: Double?
    var myLocationLatitude: Double?
    var myLocationLongitude: Double?
    var theta: Double?
    var direction: CLLocationDirection?
    var radians: Double?
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.distanceFilter  = kCLDistanceFilterNone
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager.requestAlwaysAuthorization()
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        println("didChangeAuthorizationStatus")
        
        switch status {
        case .NotDetermined:
            println(".NotDetermined")
            break
            
        case .Authorized:
            println(".Authorized")
            self.locationManager.startUpdatingLocation()
            self.locationManager.startUpdatingHeading()
            break
            
        case .Denied:
            println(".Denied")
            break
            
        default:
            println("Unhandled authorization status")
            break
            
        }
    }

    /*func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
        
        direction = newHeading.magneticHeading
        radians = -Double(direction!) / 180.0 * M_PI
    }*/
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        let location = locations.last as CLLocation
        self.myLocationLatitude = location.coordinate.latitude
        self.myLocationLongitude = location.coordinate.longitude
        
        
        println("didUpdateLocations:  \(location.coordinate.latitude), \(location.coordinate.longitude)")
        
        if (self.carLocationLatitude != nil && self.carLocationLongitude != nil) {
            self.distToCarLat = location.coordinate.latitude - self.carLocationLatitude!
            self.distToCarLong = location.coordinate.longitude - self.carLocationLongitude!
            self.theta = /*self.radians! - */atan2(self.distToCarLat!, self.distToCarLong!)
            println("toCar:  \(self.distToCarLat!), \(self.distToCarLong!)")
            println("theta:  \(self.theta!)")
        }
    }
    
    func dropPin() {
        self.carLocationLatitude = self.myLocationLatitude
        self.carLocationLongitude = self.myLocationLongitude
    }
    
}
