//
//  KYOrderPayViewController.swift
//  KYMart
//
//  Created by JUN on 2017/7/9.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import SVProgressHUD

class KYOrderPayViewController: BaseViewController {

    var orderID:String?
    var orderMoney:String?
    var currentSelect:Int = 1;
    var model:KYWXPayModel?
    @IBOutlet weak var sureBtn: UIButton!
    @IBOutlet weak var orderIdL: UILabel!
    @IBOutlet weak var orderMoneyL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButtonInNav()
        orderIdL.text = "订单号：\(orderID!)"
        orderMoneyL.text = "支付金额：￥\(orderMoney!)"


        NotificationCenter.default.addObserver(self, selector:#selector(weixinPayAction),name: WeiXinPayNotification, object: nil)

        // Do any additional setup after loading the view.
    }
    func weixinPayAction() {
        self.navigationController?.popToRootViewController(animated: true)
        self.tabBarController?.selectedIndex = 3

    }
    @IBAction func selectAction(_ sender: UITapGestureRecognizer) {
        currentSelect = (sender.view?.tag)!
        let wechatBtn = view.viewWithTag(1)?.viewWithTag(11) as! UIButton
        let alipayBtn = view.viewWithTag(2)?.viewWithTag(11) as! UIButton
        wechatBtn.setImage(sender.view?.tag == 1 ? UIImage(named:"cart_select_yes.png") : UIImage(named:"cart_select_no.png"), for: .normal)
        alipayBtn.setImage(sender.view?.tag == 2 ? UIImage(named:"cart_select_yes.png") : UIImage(named:"cart_select_no.png"), for: .normal)
    }
    
    @IBAction func payAction(_ sender: UIButton) {
        sureBtn.isUserInteractionEnabled = false
        SVProgressHUD.show(withStatus: "加载中")
        if currentSelect == 1 {
            // 微信支付
            weixinPay()
            
        }
        else
        {
            //支付宝支付
            alipayPay()
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
extension KYOrderPayViewController{
    func weixinPay() {
        let params = ["master_order_sn":orderID]
        SJBRequestModel.push_fetchOrderWeiXinPayData(params: params as [String : AnyObject]) { (response, status) in
            self.sureBtn.isUserInteractionEnabled = true
            SVProgressHUD.dismiss()
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
            self.sureBtn.isUserInteractionEnabled = true
            SVProgressHUD.dismiss()
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
