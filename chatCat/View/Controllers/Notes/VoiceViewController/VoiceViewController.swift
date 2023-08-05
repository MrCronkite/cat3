//
//  VoiceVIewController.swift
//  chatCat
//
//  Created by admin1 on 2.08.23.
//

import UIKit
import AVFoundation

protocol VoiceViewControllerDelegate: AnyObject {
    func showVoices(voices: [Voices])
}

final class VoiceViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer?
    var voices = [Voices]()
    var duration = String()
    
    weak var delegate: VoiceViewControllerDelegate?
    
    @IBOutlet weak var lableText: UILabel!
    @IBOutlet weak var timeVoiceText: UILabel!
    @IBOutlet weak var textFieldNameVoice: UITextField!
    @IBOutlet weak var reRecordButton: UIButton!
    @IBOutlet weak var saveVoiceButton: UIButton!
    @IBOutlet weak var voiceView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    @IBAction func closeVC(_ sender: Any) {
        if let audioURL = UserDefaults.standard.url(forKey: "recordedAudioURL") {
            self.deleteAudioFile(atPath: audioURL.absoluteString)
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func playVoice(_ sender: Any) {
        audioPlayer?.play()
    }
    
    @IBAction func saveVoice(_ sender: Any) {
        guard let audioURL = UserDefaults.standard.url(forKey: "recordedAudioURL") else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd 'at' h:mm a"
        
        let dateString = dateFormatter.string(from: Date())
        
        let voice: Voices = .init(name: textFieldNameVoice.text ?? "No name voice",
                                  voiceUrl: audioURL,
                                  data: dateString,
                                  duration: self.duration)
        voices.append(voice)
        delegate?.showVoices(voices: voices)
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func reRecordVoice(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func textFieldEditingChanged(_ sender: Any) {
        if let text = textFieldNameVoice.text, !text.isEmpty {
            textFieldNameVoice.layer.borderColor = R.Colors.viewActive.cgColor
        } else {
            textFieldNameVoice.layer.borderColor = R.Colors.bgSettingd.cgColor
        }
    }
    
}

extension VoiceViewController {
    private func setupView() {
        view.backgroundColor = .white
        
        lableText.textColor = R.Colors.viewActive
        voiceView.backgroundColor = R.Colors.bgSettingd
        voiceView.layer.cornerRadius = 16
        
        textFieldNameVoice.layer.borderColor = R.Colors.bgSettingd.cgColor
        textFieldNameVoice.borderStyle = .none
        textFieldNameVoice.layer.cornerRadius = 14
        textFieldNameVoice.layer.borderWidth = 1
        textFieldNameVoice.textColor = R.Colors.viewActive
        
        saveVoiceButton.layer.cornerRadius = 20
        saveVoiceButton.backgroundColor = R.Colors.btnActive
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: textFieldNameVoice.frame.height))
        textFieldNameVoice.leftView = leftPaddingView
        textFieldNameVoice.leftViewMode = .always
        textFieldNameVoice.delegate = self
        
        let okButton = UIButton(type: .system)
           okButton.setTitle("OK", for: .normal)
           okButton.addTarget(self, action: #selector(hideKeyboard), for: .touchUpInside)

        textFieldNameVoice.inputAccessoryView = okButton
        
        guard let audioURL = UserDefaults.standard.url(forKey: "recordedAudioURL") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
            audioPlayer?.prepareToPlay()
        } catch {
            print("Ошибка воспроизведения аудио: \(error.localizedDescription)")
        }
        
        guard let player = audioPlayer else { return }
        let currentTime = player.duration
        let duration = formatTime(currentTime)
        self.duration = duration
        timeVoiceText.text = duration
        
        func formatTime(_ time: TimeInterval) -> String {
            let minutes = Int(time / 60)
            let seconds = Int(time.truncatingRemainder(dividingBy: 60))
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
    
    func deleteAudioFile(atPath path: String) {
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(atPath: path)
        } catch {
            print("Ошибка при удалении аудиофайла: \(error.localizedDescription)")
        }
    }
}

extension VoiceViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.inputAccessoryView = .some(UIButton(type: .system))
        textField.resignFirstResponder()
        return true
    }
    
    @objc func hideKeyboard() {
        textFieldNameVoice.resignFirstResponder()
    }
}
