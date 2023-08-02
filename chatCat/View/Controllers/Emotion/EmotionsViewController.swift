//
//  EmotionsViewController.swift
//  chatCat
//
//  Created by admin1 on 1.08.23.
//

import UIKit

final class EmotionsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var counter = 0
    let columnCount = 7
    let itemCountPerColumn = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
}

extension EmotionsViewController {
    private func setupView() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 108, height: 132)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        
        collectionView.backgroundColor = UIColor.white
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.register(ViewCollectionCell.self, forCellWithReuseIdentifier: "ViewCollectionCell")
        view.addSubview(collectionView)
        
        
        
    }
}

extension EmotionsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return columnCount
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCountPerColumn
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewCollectionCell", for: indexPath) as! ViewCollectionCell
        counter += 1
        cell.addSong(songNum: counter)
        return cell
    }
}