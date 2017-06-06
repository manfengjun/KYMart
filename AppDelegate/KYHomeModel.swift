//
//  KYHomeModel.swift
//  KYMart
//
//  Created by jun on 2017/6/6.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
class Good :NSObject{
    var shop_price: String!
    var goods_id: Int = 0
    var end_time: Int = 0
    var goods_name: String!
    var percent: Int = 0
    var cat_id3: Int = 0

}
class Ad :NSObject{
    var ad_link: String!
    var ad_name: String!
    var ad_code: String!
    
}

class KYHomeModel :NSObject{
    var promotion_goods: [Good]!//促销
    var high_quality_goods: [Good]!//精品推荐
    var hot_goods: [Good]!//热销商品
    var ad: [Ad]!//广告
    var new_goods: [Good]!//新品上市
    var flash_sale_goods: [Good]!//抢购
    class func modelContainerPropertyGenericClass() -> NSDictionary {
        return ["promotion_goods" : Good.classForCoder(),"high_quality_goods" : Good.classForCoder(),"hot_goods" : Good.classForCoder(),"flash_sale_goods" : Good.classForCoder(),"new_goods" : Good.classForCoder(),"ad" : Ad.classForCoder()]
    }
}
