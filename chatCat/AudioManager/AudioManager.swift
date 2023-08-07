//
//  AudioManager.swift
//  chatCat
//
//  Created by admin1 on 4.08.23.
//

import AVFoundation
import UIKit

final class AudioManagerImpl {
    var audioPlayer = AVAudioPlayer()
    var audioSession = AVAudioSession()
    private var audioRecorder: AVAudioRecorder?
    
    func setupAudioSession(_ state: Bool) {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default)
            try audioSession.setActive(state)
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
        print(link)
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
            } catch {
                print("Ошибка при переводе аудио сессии в неактивное состояние: \(error.localizedDescription)")
            }
        }
    
    func play() {
        audioPlayer.play()
    }
}


