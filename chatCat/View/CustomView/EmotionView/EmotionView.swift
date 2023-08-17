//
//  EmotionView.swift
//  chatCat
//
//  Created by admin1 on 2.08.23.
//

import UIKit
import AVFoundation

protocol EmotionViewDelegate: AnyObject {
    func showAlert()
}

@IBDesignable
final class EmotionView: UIView {
    
    let audioManager = AudioManagerImpl()
    var timer: Timer?
    
    @IBOutlet weak var imageCatView: UIImageView!
    @IBOutlet weak var volumeUp: UIImageView!
    @IBOutlet weak var lableText: UILabel!
    
    weak var delegate: EmotionViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
}

extension EmotionView {
    private func setupView() {
        guard let view = self.loadViewFromNib(nibName: "EmotionView") else { return }
        view.frame = self.bounds
        view.backgroundColor = R.Colors.bgSettingd
        view.layer.cornerRadius = 20
        
        self.layer.cornerRadius = 20
        self.addSubview(view)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handlerTap(_: )))
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }
    
    @objc private func handlerTap(_ gesture: UITapGestureRecognizer) {
        volumeUp.image = R.Images.Emotions.volumeUp
        audioManager.play()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerDidFire), userInfo: nil, repeats: false)

        UIView.animate(withDuration: 0.6) {
            self.layer.borderColor = UIColor.blue.cgColor
            self.layer.borderWidth = 1
        }
        delegate?.showAlert()
    }
    
    @objc func timerDidFire() {
        timer?.invalidate()
        volumeUp.image = .none
        UIView.animate(withDuration: 0.1) {
            self.layer.borderColor = UIColor.white.cgColor
            self.layer.borderWidth = 1
        }
    }
    
    func setupAV(valueSong: Int) {
        guard let soundURL = Bundle.main.url(forResource: "\(valueSong)", withExtension: "m4a") else {
            fatalError("Звуковой файл не найден")
        }
        audioManager.setupPlayer(link: soundURL )
    }
}
