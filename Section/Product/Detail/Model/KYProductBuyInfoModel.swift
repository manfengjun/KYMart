//
//  KYProductBuyInfoModel.swift
//  KYMart
//
//  Created by Jun on 2017/6/9.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYProductBuyInfoModel: NSObject {
    var good_buy_count: Int = 0//购买数量
    var good_buy_price: String!//购买价格（单价）
    var good_Buy_Propertys: [Good_Buy_Property]!//属性数组
    var spec_goods_prices:[Spec_goods_price]!// 价格数组
    
    /// 排序
    func sortByItem_id() -> [Good_Buy_Property]{
        /// 按ID排序
        let array = good_Buy_Propertys as! NSMutableArray
        return array.sortedArray(options: .stable, usingComparator: { (object1, object2) -> ComparisonResult in
            let good_Buy_Property1 = object1 as! Good_Buy_Property
            let good_Buy_Property2 = object2 as! Good_Buy_Property
            
            if good_Buy_Property1.good_buy_spec_list.item_id > good_Buy_Property2.good_buy_spec_list.item_id{
                return ComparisonResult.orderedDescending
            }
            if good_Buy_Property1.good_buy_spec_list.item_id > good_Buy_Property2.good_buy_spec_list.item_id{
                return ComparisonResult.orderedAscending
            }
            return ComparisonResult.orderedSame
        }) as! [Good_Buy_Property]
    }
    func calculatePrice(){
        let propertys = sortByItem_id()
        var key:String = ""
        /// 拼接查价Key
        for item in propertys {
            key = key.appending("_\(item.good_buy_spec_list.item_id)")
        }
        let str = NSString(string: key).substring(from: 1)
        /// 根据选择查询价格
        let predicate = NSPredicate(format: "key = %@", str)
        let array = spec_goods_prices as! NSMutableArray
        let result = array.filtered(using: predicate)
        if result.count > 0{
            let spec_goods_price = result[0] as! Spec_goods_price
            if let text = spec_goods_price.price {
                good_buy_price = text
            }
        }
    }
}
class Good_Buy_Property: NSObject {
    var good_buy_spec_name: String!//属性名称
    var good_buy_spec_list: Spec_list!//属性内容
}
