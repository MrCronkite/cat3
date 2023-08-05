//
//  NavBarView.swift
//  chatCat
//
//  Created by admin1 on 2.08.23.
//

import UIKit

protocol NavBarViewDelegate: AnyObject {
    func showVC()
}

@IBDesignable
final class NavBarView: UIView {
    
    @IBOutlet weak var titleText: UILabel!
    
    weak var delegate: NavBarViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        configureLabel(title: "Emotions")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
        configureLabel(title: "Emotions")
    }
    
    @IBAction func showDirection(_ sender: Any) {
        delegate?.showVC()
    }
}

extension NavBarView {
    private func setupView() {
        guard let view = self.loadViewFromNib(nibName: "NavBarView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
        self.backgroundColor = .white
    }
    
    func configureLabel(title: String) {
        titleText.text = title
        titleText.textColor = R.Colors.viewActive
    }
}
