//
//  ImageZoomView.swift
//  双击放大（手势缩放）
//
//  Created by OYH on 22/12/2017.
//  Copyright © 2017 YH. All rights reserved.
//

import UIKit

class ImageZoomView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {

    var width: CGFloat = 0.1
    var height: CGFloat = 0.1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        width = frame.size.width
        height = frame.size.height
        collectionView.frame = self.bounds
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    // MARK: - SetupUI
    func setupUI() {
        addSubview(collectionView)
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageZoomCell.self), for: indexPath) as! ImageZoomCell
        cell.image = imgs[indexPath.row]
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    // MARK: - Setter
    var imgs = [UIImage]() {
        didSet {
            collectionView.reloadData()
        }
    }
    var layout: UICollectionViewFlowLayout {
        get {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize.init(width: width, height: height)
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.scrollDirection = .horizontal
            return layout
        }
        set {
            self.collectionView.setCollectionViewLayout(newValue, animated: true)
        }
    }
    // MARK: - Getter
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView.init(frame: self.bounds, collectionViewLayout: self.layout)
        view.register(ImageZoomCell.self, forCellWithReuseIdentifier: String(describing: ImageZoomCell.self))
        view.backgroundColor = UIColor.white
        view.isPagingEnabled = true
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
