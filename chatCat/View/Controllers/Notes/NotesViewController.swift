//
//  NotesViewController.swift
//  chatCat
//
//  Created by admin1 on 1.08.23.
//

import UIKit
import AVFoundation

final class NotesViewController: UIViewController {
    
    var voices: [Voices] = []
    
    var audioRecorder: AVAudioRecorder?
    var isRecording = false
    let animationLayer1 = CALayer()
    let animationLayer = CALayer()
    var link: URL?
    let storeManager = StorageManagerImpl()
    let audioManger = AudioManagerImpl()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var navBarView: NavBarView!
    @IBOutlet weak var titleDirection: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var catImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        if voices.count == 0 {
            catImageView.isHidden = false
            titleDirection.isHidden = false
            tableView.isHidden = true
        }
        setAudioRecorder()
    }
    
    @IBAction func recordingVoice(_ sender: Any) {
        
    }
}

extension NotesViewController {
    private func setupView() {
        view.backgroundColor = .white
        titleDirection.textColor = R.Colors.viewActive
        
        navBarView.configureLabel(title: "Voice notes")
        navigationController?.navigationBar.isHidden = true
        
        navBarView.delegate = self
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.noIntrinsicMetric
        tableView.separatorStyle = .none
        tableView.register(CustomViewCell.self, forCellReuseIdentifier: "\(CustomViewCell.self)")
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        playButton.addGestureRecognizer(longPressGesture)
        
        if let data = storeManager.get(forKey: .keyVoice) {
            self.voices = data
            tableView.isHidden = false
            catImageView.isHidden = true
            titleDirection.isHidden = true
        } else {
            tableView.isHidden = true
            catImageView.isHidden = false
            titleDirection.isHidden = false
        }
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
            
            saveFile()
            
            if let recorder = audioRecorder, !recorder.isRecording {
                recorder.record()
            }
            
        } else if gesture.state == .ended {
            self.animationLayer.removeAllAnimations()
            self.animationLayer1.removeAllAnimations()
            let vc = VoiceViewController()
            vc.delegate = self
            vc.audioLink = self.link
            navigationController?.pushViewController(vc, animated: true)
            
            if let recorder = audioRecorder, recorder.isRecording {
                recorder.stop()
            }
        }
    }
}

extension NotesViewController: VoiceViewControllerDelegate {
    func showVoices(voices: [Voices]) {
        if tableView.isHidden == true {
            tableView.isHidden = false
            catImageView.isHidden = true
            titleDirection.isHidden = true
        }
        self.voices = storeManager.get(forKey: .keyVoice)!
        tableView.reloadData()
    }
}


extension NotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        voices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(CustomViewCell.self)", for: indexPath) as? CustomViewCell else { return UITableViewCell() }
        cell.data.text = voices[indexPath.row].data
        cell.title.text = voices[indexPath.row].name
        cell.time.text = voices[indexPath.row].duration
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        voices.remove(at: indexPath.row)
        storeManager.set(voices, forKey: .keyVoice)
        tableView.deleteRows(at: [indexPath], with: .left)
        if voices.count == 0 {
            self.tableView.isHidden = true
            self.catImageView.isHidden = false
            self.titleDirection.isHidden = false
        }
        }
            
        func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
            return true
        }
}

extension NotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        72
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            UIView.animate(withDuration: 0.1, animations: {
                cell.alpha = 0.7
                cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }) { (completed) in
                UIView.animate(withDuration: 0.1, animations: {
                    cell.alpha = 1.0
                    cell.transform = CGAffineTransform.identity
                })
            }
        }
    }
}

extension NotesViewController: NavBarViewDelegate {
    func showVC() {
        let vc = SettingsViewController()
        show(vc, sender: nil)
    }
}

//MARK: - AUDIO RECORDER
extension NotesViewController: AVAudioRecorderDelegate {
    private func setAudioRecorder() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playAndRecord, mode: .default)
            try session.setActive(true)
            session.requestRecordPermission { [weak self] granted in
                if granted {
                    self?.saveFile()
                } else {
                    print("Доступ к микрофону запрещен.")
                }
            }
        } catch {
            print("Ошибка настройки сессии AVAudioSession: \(error.localizedDescription)")
        }
    }
    
    private func saveFile() {
        let currentDate = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd 'at' HH:mm:ss"
        
        let dateString = dateFormatter.string(from: currentDate)
        
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let audioURL = documentsDirectory.appendingPathComponent("Audio\(dateString).wav")
            self.link = audioURL
            
            let audioSettings: [String: Any] = [
                AVFormatIDKey: kAudioFormatLinearPCM,
                AVSampleRateKey: 44100.0,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            do {
                audioRecorder = try AVAudioRecorder(url: audioURL, settings: audioSettings)
                audioRecorder?.delegate = self
                audioRecorder?.prepareToRecord()
            } catch {
                print("Ошибка создания AVAudioRecorder: \(error.localizedDescription)")
            }
        }
    }
}
