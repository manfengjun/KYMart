//
//  KYProductContentViewController.swift
//  KYMart
//
//  Created by Jun on 2017/6/10.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import WebKit
class KYProductContentViewController: UIViewController {
    /// 商品ID
    var id:Int?{
        didSet {
            let urlStr = SJBRequestUrl.returnProductContentUrl(id: id!)
            let url = URL(string: urlStr)
            print(url ?? "")
            
            webView.load(URLRequest(url: url!))
        }
    }
    /// 详情展示WebView
    fileprivate lazy var webView : WKWebView = {
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64 - 50))
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.scrollView.isScrollEnabled = true
        return webView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        // Do any additional setup after loading the view.
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
// MARK: ------ WKUIDelegate
extension KYProductContentViewController:WKUIDelegate,WKNavigationDelegate{
//    func autolayoutWebView() {
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
//            //code
//            self.webView.evaluateJavaScript("document.body.offsetHeight") { (result, nil) in
//                if let height = result {
//                    self.webView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: CGFloat((height as! NSNumber).floatValue) + 20)
//                    self.tableView.tableHeaderView = self.webView
//                }
//                
//            }
//        }
//    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("加载中")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("内容开始返回")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("加载完成")
//        autolayoutWebView()
//        if let allphoto = model?.images {
//            getImageFromDownloaderOrDiskByImageUrlArray(allphoto)
//        }
//        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("加载失败")
    }
    
    func filterHTML(_ string: String) -> String {
        return (string as NSString).replacingOccurrences(of: "<p>&nbsp;</p>", with: "")
    }
    
}
