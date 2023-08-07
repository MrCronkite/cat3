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
        
        let tapPrivaceView = UITapGestureRecognizer(target: self, action: #selector(handlerTap(_:)))
        privaceView.addGestureRecognizer(tapPrivaceView)
        privaceView.isUserInteractionEnabled = true
        
        let tapPaperView = UITapGestureRecognizer(target: self, action: #selector(handlerPaperTap(_:)))
        paperView.addGestureRecognizer(tapPaperView)
        paperView.isUserInteractionEnabled = true
        
        let tapRateView = UITapGestureRecognizer(target: self, action: #selector(handlerReview(_:)))
        rateView.addGestureRecognizer(tapRateView)
        rateView.isUserInteractionEnabled = true
        
        let tapShareView = UITapGestureRecognizer(target: self, action: #selector(handlerShare(_:)))
        shareView.addGestureRecognizer(tapShareView)
        shareView.isUserInteractionEnabled = true
    }
    
    private func animateButtonPressed(view: UIView) {
        UIView.animate(withDuration: 0.1, animations: {
            view.alpha = 0.7
            view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { (completed) in
            UIView.animate(withDuration: 0.1, animations: {
                view.alpha = 1.0
                view.transform = CGAffineTransform.identity
            })
        }
    }
    
    @objc func handlerTap(_ gesture: UITapGestureRecognizer) {
        animateButtonPressed(view: privaceView)
        if let url = URL(string: "https://github.com/MrCronkite/toDoTasks/blob/main/todoApp/Model/Element.swift") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @objc func handlerPaperTap(_ gesture: UITapGestureRecognizer) {
        animateButtonPressed(view: paperView)
        if let url = URL(string: "https://github.com/MrCronkite/toDoTasks/blob/main/todoApp/Model/Element.swift") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @objc func handlerReview(_ gesture: UITapGestureRecognizer) {
        animateButtonPressed(view: rateView)
        if let url = URL(string: "itms-apps://itunes.apple.com/app/idYOUR_APP_ID?action=write-review") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    @objc func handlerShare(_ gesture: UITapGestureRecognizer) {
        animateButtonPressed(view: shareView)
        let textToShare = "Привет! Я использую это замечательное приложение!"
        let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
}

