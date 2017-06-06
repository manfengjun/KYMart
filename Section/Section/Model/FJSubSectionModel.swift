//
//  FJSubSectionModel.swift
//  KYMart
//
//  Created by jun on 2017/6/6.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
class Sub_category :NSObject{
    var parent_id: Int = 0
    var id: Int = 0
    var level: Int = 0
    var image: String!
    var mobile_name: String!
    
}
class FJSubSectionModel: NSObject {
    var parent_id: Int = 0
    var id: Int = 0
    var sub_category: [Sub_category]!
    var level: Int = 0
    var image: String!
    var mobile_name: String!
    class func modelContainerPropertyGenericClass() -> NSDictionary {
        return ["sub_category" : Sub_category.classForCoder()]
    }
}
