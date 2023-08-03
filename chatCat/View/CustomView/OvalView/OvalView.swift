//
//  OvalView.swift
//  chatCat
//
//  Created by admin1 on 2.08.23.
//

import UIKit

@IBDesignable
final class OvalView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        drawOval()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        drawOval()
    }

    private func drawOval() {
        let ovalPath = UIBezierPath()
        let startPoint = CGPoint(x: bounds.minX, y: bounds.maxY)
        let endPoint = CGPoint(x: bounds.maxX, y: bounds.maxY)
        let controlPoint = CGPoint(x: bounds.midX, y: bounds.minY-bounds.height)
        ovalPath.move(to: startPoint)
        ovalPath.addQuadCurve(to: endPoint, controlPoint: controlPoint)

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = ovalPath.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor

        layer.addSublayer(shapeLayer)
    }
}

