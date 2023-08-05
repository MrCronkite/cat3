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
        
        // Обновляем слой при изменении размеров страницы
        updateCustomLayer()
    }
    
    private func updateCustomLayer() {
        // Удаляем старый слой
        let dotLayer = CALayer()
               dotLayer.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
               dotLayer.cornerRadius = 5 // Закругляем углы, чтобы получить круглую точку
               dotLayer.backgroundColor = UIColor.black.cgColor
               
               // Устанавливаем позицию точки на центре view
               let centerX = bounds.width / 2 - dotLayer.bounds.width / 2
               let centerY = bounds.height / 2 - dotLayer.bounds.height / 2
               dotLayer.position = CGPoint(x: centerX, y: centerY)
        
        layer.addSublayer(dotLayer)
    }
}




