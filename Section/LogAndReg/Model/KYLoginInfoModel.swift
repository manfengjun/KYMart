
//
//  LoginInfoModel.swift
//  KYMart
//
//  Created by jun on 2017/6/10.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYLoginInfoModel: NSObject,NSCoding {
    var frozen_money: String!
    var email_validated: String!
    var birthday: String!
    var province: String!
    var user_money: String!
    var district: String!
    var openid: String!
    var user_id: String!
    var mobile_validated: String!
    var nickname: String!
    var sex: String!
    var oauth: String!
    var last_ip: String!
    var city: String!
    var last_login: String!
    var reg_time: String!
    var address_id: String!
    var head_pic: String!
    var token: String!
    var email: String!
    var mobile: String!
    var pay_points: String!
    var password: String!
    var qq: String!
    override init() {
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(frozen_money, forKey: "frozen_money")
        aCoder.encode(email_validated, forKey: "email_validated")
        aCoder.encode(birthday, forKey: "birthday")
        aCoder.encode(province, forKey: "province")
        aCoder.encode(user_money, forKey: "user_money")
        aCoder.encode(district, forKey: "district")
        aCoder.encode(openid, forKey: "openid")
        aCoder.encode(user_id, forKey: "user_id")
        aCoder.encode(mobile_validated, forKey: "mobile_validated")
        aCoder.encode(nickname, forKey: "nickname")
        aCoder.encode(sex, forKey: "sex")
        aCoder.encode(oauth, forKey: "oauth")
        aCoder.encode(last_ip, forKey: "last_ip")
        aCoder.encode(city, forKey: "city")
        aCoder.encode(last_login, forKey: "last_login")
        aCoder.encode(reg_time, forKey: "reg_time")
        aCoder.encode(address_id, forKey: "address_id")
        aCoder.encode(head_pic, forKey: "head_pic")
        aCoder.encode(token, forKey: "token")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(mobile, forKey: "mobile")
        aCoder.encode(pay_points, forKey: "pay_points")
        aCoder.encode(password, forKey: "password")
        aCoder.encode(qq, forKey: "qq")
    }
    required init?(coder aDecoder: NSCoder) {
        frozen_money = aDecoder.decodeObject(forKey: "frozen_money") as? String
        email_validated = aDecoder.decodeObject(forKey: "email_validated") as? String
        birthday = aDecoder.decodeObject(forKey: "birthday") as? String
        province = aDecoder.decodeObject(forKey: "province") as? String
        user_money = aDecoder.decodeObject(forKey: "user_money") as? String
        district = aDecoder.decodeObject(forKey: "district") as? String
        openid = aDecoder.decodeObject(forKey: "openid") as? String
        user_id = aDecoder.decodeObject(forKey: "user_id") as? String
        mobile_validated = aDecoder.decodeObject(forKey: "mobile_validated") as? String
        nickname = aDecoder.decodeObject(forKey: "nickname") as? String
        sex = aDecoder.decodeObject(forKey: "sex") as? String
        oauth = aDecoder.decodeObject(forKey: "oauth") as? String
        last_ip = aDecoder.decodeObject(forKey: "last_ip") as? String
        city = aDecoder.decodeObject(forKey: "city") as? String
        last_login = aDecoder.decodeObject(forKey: "last_login") as? String
        reg_time = aDecoder.decodeObject(forKey: "reg_time") as? String
        address_id = aDecoder.decodeObject(forKey: "address_id") as? String
        head_pic = aDecoder.decodeObject(forKey: "head_pic") as? String
        token = aDecoder.decodeObject(forKey: "token") as? String
        email = aDecoder.decodeObject(forKey: "email") as? String
        mobile = aDecoder.decodeObject(forKey: "mobile") as? String
        pay_points = aDecoder.decodeObject(forKey: "pay_points") as? String
        password = aDecoder.decodeObject(forKey: "password") as? String
        qq = aDecoder.decodeObject(forKey: "qq") as? String
        
    }
}
