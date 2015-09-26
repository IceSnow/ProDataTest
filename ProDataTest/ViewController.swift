//
//  ViewController.swift
//  ProDataTest
//
//  Created by 王晶 on 15/9/25.
//  Copyright © 2015年 IceSnow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Private
    private var rosWebView: RosWebView!
    private var topShowView: TopShowView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        settingRosWebView()// 配置网页视图
        settingTipShowView()// 配置顶部显示视图
        
        loadWebView("https://m.baidu.com")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
//MARK: 基本功能
private extension ViewController {
    /// 加载URL字符串
    func loadWebView(urlString: String) {
        topShowView.urlString = urlString
        rosWebView.loadWebView(urlString)
    }
}


//MARK: RosWebView
private extension ViewController {
    /// 配置网页视图
    func settingRosWebView() {
        let bottomOff: CGFloat = 21
        var frame = view.frame
        frame.origin.y = bottomOff
        frame.size.height -= bottomOff
        rosWebView = RosWebView(locFrame: frame)
        rosWebView.rosWebViewDelegate = self
        view.addSubview(rosWebView)
    }
}

extension ViewController: ROSWebViewDelegate {
    /// 加载进度监控
    func rosWebViewEstimatedProgress(progress: Double) {
        topShowView.estimatedProgress = progress
    }
}

//MARK: TipShowView
private extension ViewController {
    /// 配置顶部显示视图
    func settingTipShowView() {
        let topFrame = CGRect(x: 0, y: 21, width: view.bounds.width, height: 36)
        topShowView = TopShowView(frame: topFrame)
        view.addSubview(topShowView)
    }
}


