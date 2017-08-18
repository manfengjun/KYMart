//
//  KYProductSectionListModel.swift
//  KYMart
//
//  Created by jun on 2017/8/18.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYProductSectionListModel: NSObject {
    var more_url: String!
    var id: Int = 0
    var item: [Goods_list]!
    var mobile_name: String!
    class func modelContainerPropertyGenericClass() -> NSDictionary {
        return ["item" : Goods_list.classForCoder()]
    }
}
