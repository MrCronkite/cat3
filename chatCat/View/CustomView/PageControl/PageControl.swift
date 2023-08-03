//
//  PageControl.swift
//  chatCat
//
//  Created by admin1 on 3.08.23.
//

import UIKit

class CustomPageControl: UIPageControl {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateDotsAppearance()
    }
    
    private func updateDotsAppearance() {
        let spacing: CGFloat = 8.0 // Расстояние между точками
        let diameter: CGFloat = 10.0 // Размер обычной точки
        let activeDiameter: CGFloat = 20.0 // Размер активной точки
        
        for (index, subview) in subviews.enumerated() {
            let size = (index == currentPage) ? CGSize(width: activeDiameter, height: diameter) : CGSize(width: diameter, height: diameter)
            subview.frame.size = size
            subview.layer.cornerRadius = size.height / 2
            
            if index == currentPage {
                let xOffset = (diameter + spacing) * CGFloat(index) + (diameter - activeDiameter) / 2
                subview.frame.origin.x = xOffset
            }
        }
    }
}


