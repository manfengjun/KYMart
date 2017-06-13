//
//  KYProductBuyInfoModel.swift
//  KYMart
//
//  Created by Jun on 2017/6/9.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYProductBuyInfoModel: NSObject {
    var good_buy_id: Int? //购买ID
    var good_buy_count: Int = 1//购买数量
    var good_buy_store_count: Int = 0//当前价格库存
    var good_buy_price: String!//购买价格（单价）
    var good_buy_propertys: [Good_Buy_Property]!//属性数组
    var spec_goods_prices:[Spec_goods_price]!// 价格数组
    var good_select_info:String!// 已选
    var isCanBuy:Bool = true
    /// 排序
    func sortByItem_id() -> [Good_Buy_Property]{
        /// 按ID排序
        let array = good_buy_propertys as! NSMutableArray
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
    func calculatePrice(propertys:[Good_Buy_Property]){
        if spec_goods_prices == nil {
            return
        }
        /// 插价key
        var key:String = ""
        /// 拼接查价Key
        for item in propertys {
            key = key.appending("_\(item.good_buy_spec_list.item_id)")
        }
        if !propertys.isEmpty {
            /// 查询价格
            key = NSString(string: key).substring(from: 1)
        }
        /// 根据选择查询价格
        let predicate = NSPredicate(format: "key = %@", key)
        let array = spec_goods_prices as! NSMutableArray
        let result = array.filtered(using: predicate)
        if result.count > 0{
            let spec_goods_price = result[0] as! Spec_goods_price
            if let text = spec_goods_price.price {
                good_buy_price = text
                good_buy_store_count = spec_goods_price.store_count
            }
        }
    }
    func createGoodSelectInfo(propertys:[Good_Buy_Property]) {
        var select_str:String = ""
        /// 拼接查价Key
        for item in propertys {
            select_str += "\(item.good_buy_spec_list.item!),"
        }
        // 已选内容
        select_str += "\(good_buy_count)件"
        good_select_info = select_str
    }
    
    /// 有改动刷新数据
    func reloadData(){
        
        // 排序
        let propertys = sortByItem_id()
        good_buy_propertys = propertys
        // 算价
        calculatePrice(propertys: propertys)
        // 拼接选择的信息
        createGoodSelectInfo(propertys: propertys)
        isCanBuy = (good_buy_store_count >= good_buy_count)
        isCanBuy = !(good_buy_store_count == 0)
    }
}
class Good_Buy_Property: NSObject {
    var good_buy_spec_name: String!//属性名称
    var good_buy_spec_list: Spec_list!//属性内容
}
