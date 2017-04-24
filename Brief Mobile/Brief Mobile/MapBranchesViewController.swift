//
//  MapBranchesViewController.swift
//  Brief Mobile
//
//  Created by Roma Lambr on 4/21/17.
//  Copyright © 2017 Roma Lambr. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON
import GoogleMaps

fileprivate struct Def{
    static let activeImage = #imageLiteral(resourceName: "pin_active_icon")
    static let passiveImage = #imageLiteral(resourceName: "pin_passive_icon")
}
fileprivate enum Icon {
    case up
    case down
    var image: UIImage {
        switch self {
        case .up:
            return #imageLiteral(resourceName: "arrow_up_icon")
        case .down:
            return #imageLiteral(resourceName: "arrow_down_icon")
        }
    }
    
}
class MapBranchesViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var infoView: InfoViewForMap!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var nameBranchLabel: UILabel!
    @IBOutlet weak var detailInfoLabel: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    
    //MARK: - Properties
    var branches :[Branch] = []
    let locationManager = CLLocationManager()
    var selectedMarker : GMSMarker?
    var routePolyline : GMSPolyline?
    var isExtended: Bool = false
    
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
        marker.userData = branch
        marker.map = mapView
    }
    
    //MARK: - Api
    func getBranchesFromApi(){
        ServerManager.shared.getBranchesFromServer(success: { [weak self](branches) in
            self?.branches = branches
            self?.addArrayBranches(branches: branches)
            }, failure: {(error) in
                Default.showAlertMessage(vc: self, titleStr: "Error", messageStr: "Can't get branches from server")
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
    //MARK: - Actions
    @IBAction func upView(_ sender: Any) {
        view.layoutIfNeeded()
       UIView.animate(withDuration: 0.5) {
            if self.selectedMarker != nil{
                self.detailInfoLabel.numberOfLines = self.isExtended ? 1 : 0
                let buttonImage = self.isExtended ? Icon.up.image : Icon.down.image
                self.detailButton.setImage(buttonImage, for: .normal)
                self.isExtended = !self.isExtended
                
            }
        self.view.layoutIfNeeded()
        }
        
       
    }
    
    @IBAction func trackRouteToBranche(_ sender: Any) {
        guard let mylocation = locationManager.location,
            let marker = selectedMarker else { return }
        routePolyline?.map = nil
        GoogleRoute.drawRouteBeetwen(currentLocation: mylocation.coordinate, and: marker.position, success: { [weak self](polyline) in
            self?.routePolyline = polyline
            polyline.map = self?.mapView
        }) { (error) in
            Default.showAlertMessage(vc: self, titleStr: "Error", messageStr: "No internet conection, or can't find route to target")
        }
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
        if marker == selectedMarker {
            return true
        }
        if let sel = selectedMarker{
            deActivateMarker(marker: sel)
        }
        activateMarker(marker: marker)
        selectedMarker = marker
        return true
    }
    
    func activateMarker (marker: GMSMarker){
        marker.icon = Def.activeImage
        guard let data = marker.userData as? Branch else { return }
        nameBranchLabel.text = data.title
        detailInfoLabel.text = createInfoForDetail(branch: data)
    }
    
    func deActivateMarker (marker: GMSMarker){
        marker.icon = Def.passiveImage
        routePolyline?.map = nil
    }
    
    func createInfoForDetail(branch: Branch) -> String{
        let address = branch.address
        let postCode = branch.postalCode
        let fax = branch.fax
        let phone = branch.phone
        let email = branch.email
        
        let detailInfo =    "\(address) \n" +
            "P.O.Box: \(postCode) \n" +
            "T: \(phone) \n" +
            "F: \(fax) \n" +
        "E: \(email)"
        return detailInfo
    }
    
}



