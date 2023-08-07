//
//  WhistleViewController.swift
//  chatCat
//
//  Created by admin1 on 1.08.23.
//

import UIKit
import AVFoundation

final class WhistleViewController: UIViewController {
    
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var audioFile: AVAudioFile!
    var pitchEffect: AVAudioUnitTimePitch!
    var audioManager = AudioManagerImpl()
    
    @IBOutlet weak var howToUseButton: UIButton!
    @IBOutlet weak var noiseTitle: UILabel!
    @IBOutlet weak var sliderNoise: UISlider!
    @IBOutlet weak var navBar: NavBarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupAudioSession()
        setupView()
        setupAudio()
        updatePitchEffect()
    }
    override func viewWillAppear(_ animated: Bool) {
       audioManager.setupAudioSession(true)
    }
    
    @IBAction func showDirection(_ sender: Any) {
        let vc = DirectionViewController()
        vc.modalPresentationStyle = .popover
        present(vc, animated: true)
    }
    
    @IBAction func updateSlider(_ sender: Any) {
        updatePitchEffect()
        updateLabelValue(value: sliderNoise.value)
    }
    
    @IBAction func goWhistle(_ sender: Any) {
        if !audioEngine.isRunning {
            audioPlayerNode.stop()
            audioPlayerNode.reset()
            audioManager.setupAudioSession(true)
        } else {
            let audioURL = Bundle.main.url(forResource: "svist", withExtension: "mp3")!
            do {
                audioFile = try AVAudioFile(forReading: audioURL)
                audioPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)
                audioPlayerNode.play()
            } catch {
                print("Ошибка при воспроизведении аудио: \(error.localizedDescription)")
            }
        }
        
    }
}

extension WhistleViewController {
    private func setupView() {
        howToUseButton.tintColor = R.Colors.viewActive
        noiseTitle.textColor = R.Colors.viewActive
        sliderNoise.minimumTrackTintColor = R.Colors.viewActive
        sliderNoise.setThumbImage(UIImage(named: "thumb"), for: .normal)
        
        navigationController?.navigationBar.isHidden = true
        navBar.delegate = self
        navBar.titleText.text = "Whistle"
    }
    
    func updateLabelValue(value: Float) {
        let formattedValue = String(format: "%.f", value)
        noiseTitle.text = "\(formattedValue) HZ"
    }
    
    func setupAudio() {
        audioEngine = AVAudioEngine()
        audioPlayerNode = AVAudioPlayerNode()
        audioPlayerNode.volume = 1
        audioEngine.attach(audioPlayerNode)
        
        pitchEffect = AVAudioUnitTimePitch()
        audioEngine.attach(pitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: pitchEffect, format: nil)
        audioEngine.connect(pitchEffect, to: audioEngine.outputNode, format: nil)
        
        do {
            try audioEngine.start()
        } catch {
            print("Ошибка при запуске audioEngine: \(error.localizedDescription)")
        }
    }
    
    func updatePitchEffect() {
        let frequency = sliderNoise.value
        pitchEffect.pitch = frequency
    }
    
        func setupAudioSession() {
            do {
                let audioSession = AVAudioSession.sharedInstance()
                try audioSession.setCategory(.playback, mode: .default)
                try audioSession.setActive(true)
            } catch {
                print("Ошибка при настройке аудиосессии: \(error.localizedDescription)")
            }
        }
}

extension WhistleViewController: NavBarViewDelegate {
    func showVC() {
        let vc = SettingsViewController()
        show(vc, sender: nil)
    }
}
