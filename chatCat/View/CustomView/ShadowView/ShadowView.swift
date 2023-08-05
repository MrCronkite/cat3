//
//  ShadowView.swift
//  chatCat
//
//  Created by admin1 on 2.08.23.
//

import UIKit

@IBDesignable
final class ShadowView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
}

extension ShadowView {
    private func setupView() {
        self.backgroundColor = .white
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: -5)
        self.layer.shadowRadius = 4
    }
}
