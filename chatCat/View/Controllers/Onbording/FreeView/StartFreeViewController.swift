//
//  StartFreeViewController.swift
//  chatCat
//
//  Created by admin1 on 3.08.23.
//

import UIKit

final class StartFreeViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var buttonGetFree: UIButton!
    @IBOutlet weak var termUsLabel: UILabel!
    @IBOutlet weak var restoreLabel: UILabel!
    @IBOutlet weak var privacyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var textPRO: UILabel!
    @IBOutlet weak var firstDaysText: UILabel!
    @IBOutlet weak var subtitle2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitleLabel()
        setupView()
    }
    
    @IBAction func getFreeTrial(_ sender: Any) {
        let vc = TabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

extension StartFreeViewController {
    private func setupView() {
        view.backgroundColor = .white
        imageView.backgroundColor = R.Colors.bgColor
        
        buttonGetFree.layer.cornerRadius = 30
        buttonGetFree.backgroundColor = R.Colors.btnActive
        
        termUsLabel.textColor = R.Colors.subtitle
        restoreLabel.textColor = R.Colors.subtitle
        privacyLabel.textColor = R.Colors.subtitle
    }
    
    private func setupTitleLabel() {
        let text = "Enjoy all features"
        let attributeText = NSMutableAttributedString(string: text)
        
        attributeText.addAttribute(.foregroundColor, value: R.Colors.viewActive, range: NSRange(location: 0, length: 5))
        
        titleLabel.attributedText = attributeText
        
        textPRO.backgroundColor = R.Colors.viewActive
        textPRO.layer.cornerRadius = 8
        textPRO.layer.masksToBounds = true
        
        let firstText = "First 3 days free,"
        let attributeFirstText = NSMutableAttributedString(string: firstText)
        
        attributeFirstText.addAttribute(.foregroundColor, value: R.Colors.viewActive, range: NSRange(location: 0, length: 17))
        
        firstDaysText.attributedText = attributeFirstText
        
        let secondText = "then 5.99$ per week. cacel at anytime."
        let attributeSecondText = NSMutableAttributedString(string: secondText)
        
        attributeSecondText.addAttribute(.foregroundColor, value: R.Colors.viewActive, range: NSRange(location: 5, length: 16))
        
        subtitle2.attributedText = attributeSecondText
    }
    
}

