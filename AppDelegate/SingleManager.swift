//
//  SingleManager.swift
//  HNLYSJB
//
//  Created by jun on 2017/5/22.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class SingleManager: NSObject {
    /// 单例
    static let instance = SingleManager()
    
    /// 验证码
    var verify_code:String?
    /// 登录token
    var access_token:String?
    /// 购买对象
    var productBuyInfoModel:KYProductBuyInfoModel?
    /// 登录对象
    var loginInfo:KYLoginInfoModel?
    /// 是否登录
    var isLogin:Bool = false
    /// 获取UUID
    ///
    /// - Returns: return value description
    class func getUUID() -> String {
        var retriveuuid = SSKeychain.password(forService: "kymart.key", account: "uuid")
        if let text = retriveuuid {
            retriveuuid = text
        }
        else
        {
            let uuidRef = CFUUIDCreate(kCFAllocatorDefault)
            let strRef = CFUUIDCreateString(kCFAllocatorDefault, uuidRef)
            retriveuuid = (strRef! as String).replacingOccurrences(of: "-", with: "")
            SSKeychain.setPassword(retriveuuid, forService: "kymart.key", account: "uuid")
        }
        return retriveuuid!
    }
}
