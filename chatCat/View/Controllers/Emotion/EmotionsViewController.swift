//
//  EmotionsViewController.swift
//  chatCat
//
//  Created by admin1 on 1.08.23.
//

import UIKit

final class EmotionsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var navBar: NavBarView!
    
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
        navBar.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 108, height: 130)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        collectionView.showsVerticalScrollIndicator = false
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
       cell.setupCell(index: counter)
       return cell
    }
}

extension EmotionsViewController: NavBarViewDelegate {
    func showVC() {
        let vc = SettingsViewController()
        show(vc, sender: nil)
    }
}
