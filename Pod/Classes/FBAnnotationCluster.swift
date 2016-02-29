//
//  FBAnnotationCluster.swift
//  FBAnnotationClusteringSwift
//
//  Created by Robert Chen on 4/2/15.
//  Copyright (c) 2015 Robert Chen. All rights reserved.
//

import Foundation
import MapKit

public class FBAnnotationCluster: NSObject, MKAnnotation {
    public var coordinate = CLLocationCoordinate2D()
    public var annotations = [MKAnnotation]()

    public var title: String?
    public var subtitle: String?
    
    public override init() {
        super.init()
    }
    
    convenience init(title: String? = nil, subtitle: String? = nil, coordinate: CLLocationCoordinate2D, annotations: [MKAnnotation]) {
        self.init()

        self.title = title ?? "cluster"
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.annotations = annotations
    }
}