//
//  ArtWork.swift
//  services
//
//  Created by Akhlaq Rao on 9/23/18.
//  Copyright © 2018 BMO. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let vacant: String
    let streetNumber: String
    let streetName: String
    let postalCode: String
    let phoneNumber: String
    let waitList: String
    let availList: String
    let totalList: String
    let coordinate: CLLocationCoordinate2D
    
    // markerTintColor for disciplines: Sculpture, Plaque, Mural, Monument, other
    var markerTintColor: UIColor  {
        switch vacant {
        case "0":
            return .red
        default:
            return .green
        }
    }
    
    init(title: String, locationName: String, vacant: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.vacant = vacant
        self.coordinate = coordinate
        self.streetNumber = ""
        self.streetName = ""
        self.postalCode = ""
        self.phoneNumber = ""
        self.waitList = ""
        self.availList = ""
        self.totalList = ""
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
    
    init?(json: [String:Any]) {
        // 1
        self.title = json["bldgname"] as? String
        self.locationName = json["loc_name"] as! String
        self.vacant = json["igvacant"] as! String
        self.streetNumber = json["str_no"] as! String
        self.streetName = json["street"] as! String
        self.postalCode = json["pcode"] as! String
        self.phoneNumber = json["phone"] as! String
        self.waitList = json["igwaitlist"] as! String
        self.availList = json["igvacant"] as! String
        self.totalList = json["totspace"] as! String
        
        // 2
        if let latitude = Double(json["latitude"] as! String),
            let longitude = Double(json["longitude"] as! String) {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            self.coordinate = CLLocationCoordinate2D()
        }
    }
    
    // Annotation right callout accessory opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}
