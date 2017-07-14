//
//  KYOrderMenuUtil.swift
//  KYMart
//
//  Created by JUN on 2017/7/12.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYOrderMenuUtil: NSObject {
    
    /// 删除订单
    ///
    /// - Parameters:
    ///   - order_id: order_id description
    ///   - completion: completion description
    class func delOrder(order_id:String,completion:@escaping (Bool) -> Void) {
        let params = ["order_id":order_id]
        SJBRequestModel.push_fetchDelOrderData(params: params as [String : AnyObject]) { (response, status) in
            if status == 1 {
                self.Toast(content: "删除成功")
                completion(true)
            }
            else
            {
                self.Toast(content: "删除失败")
                completion(false)

            }
        }
    }

    /// 支付订单
    ///
    /// - Parameters:
    ///   - order_id: order_id description
    ///   - order_money: order_money description
    ///   - target: target description
    class func payOrder(order_id:String,order_money:String,target:UIViewController) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let orderPayVC = storyboard.instantiateViewController(withIdentifier: "OrderPayVC") as! KYOrderPayViewController
        orderPayVC.isCart = false
        orderPayVC.orderID = order_id
        orderPayVC.orderMoney = order_money
        target.navigationController?.pushViewController(orderPayVC, animated: true)
    }
    
    /// 确认收货
    ///
    /// - Parameters:
    ///   - order_id: order_id description
    ///   - completion: completion description
    class func confirmOrder(order_id:String,completion:@escaping (Bool) -> Void) {
        let params = ["order_id":order_id]
        SJBRequestModel.push_fetchConfirmOrderData(params: params as [String : AnyObject]) { (response, status) in
            if status == 1 {
                self.Toast(content: "确认收货成功")
                completion(true)
            }
            else
            {
                self.Toast(content: "确认收货失败")
                completion(false)
                
            }
        }
    }
    
}
