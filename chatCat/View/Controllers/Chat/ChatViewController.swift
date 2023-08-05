//
//  ChatViewController.swift
//  chatCat
//
//  Created by admin1 on 1.08.23.
//

import UIKit

final class ChatViewController: UIViewController {
    
    let animationLayer1 = CALayer()
    let animationLayer = CALayer()
    
    @IBOutlet weak var navBarView: NavBarView!
    @IBOutlet weak var playButtonCat: UIButton!
    @IBOutlet weak var catView: UIView!
    @IBOutlet weak var meView: UIView!
  
    @IBOutlet weak var meImage: UIImageView!
    @IBOutlet weak var catImage: UIImageView!
    
    @IBOutlet weak var lableMe: UILabel!
    
    @IBOutlet weak var lableCat: UILabel!
    
    @IBOutlet weak var textTranslate: UITextField!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stickerView: StickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupView()
    }
    
    func showSetting(view: UIViewController) {

        
        let vc1 = SettingsViewController()
        view.navigationController?.pushViewController(vc1, animated: true)
    }
}

extension ChatViewController {
    private func setupView() {
        navBarView.delegate = self
        navigationController?.navigationBar.isHidden = true
        
        catView.backgroundColor = R.Colors.viewInactive
        meView.backgroundColor = R.Colors.viewActive
        meView.layer.cornerRadius = 19
        catView.layer.cornerRadius = 19
        
        meImage.image = R.Images.Chat.meImg
        meImage.backgroundColor = R.Colors.bgImg
        meImage.layer.cornerRadius = 16
        meImage.layer.borderWidth = 1.5
        meImage.layer.borderColor = UIColor.white.cgColor
        
        catImage.backgroundColor = R.Colors.bgImg
        catImage.image = R.Images.Chat.catImg
        catImage.layer.cornerRadius = 16
        catImage.layer.borderWidth = 1.5
        catImage.layer.borderColor = UIColor.white.cgColor
        
        textTranslate.layer.borderColor = UIColor.white.cgColor
        textTranslate.textColor = R.Colors.viewActive
        textTranslate.borderStyle = .none

        playButtonCat.isHidden = true
        let text = "Enter text to translate..."
        let attributedText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor : R.Colors.viewActive] )
        textTranslate.attributedPlaceholder = attributedText
        
        let longPressGesture = UILongPressGestureRecognizer(target: self,
                                                            action: #selector(handleLongPressMe(_:)))
        playButton.addGestureRecognizer(longPressGesture)
        
        let longPressGestureCat = UILongPressGestureRecognizer(target: self,
                                                               action: #selector(handleLongPressCat(_:)))
        playButtonCat.addGestureRecognizer(longPressGestureCat)
        
        let tapPressGestureMe = UITapGestureRecognizer(target: self,
                                                       action: #selector(handleTapMe(_:)))
        meView.addGestureRecognizer(tapPressGestureMe)
        
        let tapPressGestureCat = UITapGestureRecognizer(target: self,
                                                        action: #selector(handleTapCat(_:)))
        catView.addGestureRecognizer(tapPressGestureCat)
    }
    
    @objc func handleLongPressMe(_ gesture: UILongPressGestureRecognizer) {
        
           if gesture.state == .began {
               animationButton(btn: playButton)
               playButton.setImage(R.Images.Chat.pauseImg, for: .normal)
           } else if gesture.state == .ended {
               playButton.setImage(R.Images.Chat.micro, for: .normal)
               self.animationLayer.removeAllAnimations()
               self.animationLayer1.removeAllAnimations()
               self.animationLayer1.borderColor = UIColor.clear.cgColor
               self.animationLayer.borderColor = UIColor.clear.cgColor
           }
    }
    
    @objc func handleLongPressCat(_ gesture: UILongPressGestureRecognizer) {
        
           if gesture.state == .began {
               animationButton(btn: playButtonCat)
               playButtonCat.setImage(R.Images.Chat.pauseImg130, for: .normal)
           } else if gesture.state == .ended {
               playButtonCat.setImage(R.Images.Chat.micro130, for: .normal)
               self.animationLayer.removeAllAnimations()
               self.animationLayer1.removeAllAnimations()
               self.animationLayer1.borderColor = UIColor.clear.cgColor
               self.animationLayer.borderColor = UIColor.clear.cgColor
           }
    }
    
    private func animationButton(btn: UIButton) {
        animationLayer.frame = btn.frame
        animationLayer.cornerRadius = btn.frame.width / 2
        animationLayer.borderColor = R.Colors.borderCircle.cgColor
        animationLayer.borderWidth = btn.frame.width / 7
        view.layer.insertSublayer(animationLayer, below: btn.layer)
        
        animationLayer1.frame = btn.frame
        animationLayer1.cornerRadius = btn.frame.width / 2
        animationLayer1.borderColor = R.Colors.borderCircle1.cgColor
        animationLayer1.borderWidth = btn.frame.width / 7
        view.layer.insertSublayer(animationLayer1, below: btn.layer)
        
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
    }
    
    @objc func handleTapMe(_ gesture: UITapGestureRecognizer) {
        textTranslate.isHidden = false
        UIView.animate(withDuration: 0.5) {
            self.playButtonCat.isHidden = true
            self.playButton.isHidden = false
            self.catView.backgroundColor = R.Colors.viewInactive
            self.meView.backgroundColor = R.Colors.viewActive
        }
    }
    
    @objc func handleTapCat(_ gesture: UITapGestureRecognizer) {
        textTranslate.isHidden = true
        UIView.animate(withDuration: 0.5) {
            self.playButtonCat.setImage(R.Images.Chat.micro130, for: .normal)
            self.playButton.isHidden = true
            self.playButtonCat.isHidden = false
            self.catView.backgroundColor = R.Colors.viewActive
            self.meView.backgroundColor = R.Colors.viewInactive
        }
    }
}

extension ChatViewController: NavBarViewDelegate {
    func showVC() {
        let vc = SettingsViewController()
        show(vc, sender: nil)
    }
}
