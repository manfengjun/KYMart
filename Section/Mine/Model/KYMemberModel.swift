//
//  KYMemberModel.swift
//  KYMart
//
//  Created by JUN on 2017/7/4.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYMemberModel: NSObject {
    var status: Int = 0
    var ref_nickname: String!
    var count: Int = 0
    var list: [List]!
    class func modelContainerPropertyGenericClass() -> NSDictionary {
        return ["list" : List.classForCoder()]
    }
}
class List :NSObject{
    var reg_time: Int = 0
    var nickname: String!
    var user_id: Int = 0
    var head_pic: String!
}
