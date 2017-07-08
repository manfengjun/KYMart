//
//  KYOrderModel.swift
//  KYMart
//
//  Created by JUN on 2017/7/8.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class AddressList :NSObject{
    var consignee: String!
    var mobile: String!
    var province: Int = 0
    var user_id: Int = 0
    var zipcode: String!
    var address_id: Int = 0
    var twon: Int = 0
    var address: String!
    var city: Int = 0
    var district: Int = 0
    var is_default: Int = 0
    var email: String!
    var country: Int = 0
    
}

class OrderCartList :NSObject{
    var session_id: String!
    var spec_key: String!
    var spec_key_name: String!
    var sku: String!
    var user_id: Int = 0
    var market_price: String!
    var goods_name: String!
    var store_id: Int = 0
    var store_count: Int = 0
    var bar_code: String!
    var goods_fee: Int = 0
    var goods_num: Int = 0
    var prom_id: Int = 0
    var id: Int = 0
    var prom_type: Int = 0
    var member_goods_price: String!
    var add_time: Int = 0
    var goods_price: String!
    var goods_id: Int = 0
    var selected: Int = 0
    var goods_sn: String!
    
}

class ShippingList :NSObject{
    var freight: Int = 0
    var shipping_area_id: Int = 0
    var shipping_code: String!
    var store_id: Int = 0
    var name: String!
    
}

class OrderStoreList :NSObject{
    var user_note: String!
    var coupon_num: Int = 0
    var cartList: [OrderCartList]!
    var shippingList: [ShippingList]!
    var store_id: Int = 0
    var store_name: String!
    class func modelContainerPropertyGenericClass() -> NSDictionary {
        return ["cartList" : OrderCartList.classForCoder(),"shippingList" : ShippingList.classForCoder()]
    }
    
}

class UserInfo :NSObject{
    var message_mask: Int = 0
    var frozen_money: String!
    var unionid: String!
    var second_leader: Int = 0
    var user_money: String!
    var bank_name: String!
    var bank_card: String!
    var level: Int = 0
    var first_leader: Int = 0
    var total_bonus1: String!
    var total_sell: String!
    var nickname: String!
    var total_amount: String!
    var realname: String!
    var oauth: String!
    var reg_time: Int = 0
    var third_leader: Int = 0
    var email_validated: Int = 0
    var deep: Int = 0
    var sex: Int = 0
    var email: String!
    var idcard: String!
    var operator_status: Int = 0
    var birthday: Int = 0
    var pay_points: Int = 0
    var is_lock: Int = 0
    var lft: Int = 0
    var mobile: String!
    var bonus: String!
    var rgt: Int = 0
    var head_pic: String!
    var user_id: Int = 0
    var last_login: Int = 0
    var push_id: String!
    var qq: String!
    var openid: String!
    var is_distribut: Int = 0
    var sell_status: Int = 0
    var distribut_money: String!
    var token: String!
    var paypwd: String!
    var ref_id: Int = 0
    var mobile_validated: Int = 0
    var password: String!
    var discount: String!
    var last_ip: String!
    var underling_number: Int = 0
    var total_bonus: String!
    
}

class TotalPrice :NSObject{
    var cut_fee: Int = 0
    var num: Int = 0
    var total_fee: Int = 0
    
}

class KYOrderModel :NSObject{
    var addressList: AddressList!
    var storeList: [OrderStoreList]!
    var userInfo: UserInfo!
    var totalPrice: TotalPrice!
    class func modelContainerPropertyGenericClass() -> NSDictionary {
        return ["storeList" : OrderStoreList.classForCoder()]
    }
    
}
