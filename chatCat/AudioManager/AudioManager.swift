//
//  AudioManager.swift
//  chatCat
//
//  Created by admin1 on 4.08.23.
//

import AVFoundation
import UIKit

protocol AudioManager {
    
}

final class AudioManagerImpl {
    
    var audioPlayer = AVAudioPlayer()
    var audioSession = AVAudioSession()
    private var audioRecorder: AVAudioRecorder?
    
    func setupAudioSession(_ state: Bool) {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default)
            try audioSession.setActive(state)
            print("Аудио сессия переведена в активное состояние.")
        } catch {
            print("Ошибка при настройке аудиосессии: \(error.localizedDescription)")
        }
    }
    
    func setupAudioPlayer(link: URL) -> AVAudioPlayer {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: link)
            audioPlayer.prepareToPlay()
        } catch {
            print("Ошибка воспроизведения аудио: \(error.localizedDescription)")
        }
        return audioPlayer
    }
    
    func setupPlayer(link: URL) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: link)
            audioPlayer.prepareToPlay()
        } catch {
            print("Ошибка воспроизведения аудио: \(error.localizedDescription)")
        }
    }
    
    func deactivateAudioSession() {
            do {
                try audioSession.setCategory(.record, mode: .default)
                print("Аудио сессия переведена в неактивное состояние.")
            } catch {
                print("Ошибка при переводе аудио сессии в неактивное состояние: \(error.localizedDescription)")
            }
        }
    
    func play() {
        audioPlayer.play()
    }
}


