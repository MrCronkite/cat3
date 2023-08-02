//
//  OnbordingBaseController.swift
//  chatCat
//
//  Created by admin1 on 2.08.23.
//

import UIKit

final class OnbordingBaseController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var lableText: UILabel?
    
    
    init(image: UIImage? = nil, text: String? = nil){
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .gray
        self.imageView?.image = image
        self.lableText?.text = text
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView(test: String) {
        imageView?.image = UIImage(named: test)
    }
}


