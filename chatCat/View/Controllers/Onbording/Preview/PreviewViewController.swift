//
//  PreviewViewController.swift
//  chatCat
//
//  Created by admin1 on 5.08.23.
//

import UIKit

final class PreviewViewController: UIViewController {
    
    var timer: Timer?
    
    let viewheart: UIView = {
        let view = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        view.backgroundColor = .magenta
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.Colors.btnActive
        
        startTimer()
        drawStar()
        startPulsatingAnimation()
        viewheart.center = view.center
        view.addSubview(viewheart)
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerDidFire), userInfo: nil, repeats: false)
    }
    
    @objc func timerDidFire() {
        let onbording = OnbordingPageViewController()
        timer?.invalidate()
        onbording.modalPresentationStyle = .fullScreen
        present(onbording, animated: true)
    }
    
    private func drawStar() {
        let starPath = UIBezierPath()
        let size: CGFloat = min(viewheart.bounds.width, viewheart.bounds.height)
        let scaleFactor: CGFloat = size / 100.0
        let offsetX = viewheart.bounds.width / 2
        let offsetY = viewheart.bounds.height / 2
        
        // Углы звезды
        let starPoints: [CGPoint] = [
            CGPoint(x: 50, y: 10),
            CGPoint(x: 61.8, y: 39.5),
            CGPoint(x: 95.1, y: 39.5),
            CGPoint(x: 68.7, y: 63),
            CGPoint(x: 79.3, y: 91),
            CGPoint(x: 50, y: 75.5),
            CGPoint(x: 20.7, y: 91),
            CGPoint(x: 31.3, y: 63),
            CGPoint(x: 4.9, y: 39.5),
            CGPoint(x: 38.2, y: 39.5)
        ]
        
        // Создаем путь звезды
        for (index, point) in starPoints.enumerated() {
            let adjustedX = point.x * scaleFactor + offsetX
            let adjustedY = point.y * scaleFactor + offsetY
            
            if index == 0 {
                starPath.move(to: CGPoint(x: adjustedX, y: adjustedY))
            } else {
                starPath.addLine(to: CGPoint(x: adjustedX, y: adjustedY))
            }
        }
        
        starPath.close()
        
        let starLayer = CAShapeLayer()
        starLayer.path = starPath.cgPath
        starLayer.fillColor = R.Colors.viewActive.cgColor
        
        viewheart.layer.addSublayer(starLayer)
    }
    
    private func startPulsatingAnimation() {
        let pulsatingAnimation = CABasicAnimation(keyPath: "opacity")
        pulsatingAnimation.fromValue = 1.0
        pulsatingAnimation.toValue = 0.1
        pulsatingAnimation.duration = 1
        pulsatingAnimation.autoreverses = true
        pulsatingAnimation.repeatCount = .infinity
        viewheart.layer.add(pulsatingAnimation, forKey: "pulsating")
    }
}
