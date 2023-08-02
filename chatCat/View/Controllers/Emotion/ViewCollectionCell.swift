//
//  ViewCollectionCell.swift
//  chatCat
//
//  Created by admin1 on 2.08.23.
//

import UIKit

final class ViewCollectionCell: UICollectionViewCell {
    
    let viewContent: EmotionView
    let titles: [String] = ["","Happy", "Neutral", "Clever", "Crying", "Cute", "Love", "Angry", "Evil", "Cool", "Festive", "Whiskered", "Evil", "Frightened", "Sad", "Winking", "Star", "Sick", "Surprised", "Hypnosis", "Tongue", "Exquisite"]
    
    override init(frame: CGRect) {
        viewContent = EmotionView(frame: CGRect(x: 0, y: 0, width: 108, height: 117))
        viewContent.contentMode = .scaleAspectFit
        super.init(frame: frame)
        contentView.addSubview(viewContent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(index: Int) {
        if index <= 21 {
            viewContent.lableText.text = titles[index]
            viewContent.imageCatView.image = UIImage(named: String(index))
            viewContent.setupAV(valueSong: index)
        }
    }
}
