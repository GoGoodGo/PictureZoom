//
//  ImageZoomCell.swift
//  双击放大（手势缩放）
//
//  Created by OYH on 22/12/2017.
//  Copyright © 2017 YH. All rights reserved.
//

import UIKit

class ImageZoomCell: UICollectionViewCell, UIScrollViewDelegate {
    
    let maxScale: CGFloat = 3.0 // 最大缩放倍数
    let minScale: CGFloat = 0.5 // 最小倍数
    let scaleDuration = 0.38 // 缩放动画时间
    var lastScale: CGFloat = 1.0 // 最后一次的缩放比例
    var tapOffset: CGPoint? // 双击放大偏移的 point
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupUI
    func setupUI() {
//        let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(singleTap(tap:)))
//        addGestureRecognizer(singleTap)
        let doubleTap = UITapGestureRecognizer.init(target: self, action: #selector(doubleTap(tap:)))
        doubleTap.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTap)
        
        contentView.addSubview(scrollView)
    }
    
    // MARK: - Customized
    /** 设置缩放比例 */
    fileprivate func setZoom(scale: CGFloat) {
        
        lastScale = max(min(scale, maxScale), minScale)
        imgView.transform = CGAffineTransform.init(scaleX: lastScale, y: lastScale)
        
        let imageW = imgView.frame.size.width
        let imageH = imgView.frame.size.height
        if lastScale > 1 {
            scrollView.contentInset = UIEdgeInsets.zero // 内边距清空
            // 修改中心点
            imgView.center = CGPoint.init(x: imageW / 2, y: imageH / 2)
            scrollView.contentSize = CGSize.init(width: imageW, height: imageH)
            if let offset = tapOffset {
                scrollView.contentOffset = offset
            }
        } else {
            calculateInset()
            scrollView.contentSize = CGSize.zero
        }
    }
    
    /** 计算双击放大偏移量 */
    fileprivate func calculateOffset(tapPoint: CGPoint) {
        
        let viewSize = self.bounds.size
        let imgViewSize = imgView.bounds.size
        // 计算最大偏移 x y
        let maxOffsetX = imgViewSize.width * maxScale - viewSize.width
        let maxOffsetY = imgViewSize.height * maxScale - viewSize.height
        
        var tapX: CGFloat = tapPoint.x
        var tapY: CGFloat = tapPoint.y
        if imgView.frame.minX == 0 {
            // 将 tap superview 的 point 转换到 imageView
            tapY = tapPoint.y - (viewSize.height - imgViewSize.height) / 2
        } else {
            tapX = tapPoint.x - (viewSize.width - imgViewSize.width) / 2
        }
        // 计算偏移量
        let offsetX = (tapX * maxScale - (self.superview?.center.x)!)
        let offsetY = (tapY * maxScale - (self.superview?.center.y)!)
        // 判断偏移量是否超出限制（0, maxOffset）
        let x = min(max(offsetX, 0), maxOffsetX)
        let y = min(max(offsetY, 0), maxOffsetY)
        
        tapOffset = CGPoint.init(x: x, y: y)
    }
    
    /** 计算内边距 */
    fileprivate func calculateInset() {
        
        let imgViewSize = imgView.frame.size
        let scrollViewSize = scrollView.bounds.size
        // 垂直内边距
        let paddingV = imgViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imgViewSize.height) / 2 : 0
        // 水平内边距
        let paddingH = imgViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imgViewSize.width) / 2 : 0
        
        scrollView.contentInset = UIEdgeInsets.init(top: paddingV, left: paddingH, bottom: paddingV, right: 0)
        imgView.center = CGPoint.init(x: imgViewSize.width / 2, y: imgViewSize.height / 2)
    }
    
    // MARK: - Callbacks
    /** 单击复原 */
    @objc func singleTap(tap: UITapGestureRecognizer) {
        UIView.animate(withDuration: scaleDuration) {
            self.setZoom(scale: 1.0)
        }
    }
    
    /** 双击放大 */
    @objc func doubleTap(tap: UITapGestureRecognizer) {
        let point = tap.location(in: self)
        calculateOffset(tapPoint: point)
        
        if lastScale > 1 {
            lastScale = 1
        } else {
            lastScale = maxScale
            let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(singleTap(tap:)))
            addGestureRecognizer(singleTap)
        }
        UIView.animate(withDuration: scaleDuration) {
            self.setZoom(scale: self.lastScale)
        }
    }
    
    // MARK: - UIScrollViewDelegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imgView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        // 捏合动画完成计算内边距
        calculateInset()
    }
    
    // MARK: - Setter
    var image: UIImage? {
        didSet {
            // 以最短的边等比例缩小图片
            let imgSize = (image?.size)!
            let scrollViewSize = scrollView.bounds.size
            let widthScale = scrollViewSize.width / imgSize.width
            let heightScale = scrollViewSize.height / imgSize.height
            let minScale = min(widthScale, heightScale)
            scrollView.minimumZoomScale = 1
            imgView.bounds = CGRect.init(x: 0, y: 0, width: imgSize.width * minScale, height: imgSize.height * minScale)
            imgView.image = image
        }
    }
    
    // MARK: - Getter
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView.init(frame: self.bounds)
        view.delegate = self
        view.maximumZoomScale = maxScale
        view.contentSize = self.bounds.size
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.addSubview(self.imgView)
        return view
    }()
    
    lazy var imgView: UIImageView = {
        let view = UIImageView.init(frame: self.bounds)
        return view
    }()
    
    
    
    
    
    
    
    
    

}
