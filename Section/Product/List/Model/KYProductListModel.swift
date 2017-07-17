//
//  ProductListModel.swift
//  KYMart
//
//  Created by jun on 2017/6/6.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
class Item :NSObject{
    var name: String!
    var href: String!
    var id: Int = 0
    
}

class Filter_attr :NSObject{
    var name: String!
    var item: [Item]!
    
}

class Filter_price :NSObject{
    var name: String!
    var href: String!
    var id: Int = 0
    
}

class Filter_brand :NSObject{
    var name: String!
    var hreg: String!
    var id: Int = 0
    
}

class Goods_list :NSObject{
    var shop_price: String!
    var good_comment_rate: Int = 0
    var cat_id3: Int = 0
    var goods_sn: String!
    var comment_count: Int = 0
    var goods_name: String!
    var goods_id: Int = 0
    var ky_type: Int = 0

    
}

class KYProductListModel: NSObject {
    var filter_attr: [Filter_attr]!
    var filter_price: [Filter_price]!
    var sort: String!
    var orderby_sales_sum: String!
    var orderby_is_new: String!
    var sort_asc: String!
    var orderby_default: String!
    var filter_brand: [Filter_brand]!
    var orderby_comment_count: String!
    var goods_list: [Goods_list]!
    var orderby_price: String!
    class func modelContainerPropertyGenericClass() -> NSDictionary {
        return ["filter_attr" : Filter_attr.classForCoder(),"filter_price" : Filter_price.classForCoder(),"filter_brand" : Filter_brand.classForCoder(),"goods_list" : Goods_list.classForCoder()]
    }

}
