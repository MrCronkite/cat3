//
//  PageControl.swift
//  chatCat
//
//  Created by admin1 on 3.08.23.
//

import UIKit

class CustomPageControl: UIPageControl {

    private var activeDotSize: CGSize = CGSize(width: 16, height: 16)
    private var inactiveDotSize: CGSize = CGSize(width: 8, height: 8)
    private var spacing: CGFloat = 12

    override var numberOfPages: Int {
        didSet {
            numberOfPages = 3
        }
    }

    override var currentPage: Int {
        didSet {
            currentPage = 0
        }
    }

    override func draw(_ rect: CGRect) {
        guard numberOfPages > 0 else { return }

        let totalWidth = CGFloat(numberOfPages - 1) * spacing + CGFloat(numberOfPages) * activeDotSize.width
        var x = (bounds.width - totalWidth) / 2

        let y = (bounds.height - activeDotSize.height) / 2

        let dotRadius = activeDotSize.width / 2
        let dotRect = CGRect(x: x, y: y, width: activeDotSize.width, height: activeDotSize.height)

        for i in 0..<numberOfPages {
            let dotColor: UIColor = (i == currentPage) ? UIColor.red : UIColor.lightGray

            let dotPath = UIBezierPath(roundedRect: dotRect, cornerRadius: dotRadius)
            dotColor.setFill()
            dotPath.fill()

            x += activeDotSize.width + spacing
        }
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let width = CGFloat(numberOfPages) * activeDotSize.width + CGFloat(numberOfPages - 1) * spacing
        let height = max(activeDotSize.height, inactiveDotSize.height)

        return CGSize(width: width, height: height)
    }
}



