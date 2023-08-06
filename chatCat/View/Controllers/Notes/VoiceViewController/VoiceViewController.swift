//
//  VoiceVIewController.swift
//  chatCat
//
//  Created by admin1 on 2.08.23.
//

import UIKit

protocol VoiceViewControllerDelegate: AnyObject {
    func showVoices(voices: [Voices])
}

final class VoiceViewController: UIViewController {
    
    var audioLink: URL?
    var voices = [Voices]() 
    var duration = String()
    var audioManager = AudioManagerImpl()
    var storeManager = StorageManagerImpl()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        audioManager.deactivateAudioSession()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        audioManager.deactivateAudioSession()
    }
    
    @IBAction func closeVC(_ sender: Any) {
        deleteAudioFile(at: audioLink!)
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func playVoice(_ sender: Any) {
        audioManager.setupAudioSession(true)
        audioManager.play()
    }
    
    @IBAction func saveVoice(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd 'at' h:mm a"
        
        let dateString = dateFormatter.string(from: Date())
        
        let voice: Voices = .init(name: textFieldNameVoice.text ?? "No name voice",
                                  voiceUrl: audioLink!,
                                  data: dateString,
                                  duration: self.duration)
        voices = storeManager.get(forKey: .keyVoice) ?? []
        voices.append(voice)
        storeManager.set(voices, forKey: .keyVoice)
        delegate?.showVoices(voices: voices)
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func reRecordVoice(_ sender: Any) {
        deleteAudioFile(at: audioLink!)
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
        tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .white
        
        lableText.textColor = R.Colors.viewActive
        voiceView.backgroundColor = R.Colors.bgSettingd
        voiceView.layer.cornerRadius = 16
        
        textFieldNameVoice.layer.borderColor = R.Colors.bgSettingd.cgColor
        textFieldNameVoice.borderStyle = .none
        textFieldNameVoice.layer.cornerRadius = 14
        textFieldNameVoice.layer.borderWidth = 1
        textFieldNameVoice.textColor = R.Colors.viewActive
        
        saveVoiceButton.layer.cornerRadius = 25
        saveVoiceButton.setTitleColor(.white, for: .normal)
        saveVoiceButton.backgroundColor = R.Colors.btnActive
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: textFieldNameVoice.frame.height))
        textFieldNameVoice.leftView = leftPaddingView
        textFieldNameVoice.leftViewMode = .always
        
        let player = audioManager.setupAudioPlayer(link: self.audioLink!)
        
        let currentTime = player.duration
        let duration = self.lableText.formatTime(currentTime)
        self.duration = duration
        timeVoiceText.text = duration
    }
    
    func deleteAudioFile(at url: URL) {
        
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(at: url)
            print("Аудиофайл успешно удален.")
        } catch {
            print("Ошибка при удалении аудиофайла: \(error)")
        }
    }
}

extension VoiceViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.inputAccessoryView = .some(UIButton(type: .system))
        textField.resignFirstResponder()
        return true
    }
}
