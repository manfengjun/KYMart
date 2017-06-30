//
//  KYWithdrawListModel.swift
//  KYMart
//
//  Created by JUN on 2017/6/30.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYWithdrawListModel: NSObject {
    var status: Int = 0
    var result: [Result]!
    var info: Info!
    var msg: String!
    class func modelContainerPropertyGenericClass() -> NSDictionary {
        return ["result" : Result.classForCoder()]
    }
}
class Result :NSObject{
    var id: Int = 0
    var changetype: Int = 0
    var money: String!
    var bank_name: String!
    var pay_code: String!
    var refuse_time: Int = 0
    var realname: String!
    var taxfee: String!
    var error_code: String!
    var user_id: Int = 0
    var check_time: Int = 0
    var remark: String!
    var bank_card: String!
    var real_money: String!
    var create_time: Int = 0
    var status_text: String!
    var pay_time: Int = 0
    var status: Int = 0
    
}

class Info :NSObject{
    var bank_name: String!
    var bank_card: String!
    var realname: String!
    var changetype: String = "1"
    var money: String!
    
    
}
