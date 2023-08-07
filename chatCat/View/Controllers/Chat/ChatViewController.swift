//
//  ChatViewController.swift
//  chatCat
//
//  Created by admin1 on 1.08.23.
//

import UIKit

final class ChatViewController: UIViewController {
    var timer: Timer?
    
    let animationLayer1 = CALayer()
    let animationLayer = CALayer()
    let audioManager = AudioManagerImpl()
    
    @IBOutlet weak var stickerView: StickerView!
    
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
        navBarView.titleText.text = ""
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
        textTranslate.delegate = self

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
               showSticker()
               timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerDidFireMe), userInfo: nil, repeats: false)
               
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
               showSticker()
               timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerDidFireCat), userInfo: nil, repeats: false)
               
               self.animationLayer.removeAllAnimations()
               self.animationLayer1.removeAllAnimations()
               self.animationLayer1.borderColor = UIColor.clear.cgColor
               self.animationLayer.borderColor = UIColor.clear.cgColor
           }
    }
    
    @objc func timerDidFireMe() {
        stickerView.isHidden = true
        playButtonCat.isHidden = true
        textTranslate.isHidden = false
        playButton.isHidden = false
        timer?.invalidate()
    }
    
    @objc func timerDidFireCat() {
        stickerView.isHidden = true
        playButtonCat.isHidden = false
        textTranslate.isHidden = true
        playButton.isHidden = true
        timer?.invalidate()
    }
    
    private func showSticker() {
        let randomNumber = Int(arc4random_uniform(UInt32(21 - 1 + 1))) + 1
        let soundURL = Bundle.main.url(forResource: "sound\(randomNumber)", withExtension: "m4a")
        audioManager.setupPlayer(link: soundURL!)
        stickerView.setupImage(image: String(randomNumber))
        stickerView.isHidden = false
        playButtonCat.isHidden = true
        textTranslate.isHidden = true
        playButton.isHidden = true
        audioManager.setupAudioSession(true)
        audioManager.play()
    }
    
    @objc func handleTapMe(_ gesture: UITapGestureRecognizer) {
        textTranslate.isHidden = false
        playButtonCat.isHidden = true
        playButton.isHidden = false
        UIView.animate(withDuration: 0.5) {
            self.catView.backgroundColor = R.Colors.viewInactive
            self.meView.backgroundColor = R.Colors.viewActive
        }
    }
    
    @objc func handleTapCat(_ gesture: UITapGestureRecognizer) {
        textTranslate.isHidden = true
        playButton.isHidden = true
        playButtonCat.isHidden = false
        UIView.animate(withDuration: 0.5) {
            self.playButtonCat.setImage(R.Images.Chat.micro130, for: .normal)
            self.catView.backgroundColor = R.Colors.viewActive
            self.meView.backgroundColor = R.Colors.viewInactive
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
}

extension ChatViewController: NavBarViewDelegate {
    func showVC() {
        let vc = SettingsViewController()
        show(vc, sender: nil)
    }
}

extension ChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        showSticker()
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(timerDidFireMe), userInfo: nil, repeats: false)
        
        return true
    }
}


