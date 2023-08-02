//
//  EmotionView.swift
//  chatCat
//
//  Created by admin1 on 2.08.23.
//

import UIKit
import AVFoundation

@IBDesignable
final class EmotionView: UIView {
    
    var audioPlayer: AVAudioPlayer?
    
    @IBOutlet weak var imageCatView: UIImageView!
    @IBOutlet weak var volumeUp: UIImageView!
    @IBOutlet weak var lableText: UILabel!
    
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
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.borderWidth = 1
        volumeUp.image = R.Images.Emotions.volumeUp
        audioPlayer?.play()
    }
    
    func setupAV(valueSong: Int) {
        guard let soundURL = Bundle.main.url(forResource: "sound\(valueSong)", withExtension: "m4a") else {
            fatalError("Звуковой файл не найден")
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
        } catch {
            print("Ошибка создания AVAudioPlayer: \(error.localizedDescription)")
        }
        
        if let player = audioPlayer {
            player.prepareToPlay()
        } else {
            print("AVAudioPlayer не создан")
        }
    }
}
