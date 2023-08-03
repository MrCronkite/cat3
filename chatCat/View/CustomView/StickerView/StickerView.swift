//
//  StickerView.swift
//  chatCat
//
//  Created by admin1 on 3.08.23.
//

import UIKit

@IBDesignable
final class StickerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView(image: UIImage) {
    }
}

extension StickerView {
    func setupView () {
        guard let view = self.loadViewFromNib(nibName: "StickerView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
}


