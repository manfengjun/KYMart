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
    /// 登录token
    var access_token:String?
    /// 购买对象
    var productBuyInfoModel:KYProductBuyInfoModel?

}
