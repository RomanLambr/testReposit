//
//  MapBranchesViewController.swift
//  Brief Mobile
//
//  Created by Roma Lambr on 4/21/17.
//  Copyright © 2017 Roma Lambr. All rights reserved.
//


import UIKit
import GoogleMaps

fileprivate struct Def{
    static let activeImage = #imageLiteral(resourceName: "pin_active_icon")
    static let passiveImage = #imageLiteral(resourceName: "pin_passive_icon")
}

class MapBranchesViewController: UIViewController {
    
    //
    let json : [String : Any] = ["id": 8,
        "title": "Larnaca Office",
        "address": "AVENSIA COURT III\r\nApt. 310 Grigory Avxentiou &\r\nApostolou Varnava Street,\r\nLarnaca",
        "phone": "24 623544",
        "fax": "24 629183",
        "email": "larnacabranch@royalcrowninsurance.eu",
        "postal_code": "6032",
        "latitude": 34.9174668892825,
        "longitude": 33.6361921951175]
    
    let json2 : [String : Any] = ["id": 8,
                                  "title": "Larnaca Office",
                                  "address": "AVENSIA COURT III\r\nApt. 310 Grigory Avxentiou &\r\nApostolou Varnava Street,\r\nLarnaca",
                                  "phone": "24 623544",
                                  "fax": "24 629183",
                                  "email": "larnacabranch@royalcrowninsurance.eu",
                                  "postal_code": "6032",
                                  "latitude": 34.9274668892825,
                                  "longitude": 33.6161921951175]
    //
    var branches :[Branch?] = []
    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var createBranch = Branch(json: self.json)
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        branches.append(createBranch)
        createBranch = Branch(json: self.json2)
        branches.append(createBranch)
        addArrayBranches(branches: self.branches)
    }
   
    //MARK: - Private
    
    func addArrayBranches(branches:[Branch?]){
        for branch in branches{
            addMarkerToMap(branch: branch)
        }
    }
    func addMarkerToMap(branch: Branch?){
        if let tempBranch = branch{
            let coordinate = CLLocationCoordinate2D(latitude: tempBranch.latitude , longitude: tempBranch.longitude )
            let marker = GMSMarker(position: coordinate)
            marker.icon = Def.passiveImage
            marker.map = mapView
        }
    }
    

}

// MARK: - CLLocationManagerDelegate

extension MapBranchesViewController: CLLocationManagerDelegate {
   func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            locationManager.stopUpdatingLocation()
        }
        
    }
}

