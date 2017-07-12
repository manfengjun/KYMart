//
//  KYOrderPriceModel.swift
//  KYMart
//
//  Created by JUN on 2017/7/8.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYOrderPriceModel: NSObject {
    var store_coupon_price: [String:Any] = [String:Any]()
    var couponFee: CGFloat = 0
    var store_order_prom_id: [String:Any] = [String:Any]()
    var store_order_amount: [String:Any] = [String:Any]()
    var store_goods_price: [String:Any] = [String:Any]()
    var balance: CGFloat = 0
    var pointsFee: CGFloat = 0
    var store_order_prom_amount: [String:Any] = [String:Any]()
    var goodsFee: CGFloat = 0.0
    var payables: CGFloat = 0.0
    var order_prom_amount: CGFloat = 0
    var store_point_count: String!
    var store_balance: String!
    var store_shipping_price: [String:Any] = [String:Any]()
    var postFee: CGFloat = 0
}
