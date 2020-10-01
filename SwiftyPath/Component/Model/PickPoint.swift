//
//  PickPoint.swift
//
//  Created by Essam Mohamed Fahmi on 9/24/20.
//

import CoreLocation

public class PickPoint: NSObject
{
    // MARK: Properties
    
    var lat: Double?
    var lng: Double?
    var name: String = "Select location"
    
    // MARK: Methods
    
    func toCoordinate2D() -> CLLocationCoordinate2D?
    {
        if let latitude = lat, let latitudeDegrees = CLLocationDegrees(exactly: latitude),
           let longitude = lng, let longitudeDegrees = CLLocationDegrees(exactly: longitude)
        {
            return CLLocationCoordinate2D(latitude: latitudeDegrees, longitude: longitudeDegrees)
        }
        
        return nil
    }
}
