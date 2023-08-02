//
//  ChatViewController.swift
//  chatCat
//
//  Created by admin1 on 1.08.23.
//

import UIKit

final class ChatViewController: UIViewController {
    
    @IBOutlet weak var catView: UIView!
    @IBOutlet weak var meView: UIView!
  
    @IBOutlet weak var meImage: UIImageView!
    @IBOutlet weak var catImage: UIImageView!
    
    @IBOutlet weak var navBarView: NavBarView!
    
    @IBOutlet weak var lableMe: UILabel!
    
    @IBOutlet weak var lableCat: UILabel!
    
    @IBOutlet weak var textTranslate: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupView()
    }
}

extension ChatViewController {
    private func setupView() {
        navigationController?.navigationBar.isHidden = true
        
        catView.backgroundColor = R.Colors.viewInactive
        meView.backgroundColor = R.Colors.viewActive
        meView.layer.cornerRadius = 19
        catView.layer.cornerRadius = 19
        
        meImage.image = R.Images.Chat.meImg
        meImage.backgroundColor = R.Colors.bgImg
        meImage.layer.cornerRadius = 16
        meImage.layer.borderWidth = 1.5
        meImage.layer.borderColor = UIColor.white.cgColor
        
        catImage.backgroundColor = R.Colors.bgImg
        catImage.image = R.Images.Chat.catImg
        catImage.layer.cornerRadius = 16
        catImage.layer.borderWidth = 1.5
        catImage.layer.borderColor = UIColor.white.cgColor
        
        textTranslate.layer.borderColor = UIColor.white.cgColor
        textTranslate.textColor = R.Colors.viewActive
        textTranslate.borderStyle = .none
        
        navBarView.configureLabel(title: "")
    }
}
