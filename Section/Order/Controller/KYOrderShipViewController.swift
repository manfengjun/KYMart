//
//  KYOrderShipViewController.swift
//  KYMart
//
//  Created by JUN on 2017/7/12.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD
class KYOrderShipViewController: BaseViewController {

    var order_id:Int?{
        didSet {
            let url = URL(string: SJBRequestUrl.returnOrderShipUrl(order_id: order_id!))
            let request = URLRequest(url: url!)
            webView.load(request)
        }
    }
    /// 详情展示WebView
    fileprivate lazy var webView : WKWebView = {
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.scrollView.isScrollEnabled = true
        return webView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Do any additional setup after loading the view.
    }
    func setupUI() {
        setBackButtonInNav()
        view.addSubview(webView)
        SVProgressHUD.show()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension KYOrderShipViewController:WKUIDelegate,WKNavigationDelegate{
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("加载中")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("内容开始返回")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("加载完成")
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("加载失败")
    }
    
}
