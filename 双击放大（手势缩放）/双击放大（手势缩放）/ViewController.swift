//
//  ViewController.swift
//  双击放大（手势缩放）
//
//  Created by OYH on 22/12/2017.
//  Copyright © 2017 YH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imgZoomView: ImageZoomView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.cyan
        setupUI()
    }
    
    // MARK: - SetupUI
    func setupUI() {
        
        /** 代码 */
//        let imgZoom = ImageZoomView.init(frame: CGRect.init(x: 0, y: 100, width: view.bounds.size.width, height: 500))
//        imgZoom.imgs = [#imageLiteral(resourceName: "welcome.png"), #imageLiteral(resourceName: "probe_direct_list.png")]
//
//        view.addSubview(imgZoom)

        /** xib */
        imgZoomView.imgs = [#imageLiteral(resourceName: "welcome.png"), #imageLiteral(resourceName: "probe_direct_list.png"), #imageLiteral(resourceName: "kk.PNG")]
    }
    
    
    
    
    
    
    


}

