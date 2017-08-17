//
//  KYRechargeViewController.swift
//  KYMart
//
//  Created by JUN on 2017/8/17.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import WebKit
import PopupDialog
class KYRechargeViewController: BaseViewController {

    @IBOutlet weak var userMoneyLabel: UILabel!
    @IBOutlet weak var userMoneyBtn: UIButton!
    fileprivate lazy var webView : WKWebView = {
        let webView = WKWebView(frame: CGRect(x: 0, y: 120 + 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.scrollView.isScrollEnabled = true
        if let text = SingleManager.instance.loginInfo?.token{
            let url = URL(string: "http://www.kymart.cn/index.php/api/user/recharge_list.html?token=\(text)")!
            webView.load(URLRequest(url: url))
        }
        return webView
    }()
    var userMoney:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    func setupUI() {
        setBackButtonInNav()
        view.addSubview(webView)
        navigationItem.title = "充值"
        userMoneyBtn.layer.masksToBounds = true
        userMoneyBtn.layer.cornerRadius = 5.0
        userMoneyLabel.text = "¥\(userMoney!)"
    }
    @IBAction func rechargeAtion(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let rechargeVC = storyboard.instantiateViewController(withIdentifier: "alertRechargeVC")
        // Create the dialog
        let rechargeVC = AlertRechargeViewController(nibName: "AlertRechargeViewController", bundle: nil)

        let popup = PopupDialog(viewController: rechargeVC, buttonAlignment: .horizontal, transitionStyle: .bounceUp, gestureDismissal: true)
        
        
        // Create first button
        let buttonOne = CancelButton(title: "取消", height: 50) {
            print("取消")
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "确定", height: 50) {
            print("确定")
        }
        buttonTwo.titleColor = BAR_TINTCOLOR
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        present(popup, animated: true, completion: nil)

    }
    func showAlert() {
        // Create a custom view controller
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension KYRechargeViewController:WKUIDelegate,WKNavigationDelegate{
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("加载中")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("内容开始返回")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("加载完成")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("加载失败")
    }
    
}
