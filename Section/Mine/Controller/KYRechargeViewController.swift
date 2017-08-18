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
import SVProgressHUD
class KYRechargeViewController: BaseViewController {

    @IBOutlet weak var userMoneyLabel: UILabel!
    @IBOutlet weak var userMoneyBtn: UIButton!
    var currentSelect:Int = 1
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
        NotificationCenter.default.addObserver(self, selector:#selector(weixinPayAction),name: WeiXinPayNotification, object: nil)

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
    
    /// 弹窗
    ///
    /// - Parameter sender: sender description
    @IBAction func rechargeAtion(_ sender: UIButton) {
        let rechargeVC = AlertRechargeViewController(nibName: "AlertRechargeViewController", bundle: nil)
        let popup = PopupDialog(viewController: rechargeVC, buttonAlignment: .horizontal, transitionStyle: .bounceUp, gestureDismissal: true)
        let buttonOne = CancelButton(title: "取消", height: 50) {
            print("取消")
        }
        let buttonTwo = DefaultButton(title: "确定", height: 50) {
            self.currentSelect = rechargeVC.currentSelect
            SVProgressHUD.show(withStatus: "加载中")
            //快钱支付
            let params = ["amount":rechargeVC.moneyT.text,"user_id":SingleManager.instance.loginInfo?.user_id]
            
            SJBRequestModel.push_fetchRechargeData(type: 3, params: params as [String : AnyObject], completion: { (response, status) in
                SVProgressHUD.dismiss()
                if self.currentSelect == 1 {
                    // 微信支付
                    self.weixinPay(response: response, status: status)
                    
                }
                else if self.currentSelect == 2
                {
                    //支付宝支付
                    self.alipayPay(response: response, status: status)
                }
                else
                {
                    //快钱支付
                    self.kuaiQianPay(response: response, status: status)
                }

            })
        }
        buttonTwo.titleColor = BAR_TINTCOLOR
        popup.addButtons([buttonOne, buttonTwo])
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
extension KYRechargeViewController{
    func weixinPay(response:AnyObject,status:Int) {
        if status == 1{
            let model = response as? KYWXPayModel
            if let timeStr = model?.timestamp{
                let request = PayReq()
                request.partnerId = model?.partnerid
                request.prepayId = model?.prepayid
                request.package = model?.package
                request.nonceStr = model?.noncestr
                request.timeStamp = UInt32(timeStr)!
                request.sign = model?.sign
                WXApi.send(request)
            }
            
        }
        else
        {
            self.Toast(content: "支付失败！", duration: 2)
        }
    }
    func weixinPayAction() {
        self.navigationController?.popViewController(animated: true)
    }
    func alipayPay(response:AnyObject,status:Int) {
        if status == 1 {
            let orderString = response as! String
            let appScheme = "com.kymart.shop"
            AlipaySDK.defaultService().payOrder(orderString, fromScheme: appScheme, callback: { (result) in
                let resultDic = result! as Dictionary
                if let resultStatus = resultDic["resultStatus"] as? String{
                    if resultStatus == "9000"{
                        self.navigationController?.popViewController(animated: true)
                    }
                    else
                    {
                        self.Toast(content: "支付失败，请重新支付！")
                        
                    }
                }
            })
        }
        else
        {
            self.Toast(content: "支付失败！", duration: 2)
            
        }
        
    }
    func kuaiQianPay(response:AnyObject,status:Int) {
        if status == 1{
            self.popupDialog(content: "是否支付成功？", cancelTitle: "支付失败", sureTitle: "支付完成", sure: {
                self.navigationController?.popViewController(animated: true)
            }, cancel: {
                
            })
            let url = response["url"] as! String;
            UIApplication.shared.openURL(URL(string: url)!)
        }
        else
        {
            self.Toast(content: "支付失败！", duration: 2)
            
        }
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
