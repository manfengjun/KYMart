//
//  FJSectionModel.swift
//  KYMart
//
//  Created by jun on 2017/6/6.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class FJSectionModel: NSObject {
    var id: Int = 0
    var mobile_name: String!
    var parent_id: Int = 0
    var parent_id_path: String!
    var level: Int = 0
    var image: String!
    var is_show: Int = 0
    var type_id: Int = 0
    var commission_rate: Int = 0
    var commission: Int = 0
    var sort_order: Int = 0
    var cat_group: Int = 0
    var name: String!
    var is_hot: Int = 0
}
