//
//  TopShowView.swift
//  ProDataTest
//
//  Created by 王晶 on 15/9/25.
//  Copyright © 2015年 IceSnow. All rights reserved.
//

import UIKit

class TopShowView: UIView {
    
    // public
    var estimatedProgress: Double = 0 {
        didSet {
            updateProgressView()
        }
    }
    
    var urlString: String = "" {
        didSet {
            urlLable.text = urlString
            urlLable.hidden = urlString.isEmpty
        }
    }
    
    // private
    private var progressView: UIView
    private var urlLable: UILabel
    
    
    override init(frame: CGRect) {
        
        // progressView
        var proFrame = frame
        proFrame.origin = CGPointZero
        proFrame.size.width = 0
        progressView = UIView(frame: proFrame)
        
        // URLString
        var urlFrame = frame
        urlFrame.origin.y = 0
        urlFrame.origin.x = 8
        urlFrame.size.width -= 16
        urlLable = UILabel(frame: urlFrame)
        urlLable.textAlignment = .Center
        
        super.init(frame: frame)
        
        backgroundColor = UIColor(white: 0.9, alpha: 0.3)
        
        // progressView
        progressView.alpha = progressViewAlpha
        let image = UIImage(named: "allColorLine")
        progressView.layer.contents = image?.CGImage
        addSubview(progressView)
        
        // urlLable
        urlLable.hidden = true
        addSubview(urlLable)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private let progressViewAlpha : CGFloat = 0.3

private extension TopShowView {
    func updateProgressView() {
        let ep = estimatedProgress
        let isEnd = ep == 1
        let isStart = ep == 0
        
        var proFrame = progressView.frame
        proFrame.size.width = bounds.width * CGFloat(ep)
        
        UIView.animateWithDuration(0.8, animations: { () -> Void in
            self.progressView.frame = proFrame
            }) { (finshed: Bool) -> Void in
                // 处理开始加载进度
                if isStart {
                    self.progressView.alpha = progressViewAlpha
                }
                
                // 处理加载结束
                if isEnd {
                    self.progressView.alpha = 0
                    self.estimatedProgress = 0
                }
        }
    }
}

