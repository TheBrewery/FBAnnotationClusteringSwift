//
//  FBAnnotation.swift
//  FBAnnotationClusteringSwift
//
//  Created by Robert Chen on 4/2/15.
//  Copyright (c) 2015 Robert Chen. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

public class FBAnnotation: NSObject, MKAnnotation {
    public var coordinate = CLLocationCoordinate2D()
    public var title: String?
    
    convenience init(title: String? = nil, coordinate: CLLocationCoordinate2D) {
        self.init()
        
        self.title = title
        self.coordinate = coordinate
    }
}
