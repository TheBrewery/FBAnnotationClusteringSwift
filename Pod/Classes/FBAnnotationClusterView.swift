//
//  FBAnnotationClusterView.swift
//  FBAnnotationClusteringSwift
//
//  Created by Robert Chen on 4/2/15.
//  Copyright (c) 2015 Robert Chen. All rights reserved.
//

import Foundation
import MapKit

extension UIColor {
    func lighterColorForColor(colorAdjustmentFactor: CGFloat? = 0.05) -> UIColor {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        
        if getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: min(r + colorAdjustmentFactor!, 1.0), green: min(g + colorAdjustmentFactor!, 1.0), blue: min(b + colorAdjustmentFactor!, 1.0), alpha: a)
        }
        return UIColor()
    }
}

public class FBAnnotationClusterView: MKAnnotationView {
    private lazy var countLabel: UILabel = {
        let countLabel = UILabel(frame: self.bounds)
        countLabel.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        countLabel.textAlignment = .Center
        countLabel.backgroundColor = UIColor.clearColor()
        countLabel.textColor = UIColor.whiteColor()
        countLabel.adjustsFontSizeToFitWidth = true
        countLabel.minimumScaleFactor = 2
        countLabel.numberOfLines = 1
        countLabel.font = self.font
        countLabel.baselineAdjustment = .AlignCenters
        self.addSubview(countLabel)
        return countLabel
    }()
    
    var borderWidth = CGFloat(0.0) {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    dynamic public var font = UIFont.systemFontOfSize(14.0) {
        didSet {
            countLabel.font = font
        }
    }
        
    dynamic public var textColor = UIColor.whiteColor() {
        didSet {
            countLabel.textColor = textColor
        }
    }
    
    override public var annotation: MKAnnotation? {
        didSet {
            guard let cluster = annotation as? FBAnnotationCluster else {
                return countLabel.text = nil
            }
            countLabel.text = "\(cluster.annotations.count)"
        }
    }
    
    dynamic public var locations: [CGFloat] = [0.0, 1.0]
    dynamic public var colors = [UIColor.purpleColor(), UIColor.purpleColor().lighterColorForColor(0.3)]

    
    public override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.annotation = annotation
        
        layer.masksToBounds = true
        layer.borderColor = UIColor.whiteColor().CGColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = self.bounds.size.width / 2
    }
    
    required override public init(frame: CGRect) {
        super.init(frame: frame)
        guard frame != CGRectZero else {
            self.frame = CGRectMake(0, 0, 40.0, 40.0)
            return
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func drawLayer(layer: CALayer, inContext ctx: CGContext) {
        CGContextSaveGState(ctx)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let cgcolors = colors.map({ $0.CGColor })
        let gradient = CGGradientCreateWithColors(colorSpace, cgcolors, locations)
        
        let center = CGPointMake(bounds.width/2.0, bounds.height/2.0)
        CGContextDrawRadialGradient(ctx, gradient, center, 0.0, center, bounds.width/2.0, CGGradientDrawingOptions.DrawsAfterEndLocation)
    }
    
    override public func drawRect(rect: CGRect) {
        
    }
}
