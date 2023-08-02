//
//  WhistleViewController.swift
//  chatCat
//
//  Created by admin1 on 1.08.23.
//

import UIKit

final class WhistleViewController: UIViewController {
    
    @IBOutlet weak var howToUseButton: UIButton!
    
    @IBOutlet weak var noiseTitle: UILabel!
    @IBOutlet weak var sliderNoise: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
    }
    @IBAction func showDirection(_ sender: Any) {
        let vc = DirectionViewController()
        present(vc, animated: true)
    }
    
    @IBAction func updateSlider(_ sender: Any) {
        updateLabelValue(value: sliderNoise.value)
    }
    
    @IBAction func goWhistle(_ sender: Any) {
        
    }
}

extension WhistleViewController {
    private func setupView() {
        //howToUseButton.setTitleColor(R.Colors.viewActive, for: .normal)
        howToUseButton.tintColor = R.Colors.viewActive
        noiseTitle.textColor = R.Colors.viewActive
        sliderNoise.minimumTrackTintColor = R.Colors.viewActive
    }
    
    func updateLabelValue(value: Float) {
           let formattedValue = String(format: "%.f", value)
        
           noiseTitle.text = "\(formattedValue) HZ"
       }
}
