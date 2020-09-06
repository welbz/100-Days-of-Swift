//
//  ViewController.swift
//  Project22
//
//  Created by Welby Jennings on 6/9/20.

//  https://www.hackingwithswift.com/100/75
    //https://www.hackingwithswift.com/read/22/2/requesting-location-core-location
    //https://www.hackingwithswift.com/read/22/3/hunting-the-beacon-clbeaconregion

// MARK: - Setup
/*
 2 x Privacy rows to info.plist
 import CoreLocation
 */

import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var distanceReading: UILabel!
    var locationManager: CLLocationManager?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        
        // requests permission to read users location
        locationManager?.requestAlwaysAuthorization()
        // If you have already been granted location permission then things will Just Work; if you haven't, iOS will request it now
        
        view.backgroundColor = .gray
        // while in unknown mode we dont know distance, we make bg grey
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == .authorizedAlways {
                if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                    if CLLocationManager.isRangingAvailable() {
                        startScanning() //start looking for the beacon
                    }
                }
            }
    }
    
    func startScanning(){
        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 123, minor: 456, identifier: "MyBeacon")
        
        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(in: beaconRegion)
        // deprecated - use startRangingBeacons(satisfying constraint: CLBeaconIdentityConstraint)
    }
    
    func update(distance: CLProximity) {
        UIView.animate(withDuration: 1) {
            switch distance {
            case .far:
                self.view.backgroundColor = .blue
                self.distanceReading.text = "FAR"
                
            case .near:
                self.view.backgroundColor = .orange
                self.distanceReading.text = "NEAR"
                
            case .immediate:
                self.view.backgroundColor = .red
                self.distanceReading.text = "RIGHT HERE"
                
            default:
                self.view.backgroundColor = .gray
                self.distanceReading.text = "UNKNOWN"
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if let beacon = beacons.first {
            update(distance: beacon.proximity)
        } else {
            update(distance: .unknown)
        }
    }
}

// MARK: - Notes
/*
locationManager?.requestWhenInUseAuthorization()
 - Can use instead for only when in use
 
 Older devices dont have siupport functionality
 
 ******
 
 isMonitoringAvailable = can this thing detect if there is a beacon exists or not?
 
 if thats true,
 isRangingAvailable = can we detect how far away the beacon is
 
 if both true,
 We do our work
 
 */
