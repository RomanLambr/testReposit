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
    
    //MARK: - IBOutlet
    @IBOutlet weak var mapView: GMSMapView!
    
    //MARK: - Properties
    var branches :[Branch] = []
    let locationManager = CLLocationManager()
    var selected : GMSMarker?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavigationBar()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getBranchesFromApi()
        calculateCameraPosition(markerArray: branches)
    }
   
    //MARK: - Add branches to map
    func addArrayBranches(branches:[Branch]){
        for branch in branches{
            addMarkerToMap(branch: branch)
        }
    }
    func addMarkerToMap(branch: Branch){
        
            let coordinate = CLLocationCoordinate2D(latitude: branch.latitude, longitude: branch.longitude )
            let marker = GMSMarker(position: coordinate)
            marker.icon = Def.passiveImage
            marker.title = branch.title
            marker.map = mapView
    }
    
    //MARK: - Api
    func getBranchesFromApi(){
        ServerManager.shared.getBranchesFromServer(success: { (branches) in
            self.branches = branches
            self.addArrayBranches(branches: branches)
            
        }, failure: {(error) in
            
        })
    }
    
    //MARK: - Map Calculation
    func calculateCameraPosition(markerArray:[Branch]){
        var bounds = GMSCoordinateBounds()
        for marker in markerArray {
            bounds = bounds.includingCoordinate(marker.position)
        }
        if let mylocation = mapView.myLocation?.coordinate {
            bounds = bounds.includingCoordinate(mylocation)
        }
        let update = GMSCameraUpdate.fit(bounds, withPadding: 60)
        
        mapView.animate(with: update)
    }
}



    // MARK: - CLLocationManagerDelegate
extension MapBranchesViewController: CLLocationManagerDelegate {
   func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            mapView.isMyLocationEnabled = true
          
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            calculateCameraPosition(markerArray: branches)
            locationManager.stopUpdatingLocation()
            
        }
    }
    
}
    // MARK: - GMSMapViewDelegate
extension MapBranchesViewController:GMSMapViewDelegate{

    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if marker == selected {
            return true
        }
        if let sel = selected{
            deActivateMarker(marker: sel)
        }
        activateMarker(marker: marker)
        selected = marker
        return true
    }
    
    func activateMarker (marker: GMSMarker){
        marker.icon = Def.activeImage
    }
   
    func deActivateMarker (marker: GMSMarker){
        marker.icon = Def.passiveImage
    }
    
}

