//
//  PickPoint.swift
//
//  Created by Essam Mohamed Fahmi on 9/24/20.
//

import CoreLocation

public class PickPoint: NSObject
{
    // MARK: Properties
    
    public var lat: Double?
    public var lng: Double?
    public var name: String
    
    // MARK: Init
    
    public init(lat: Double? = nil, lng: Double? = nil, name: String = "Select location")
    {
        self.lat = lat
        self.lng = lng
        self.name = name
    }
    
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
