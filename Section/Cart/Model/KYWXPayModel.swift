//
//  KYWXPayModel.swift
//  KYMart
//
//  Created by JUN on 2017/7/9.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYWXPayModel: NSObject {
    var timestamp: String!
    var partnerid: String!
    var success: Bool = false
    var package: String!
    var noncestr: String!
    var sign: String!
    var appid: String!
    var prepayid: String!
}
