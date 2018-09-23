//
//  ArtworkMarkerView.swift
//  services
//
//  Created by Akhlaq Rao on 9/23/18.
//  Copyright © 2018 BMO. All rights reserved.
//

import Foundation
import MapKit

class ArtworkMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            // 1
            guard let artwork = newValue as? Artwork else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            // 2
            markerTintColor = artwork.markerTintColor
            glyphText = String(artwork.vacant.first!)
        }
    }
}
