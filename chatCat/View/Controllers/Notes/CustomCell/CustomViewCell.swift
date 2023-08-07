//
//  CustomViewCell.swift
//  chatCat
//
//  Created by admin1 on 3.08.23.
//

import UIKit

final class CustomViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
}

extension CustomViewCell {
    private func setupView() {
        guard let view = self.loadViewFromNib(nibName: "CustomViewCell") else { return }
        view.frame = self.bounds
        self.addSubview(view)
        self.backgroundColor = .white
        
        title.textColor = R.Colors.blackColor
        data.textColor = R.Colors.blackColor
        title.textColor = R.Colors.blackColor
        
        bgView.layer.cornerRadius = 20
        bgView.backgroundColor = R.Colors.bgSettingd
        
        let tapShareView = UITapGestureRecognizer(target: self, action: #selector(animate(_:)))
        bgView.addGestureRecognizer(tapShareView)
        bgView.isUserInteractionEnabled = true
    }
    
    @objc func animate(_ gesture: UITapGestureRecognizer) {
        print("hi")
    }
}

