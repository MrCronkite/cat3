//
//  OnbordingBaseController.swift
//  chatCat
//
//  Created by admin1 on 2.08.23.
//

import UIKit

final class OnbordingBaseController: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lableText: UILabel!
    @IBOutlet weak var subtitleText: UILabel!
    
    init(image: UIImage? = nil, text: String? = nil, subtitle: String? = nil){
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        bgView.backgroundColor = R.Colors.bgColor
        
        self.imageView?.image = image
        self.lableText?.text = text
        self.subtitleText.text = subtitle
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView(test: String) {
        imageView?.image = UIImage(named: test)
    }
}


