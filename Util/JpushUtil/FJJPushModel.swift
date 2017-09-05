//
//  FJJPushModel.swift
//  KYMart
//
//  Created by jun on 2017/9/5.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
class Aps :NSObject{
    var badge: Int = 0
    var sound: String!
    var alert: String!
    
}
class FJJPushModel :NSObject{
    var id: String!
    var _j_business: Int = 0
    var _j_uid: Int = 0
    var type: String!
    var _j_msgid: Int = 0
    var aps: Aps!
    
}
