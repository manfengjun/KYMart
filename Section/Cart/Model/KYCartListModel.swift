//
//  KYCartListModel.swift
//  KYMart
//
//  Created by Jun on 2017/6/11.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class Total_price :NSObject{
    var cut_fee: CGFloat = 0.0
    var num: Int = 0
    var total_fee: CGFloat = 0.0
    
}

class CartList :NSObject{
    var session_id: String!
    var spec_key: String!
    var spec_key_name: String!
    var sku: String!
    var user_id: String!
    var market_price: String!
    var goods_name: String!
    var store_id: String!
    var store_count: String!
    var bar_code: String!
    var goods_fee: CGFloat = 0.0
    var goods_num: String!
    var prom_id: String!
    var id: String!
    var prom_type: String!
    var member_goods_price: String!
    var add_time: String!
    var goods_price: String!
    var goods_id: String!
    var selected: String!
    var goods_sn: String!
    
}

class StoreList :NSObject{
    var id: Int = 0
    var name: String!
    var cartList: [CartList]!
    
}

class KYCartListModel :NSObject{
    var total_price: Total_price!
    var storeList: [StoreList]!
    
}
