//
//  KYOrderPayViewController.swift
//  KYMart
//
//  Created by JUN on 2017/7/9.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYOrderPayViewController: UIViewController {

    var orderID:String?{
        didSet {
            
        }
    }
    var orderMoney:String?{
        didSet {
            
        }
    }
    var model:KYWXPayModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector:#selector(weixinPayAction),name: SelectProductProperty, object: nil)

        // Do any additional setup after loading the view.
    }
    func weixinPayAction() {
        self.navigationController?.popToRootViewController(animated: true)
        self.tabBarController?.selectedIndex = 3

    }
    
    @IBAction func payAction(_ sender: UIButton) {
//        self.weixinPay()
        alipayPay()

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
extension KYOrderPayViewController{
    func weixinPay() {
        let params = ["master_order_sn":orderID]
        SJBRequestModel.push_fetchOrderWeiXinPayData(params: params as [String : AnyObject]) { (response, status) in
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
        }
    }
    func alipayPay() {
        let alipayParams = ["order_sn":orderID]
        SJBRequestModel.push_fetchOrderAlipayPayData(params: alipayParams as [String : AnyObject]) { (response, status) in
            if status == 1 {
                let orderString = response as! String
                let appScheme = "com.kymart.shop"
                AlipaySDK.defaultService().payOrder(orderString, fromScheme: appScheme, callback: { (result) in
                    let resultDic = result! as Dictionary
                    if let resultStatus = resultDic["resultStatus"] as? String{
                        if resultStatus == "9000"{
                            self.Toast(content: "支付成功")
                            self.navigationController?.popToRootViewController(animated: true)
                            self.tabBarController?.selectedIndex = 3
                        }
                        else
                        {
                            self.Toast(content: "支付失败，请重新支付！")

                        }
                    }
                })
            }
        }
        
    }
}
