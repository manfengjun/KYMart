
//
//  KYNewsDetailViewController.swift
//  KYMart
//
//  Created by jun on 2017/9/5.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD
class KYNewsDetailViewController: BaseViewController {
    var type:String?
    var id:Int?{
        didSet{
            dataRequest()
        }
    }
    /// 详情展示WebView
    fileprivate lazy var webView : WKWebView = {
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64))
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.scrollView.isScrollEnabled = true
        return webView
    }()
    /// 是否是推送
    var isPush:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
    }
    /// 请求数据
    func dataRequest() {
        SVProgressHUD.show(withStatus: "加载中")
        SJBRequestModel.pull_fetchSystemNoticeDetailData(type: type!, id: id!) { (response, status) in
            SVProgressHUD.dismiss()
            if status == 1 {
                let model = response as! KYNewsListModel
                let time = String(model.create_time).timeStampToString()
                let html:NSMutableString = "<html><head><meta charset=\"UTF-8\"></head><body><div style=\"text-align: center;color: #333333;font-size: 17px;\"><h3>\(model.title!)</h3></div><div style=\"color: #999999;font-size: 12px;\">\(time)</div><div style=\"color: #666666;font-size: 15px;\">\(model.content!)</div></body></html>" as! NSMutableString
                
                for i in 0..<html.length{
                    let character = html.substring(with: NSMakeRange(i, 1))
                    if character == "\\"
                    {
                        html.deleteCharacters(in: NSMakeRange(i, 1))
                    }
                }
                self.webView.loadHTMLString(html as String, baseURL: nil)
                self.navigationItem.title = model.title
            }
        }
        
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
extension KYNewsDetailViewController:WKUIDelegate,WKNavigationDelegate{
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
