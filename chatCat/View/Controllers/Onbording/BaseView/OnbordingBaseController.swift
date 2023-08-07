//
//  OnbordingBaseController.swift
//  chatCat
//
//  Created by admin1 on 2.08.23.
//

import UIKit

final class OnbordingBaseController: UIViewController {
    
    @IBOutlet weak var ovalView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lableText: UILabel!
    @IBOutlet weak var subtitleText: UILabel!
    
    init(image: UIImage? = nil, text: String? = nil, subtitle: String? = nil){
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        self.imageView?.image = image
        self.lableText?.text = text
        self.subtitleText.text = subtitle
        
        self.imageView?.backgroundColor = R.Colors.bgColor
    }
    
    override func viewWillLayoutSubviews() {
        drawOval()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView(test: String) {
        imageView?.image = UIImage(named: test)
    }
    
    private func drawOval() {
        let ovalPath = UIBezierPath()
        let startPoint = CGPoint(x: ovalView.bounds.minX, y: ovalView.bounds.maxY)
        let endPoint = CGPoint(x: view.frame.width, y: ovalView.bounds.maxY)
        let controlPoint = CGPoint(x: ovalView.bounds.midX, y: ovalView.bounds.minY - ovalView.bounds.height)
        ovalPath.move(to: startPoint)
        ovalPath.addQuadCurve(to: endPoint, controlPoint: controlPoint)

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = ovalPath.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor

        ovalView.layer.addSublayer(shapeLayer)
    }
}


