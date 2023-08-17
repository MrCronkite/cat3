//
//  NavBarView.swift
//  chatCat
//
//  Created by admin1 on 2.08.23.
//

import UIKit

protocol NavBarViewDelegate: AnyObject {
    func showVC()
    func showFree()
}

@IBDesignable
final class NavBarView: UIView {
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var viewPro: UIImageView!
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(addHandler(_:)))
        viewPro.addGestureRecognizer(tap)
        viewPro.isUserInteractionEnabled = true
    }
    
    func configureLabel(title: String) {
        titleText.text = title
        titleText.textColor = R.Colors.viewActive
    }
    
    @objc func addHandler(_ sender: UITapGestureRecognizer) {
        delegate?.showFree()
    }
}
