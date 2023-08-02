//
//  NotesViewController.swift
//  chatCat
//
//  Created by admin1 on 1.08.23.
//

import UIKit

final class NotesViewController: UIViewController {
    
    let animationLayer1 = CALayer()
    let animationLayer = CALayer()
    
    @IBOutlet weak var navBarView: NavBarView!
    @IBOutlet weak var titleDirection: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var catImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupView()
    }
    
    @IBAction func recordingVoice(_ sender: Any) {
        
        
    }
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        
        
        
           if gesture.state == .began {
               animationLayer.frame = playButton.frame
               animationLayer.cornerRadius = 50
               animationLayer.borderColor = R.Colors.borderCircle.cgColor
               animationLayer.borderWidth = 14
               view.layer.insertSublayer(animationLayer, below: playButton.layer)
               
               animationLayer1.frame = playButton.frame
               animationLayer1.cornerRadius = 50
               animationLayer1.borderColor = R.Colors.borderCircle1.cgColor
               animationLayer1.borderWidth = 14
               view.layer.insertSublayer(animationLayer1, below: playButton.layer)
               
               let animation = CABasicAnimation(keyPath: "transform.scale")
               animation.fromValue = 1
               animation.toValue = 1.4
               animation.duration = 0.5
               animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
               animation.fillMode = .forwards
               animation.repeatCount = Float.infinity
               animation.isRemovedOnCompletion = false
               
               let animation1 = CABasicAnimation(keyPath: "transform.scale")
               animation1.fromValue = 1
               animation1.toValue = 1.8
               animation1.duration = 0.5
               animation1.timingFunction = CAMediaTimingFunction(name: .easeOut)
               animation1.fillMode = .forwards
               animation1.repeatCount = Float.infinity
               animation1.isRemovedOnCompletion = false
               
               animationLayer1.add(animation1, forKey: "pulseAnimation1")
               animationLayer.add(animation, forKey: "pulseAnimation")
               
               
           } else if gesture.state == .ended {
               self.animationLayer.removeAllAnimations()
               self.animationLayer1.removeAllAnimations()
               let vc = VoiceViewController()
               navigationController?.pushViewController(vc, animated: true)
               
           }
       }
}

extension NotesViewController {
    private func setupView() {
        titleDirection.textColor = R.Colors.viewActive
        
        navBarView.configureLabel(title: "Voice notes")
        navigationController?.navigationBar.isHidden = true
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        playButton.addGestureRecognizer(longPressGesture)
    }
}
