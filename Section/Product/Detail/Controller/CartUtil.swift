//
//  CartUtil.swift
//  KYMart
//
//  Created by jun on 2017/6/14.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class CartUtil: NSObject {
    class func returnAddParams() -> [String:AnyObject]{
        let goods_id = SingleManager.instance.productBuyInfoModel?.good_buy_id
        let goods_num = SingleManager.instance.productBuyInfoModel?.good_buy_count
        let goods_spec = NSMutableArray()
        if let array = SingleManager.instance.productBuyInfoModel?.good_buy_propertys
        {
            if array.count > 0{
                for item in array{
                    goods_spec.add("\(item.good_buy_spec_list.item_id)")
                }
                return ["goods_num": String(goods_num!) as AnyObject, "goods_spec": goods_spec, "goods_id": String(goods_id!) as AnyObject]
            }
        }
        return ["goods_num": String(goods_num!) as AnyObject, "goods_id": String(goods_id!) as AnyObject]

    }
    class func addCart() {
        let params = returnAddParams()
        SJBRequestModel.push_fetchAddCartProductData(params: params as [String : AnyObject], completion: { (response, status) in
            if status == 1{
                
                self.Toast(content: "添加成功！")
            }
            else
            {
                self.Toast(content: "添加失败")
            }
        })
    }
}
