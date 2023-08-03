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
        
        let subtitleText = "Upgrade to PRO to get all the benefits"
        let subtextAttribute = NSMutableAttributedString(string: subtitleText)
        
        subtextAttribute.addAttribute(.font, value: UIFont.systemFont(ofSize: 18), range: NSRange(location: 2, length: 3))
        
        subtitle.attributedText = subtextAttribute
    }
    
}

