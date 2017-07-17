//
//  KYProductListNoSortModel.swift
//  KYMart
//
//  Created by jun on 2017/7/17.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYProductListNoSortModel: NSObject {
    var status: Int = 0
    var search_kt: Int = 0
    var goods_list: [Goods_list]!
    var msg: String!
    class func modelCustomPropertyMapper() -> NSDictionary {
        return ["goods_list" : "result"]
    }
    class func modelContainerPropertyGenericClass() -> NSDictionary {
        return ["goods_list" : Goods_list.classForCoder()]
    }

}
