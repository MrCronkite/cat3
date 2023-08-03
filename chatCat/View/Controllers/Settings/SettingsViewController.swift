//
//  SettingsViewController.swift
//  chatCat
//
//  Created by admin1 on 2.08.23.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    @IBOutlet weak var lableText: UILabel!
    @IBOutlet weak var privaceView: UIView!
    @IBOutlet weak var paperView: UIView!
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var tintView: UIView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    @IBAction func goToRoot(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension SettingsViewController {
    private func setupView() {
        view.backgroundColor = .white
        
        lableText.textColor = R.Colors.viewActive
        
        stackView.layer.cornerRadius = 15
        privaceView.backgroundColor = R.Colors.bgSettingd
        paperView.backgroundColor = R.Colors.bgSettingd
        rateView.backgroundColor = R.Colors.bgSettingd
        rateView.layer.cornerRadius = 15
        shareView.layer.cornerRadius = 15
        shareView.backgroundColor = R.Colors.bgSettingd
        tintView.backgroundColor = R.Colors.tintColor
    }
}
 
