//
//  VoiceVIewController.swift
//  chatCat
//
//  Created by admin1 on 2.08.23.
//

import UIKit

final class VoiceViewController: UIViewController {
    
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
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func playVoice(_ sender: Any) {
        
    }
    
    @IBAction func saveVoice(_ sender: Any) {
        
    }
    
    @IBAction func reRecordVoice(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
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
    }
}
