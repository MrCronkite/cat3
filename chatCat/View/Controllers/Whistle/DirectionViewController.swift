//
//  DirectionViewController.swift
//  chatCat
//
//  Created by admin1 on 1.08.23.
//

import UIKit

final class DirectionViewController: UIViewController {
    
    @IBOutlet weak var titleLable: UILabel!
    
    @IBOutlet weak var directionLable: UILabel!
    @IBOutlet weak var directionLable1: UILabel!
    @IBOutlet weak var directionLable2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension DirectionViewController {
    private func setupView() {
        navigationController?.navigationBar.isHidden = true
        titleLable.textColor = R.Colors.viewActive
        
        directionLable.text = R.Strings.Whistle.textDirection
        directionLable1.text = R.Strings.Whistle.textDirection1
        directionLable2.text = R.Strings.Whistle.textDirection2
    }
}
