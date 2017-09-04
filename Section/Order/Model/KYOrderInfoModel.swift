//
//  KYOrderInfoModel.swift
//  KYMart
//
//  Created by jun on 2017/7/12.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYOrderInfoModel: NSObject {
    var order_statis_id: Int = 0
    var return_btn: Int = 0
    var user_id: Int = 0
    var shipping_code: String!
    var store_phone: String!
    var pay_name: String!
    var order_prom_type: Int = 0
    var province: Int = 0
    var shipping_time: String!
    var receive_btn: Int = 0
    var comment_btn: Int = 0
    var integral: Int = 0
    var order_status_desc: String!
    var vrorder: [Vrorder]!
    var invoice_title: String!
    var cancel_btn: Int = 0
    var confirm_time: Int = 0
    var user_money: String!
    var order_prom_amount: String!
    var pay_btn: Int = 0
    var address: String!
    var coupon_price: String!
    var goods_price: String!
    var shipping_status: Int = 0
    var shipping_name: String!
    var pay_code: String!
    var goods_list: [Order_Info_Goods_list]!
    var is_comment: Int = 0
    var add_time: Int = 0
    var deleted: Int = 0
    var shipping_btn: Int = 0
    var country: Int = 0
    var store_qq: String!
    var email: String!
    var parent_sn: String!
    var order_status_code: String!
    var pay_time: Int = 0
    var store_id: Int = 0
    var master_order_sn: String!
    var district: Int = 0
    var admin_note: String!
    var user_note: String!
    var store_name: String!
    var twon: Int = 0
    var pay_status: Int = 0
    var order_prom_id: Int = 0
    var order_sn: String!
    var consignee: String!
    var shipping_price: String!
    var order_status: Int = 0
    var order_id: Int = 0
    var total_amount: String!
    var city: Int = 0
    var zipcode: String!
    var integral_money: String!
    var mobile: String!
    var order_amount: String!
    var invoice_no: String!
    var discount: String!
    var transaction_id: String!
    class func modelContainerPropertyGenericClass() -> NSDictionary {
        return ["goods_list" : Order_Info_Goods_list.classForCoder(),"vrorder" : Vrorder.classForCoder()]
    }
}
class Order_Info_Goods_list :NSObject{
    var order_sn: String!
    var is_comment: Int = 0
    var spec_key: String!
    var is_checkout: Int = 0
    var spec_key_name: String!
    var delivery_id: Int = 0
    var sku: String!
    var market_price: String!
    var goods_name: String!
    var deleted: Int = 0
    var store_id: Int = 0
    var bar_code: String!
    var give_integral: Int = 0
    var order_id: Int = 0
    var goods_num: Int = 0
    var distribut: String!
    var prom_id: Int = 0
    var prom_type: Int = 0
    var cost_price: String!
    var commission: Int = 0
    var member_goods_price: String!
    var original_img: String!
    var goods_price: String!
    var goods_id: Int = 0
    var is_send: Int = 0
    var goods_sn: String!
    var rec_id: Int = 0
    var reason: String!//退货时描述

    
}
class Vrorder: NSObject {
    var vr_code: String!
    var vr_usetime: String!
    var vr_state: Int = 0
    var vr_indate: Int = 0
}
