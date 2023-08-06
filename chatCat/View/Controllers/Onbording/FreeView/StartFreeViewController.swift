//
//  StartFreeViewController.swift
//  chatCat
//
//  Created by admin1 on 3.08.23.
//

import UIKit

protocol StartFreeViewControllerDelegate: AnyObject {
    func showButton()
}

final class StartFreeViewController: UIViewController {
    
    @IBOutlet weak var ovalView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var buttonGetFree: UIButton!
    @IBOutlet weak var termUsLabel: UILabel!
    @IBOutlet weak var restoreLabel: UILabel!
    @IBOutlet weak var privacyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var textPRO: UILabel!
    @IBOutlet weak var firstDaysText: UILabel!
    @IBOutlet weak var subtitle2: UILabel!
    
    weak var delegate: StartFreeViewControllerDelegate?

    override func viewWillLayoutSubviews() {
        drawOval()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitleLabel()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        delegate?.showButton()
        self.buttonGetFree.isHidden = false
        setupPulsingAnimation()
        UIView.animate(withDuration: 0.7) {
            self.buttonGetFree.backgroundColor = R.Colors.btnActive
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIView.animate(withDuration: 0.7) {
            self.buttonGetFree.backgroundColor = .white
        }
    }
    
    @IBAction func getFreeTrial(_ sender: Any) {
        let vc = TabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

extension StartFreeViewController {
    private func setupView() {
        view.backgroundColor = .white
        imageView.backgroundColor = R.Colors.bgColor
        
        buttonGetFree.layer.cornerRadius = 25
        buttonGetFree.backgroundColor = R.Colors.btnActive
        
        termUsLabel.textColor = R.Colors.subtitle
        restoreLabel.textColor = R.Colors.subtitle
        privacyLabel.textColor = R.Colors.subtitle
    }
    
    private func setupTitleLabel() {
        let text = "Enjoy all features"
        let attributeText = NSMutableAttributedString(string: text)
        
        attributeText.addAttribute(.foregroundColor, value: R.Colors.viewActive, range: NSRange(location: 0, length: 5))
        
        titleLabel.attributedText = attributeText
        
        textPRO.backgroundColor = R.Colors.viewActive
        textPRO.layer.cornerRadius = 8
        textPRO.layer.masksToBounds = true
        
        let firstText = "First 3 days free,"
        let attributeFirstText = NSMutableAttributedString(string: firstText)
        
        attributeFirstText.addAttribute(.foregroundColor, value: R.Colors.viewActive, range: NSRange(location: 0, length: 17))
        
        firstDaysText.attributedText = attributeFirstText
        
        let secondText = "then 5.99$ per week. cacel at anytime."
        let attributeSecondText = NSMutableAttributedString(string: secondText)
        
        attributeSecondText.addAttribute(.foregroundColor, value: R.Colors.viewActive, range: NSRange(location: 5, length: 16))
        
        subtitle2.attributedText = attributeSecondText
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
    
    private func setupPulsingAnimation() {
            let pulseLayer = CALayer()
        pulseLayer.bounds = buttonGetFree.bounds
            pulseLayer.position = buttonGetFree.center
            pulseLayer.cornerRadius = 25
        pulseLayer.backgroundColor = R.Colors.btnActive.cgColor
            view.layer.insertSublayer(pulseLayer, below: buttonGetFree.layer)
            
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.duration = 1
            animation.fromValue = 0.9
        animation.toValue = 1.1
            animation.autoreverses = true
            animation.repeatCount = Float.infinity
            pulseLayer.add(animation, forKey: "pulsing")
        }
}

