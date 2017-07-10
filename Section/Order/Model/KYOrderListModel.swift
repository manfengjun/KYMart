//
//  KYOrderListModel.swift
//  KYMart
//
//  Created by JUN on 2017/7/10.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYOrderListModel: NSObject {
    var cancel_btn: Int = 0
    var integral: String!
    var country: String!
    var shipping_status: String!
    var user_money: String!
    var zipcode: String!
    var address: String!
    var invoice_title: String!
    var order_prom_id: String!
    var comment_btn: Int = 0
    var invoice_no: String!
    var pay_status: String!
    var order_prom_amount: String!
    var order_status: String!
    var consignee: String!
    var district: String!
    var goods_price: String!
    var order_sn: String!
    var add_time: String!
    var is_cod: String!
    var email: String!
    var integral_money: String!
    var pay_code: String!
    var order_id: String!
    var shipping_name: String!
    var coupon_price: String!
    var store_name: String!
    var shipping_price: String!
    var city: String!
    var shipping_btn: Int = 0
    var shipping_time: String!
    var return_btn: Int = 0
    var mobile: String!
    var pay_time: String!
    var shipping_code: String!
    var province: String!
    var confirm_time: String!
    var pay_note: String!
    var user_id: String!
    var store_id: String!
    var pay_btn: Int = 0
    var order_amount: String!
    var total_fee: Int = 0
    var goods_list: [Order_Goods_list]!
    var receive_btn: Int = 0
    var discount: String!
    var pay_name: String!

}
class Order_Goods_list :NSObject{
    var goods_name: String!
    var spec_key_name: String!
    var goods_num: String!
    var order_id: String!
    var goods_sn: String!
    var spec_key: String!
    var market_price: String!
    var bar_code: String!
    var goods_id: String!
    var goods_price: String!
    var is_comment: String!
    var original_img: String!
    
}
