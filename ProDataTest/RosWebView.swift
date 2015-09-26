//
//  RosWebView.swift
//  ProDataTest
//
//  Created by 王晶 on 15/9/25.
//  Copyright © 2015年 IceSnow. All rights reserved.
//

import UIKit
import WebKit

protocol ROSWebViewDelegate: NSObjectProtocol {
    func rosWebViewEstimatedProgress(progress: Double)
}

class RosWebView: WKWebView {
    
    weak var rosWebViewDelegate: ROSWebViewDelegate?
    
    init(locFrame: CGRect) {
        let config = WKWebViewConfiguration()
        super.init(frame: locFrame, configuration: config)
        
        settingWebView()// 配置网页浏览器默认值
        addObservers()// KVO监控
    }
    
    /// KVO监控
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == nil { return }
        switch keyPath! {
        case KVOKeyEP:
            rosWebViewDelegate?.rosWebViewEstimatedProgress(estimatedProgress)
        default:
            break
        }
    }
    
    deinit {
        removeObserver(self, forKeyPath: KVOKeyEP)
    }
    
}
//MARK: Public
extension RosWebView {
    /// 加载网页
    func loadWebView(urlString: String) {
        if let url = NSURL(string: urlString) {
            loadRequest(NSURLRequest(URL: url))
        } else {
            print("非正常URL字符串")
        }
    }
}

private let KVOKeyEP = "estimatedProgress"

private extension RosWebView {
    func settingWebView() {
        navigationDelegate = self
        allowsBackForwardNavigationGestures = true
    }
    
    /// KVO添加
    func addObservers() {
        addObserver(self, forKeyPath: KVOKeyEP, options: .New, context: nil)
    }
    
    
}

//MARK: WKNavigationDelegate
extension RosWebView: WKNavigationDelegate {
    /// 页面开始加载
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    }
    
    /// 当内容开始返回
    func webView(webView: WKWebView, didCommitNavigation navigation: WKNavigation!) {
        
    }
    
    ///  页面加载完成后调用
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        
    }
    
    /// 页面加载失败时调用
    func webView(webView: WKWebView, didFailNavigation navigation: WKNavigation!, withError error: NSError) {
        
    }
}

