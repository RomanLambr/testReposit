//
//  GoogleRoute.swift
//  Brief Mobile
//
//  Created by Roma Lambr on 4/24/17.
//  Copyright © 2017 Roma Lambr. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct GoogleRoute {
  
    static func drawRouteBeetwen(currentLocation:CLLocationCoordinate2D,and destinationlocation:CLLocationCoordinate2D, success:@escaping (GMSPolyline)->Void, error:@escaping (Error?)->Void ) {
        //MARK:-Properties
        let origin = "\(currentLocation.latitude),\(currentLocation.longitude)"
        let destination = "\(destinationlocation.latitude),\(destinationlocation.longitude)"
        let apikey = Default.googleMapDirectionApi
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=\(apikey)"
        //APi - Request
        Alamofire.request(url).responseJSON { response in
            if response.result.isSuccess{
                guard let data = response.data else {return}
    
            let json = JSON(data: data)
            let routes = json["routes"].arrayValue
            
                let route = routes[0]
                    let routeOverviewPolyline = route["overview_polyline"].dictionary
                    let points = routeOverviewPolyline?["points"]?.stringValue
                    let path = GMSPath.init(fromEncodedPath: points!)
                    let polyline = GMSPolyline(path: path)
                    polyline.strokeWidth = 6.0
                    polyline.strokeColor = UIColor.red
                success(polyline)
            }
            if response.result.isFailure {
                error(response.result.error)
            }
        }
    }
}
