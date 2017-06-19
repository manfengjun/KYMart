//
//  RequestUrl.swift
//  HNLYSJB
//
//  Created by jun on 2017/5/22.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
let basePath = "http://test.kymart.cn/index.php?"
let baseHref = "http://test.kymart.cn"
let imgPath = "http://test.kymart.cn"

class SJBRequestUrl: NSObject {
    
    /// access_token
    ///
    /// - Returns: return value description
    class func access_token() -> String {
        if let token = SingleManager.instance.loginInfo?.token{
            return token
        }
        return ""
    }
    
    /// unique_id
    ///
    /// - Returns: return value description
    class func unique_id() -> String {
        return SingleManager.getUUID()
    }
    // MARK: ------ 首页
    /// 首页
    ///
    /// - Returns: return value description
    class func returnHomePageUrl() -> String {
        return "\(basePath)m=api&c=Index&a=homePage"
    }
    
    /// 首页猜你喜欢
    ///
    /// - Parameter page: page description
    /// - Returns: return value description
    class func returnHomePageProductUrl(page:Int) -> String {
        return "\(basePath)m=api&c=Index&a=favourite&p=\(page)"
    }
    
    // MARK: ------ 菜单
    /// 获取一级分类列表
    ///
    /// - Parameter page: page description
    /// - Returns: return value description
    class func returnSectionUrl() -> String {
        return "\(basePath)m=api&c=goods&a=goodsCategoryList"
    }
    
    /// 获取二级分类
    ///
    /// - Parameter parent_id: parent_id description
    /// - Returns: return value description
    class func returnSubSectionUrl(parent_id:Int) -> String {
        return "\(basePath)m=api&c=goods&a=goodsSecAndThirdCategoryList&parent_id=\(parent_id)"
    }
    
    // MARK: ------ 商品
    /// 获取商品列表
    ///
    /// - Parameter id: id description
    /// - Returns: return value description
    class func returnProductLisyUrl(id:Int, url:String, page:Int) -> String {
        return "\(baseHref)\(url)/p/\(page)"
    }
    
    /// 获取商品详情
    ///
    /// - Returns: return value description
    class func returnProductInfoUrl() -> String {
        return "\(basePath)m=api&c=goods&a=goodsInfo"
    }
    
    /// 商品内容页
    ///
    /// - Returns: return value description
    class func returnProductContentUrl(id:Int) -> String {
        return "\(basePath)m=api&c=goods&a=goodsContent&id=\(id)"
    }
    
    func returnProductSearchUrl() -> String {
        return ""
    }
    // MARK: ------ 购物车
    
    /// 添加购物车
    ///
    /// - Returns: return value description
    class func returnAddCartUrl() -> String {
        return "\(basePath)m=Api&c=Cart&a=addCart&unique_id=\(SingleManager.getUUID())&token=\(access_token())"
    }
    
    /// 购物车列表
    ///
    /// - Returns: return value description
    class func returnCartListUrl() -> String {
        return "\(basePath)m=Api&c=Cart&a=cartList"
    }
    
    /// 购物车删除
    ///
    /// - Returns: return value description
    class func returnDelCartUrl() -> String {
        return "\(basePath)m=Api&c=Cart&a=delCart"
    }
    // MARK: ------ 登录
    /// 登录
    ///
    /// - Returns: return value description
    class func returnLoginUrl() -> String {
        return "\(basePath)m=Api&c=User&a=login"
    }
    
    /// 获取验证码
    ///
    /// - Returns: return value description
    class func returnVerifyCodeUrl() -> String {
        return "\(basePath)m=api&c=User&a=verify&unique_id=\(SingleManager.getUUID())"
    }
    
    /// 发送注册短信验证码
    ///
    /// - Returns: return value description
    class func returnRegVerifyCodeUrl(phone:String,code:String) -> String {
        return "\(basePath)m=Home&c=Api&a=send_validate_code&scene=1&type=mobile&mobile=\(phone)&capache=\(code)&unique_id=\(SingleManager.getUUID())"
    }
    
    /// 注册
    ///
    /// - Parameters:
    ///   - phone: phone description
    ///   - code: code description
    /// - Returns: return value description
    class func returnRegisterUrl() -> String {
        return "\(basePath)m=Api&c=User&a=reg"
    }
    
    /// 发送重置密码验证码
    ///
    /// - Parameters:
    ///   - phone: phone description
    /// - Returns: return value description
    class func returnRegVerifyCodeUrl(phone:String) -> String {
        return "\(basePath)m=Home&c=Api&a=send_validate_code&scene=2&type=mobile&mobile=\(phone)&unique_id=\(SingleManager.getUUID())"
    }
    
    /// 重置密码
    ///
    /// - Returns: return value description
    class func returnForgetUrl() -> String {
        return "\(basePath)m=api&c=user&a=forgetPassword"
    }

    // MARK: ------ 个人中心
    /// 获取用户信息
    ///
    /// - Returns: return value description
    class func returnUserInfoUrl() -> String {
        return "\(basePath)m=api&c=user&a=userInfo&unique_id=\(SingleManager.getUUID())&token=\(access_token())"
    }
    
    /// 更改头像
    ///
    /// - Returns: return value description
    class func returnChangePortraitUrl() -> String {
        return "\(basePath)m=api&c=User&a=upload_headpic&unique_id=\(SingleManager.getUUID())&token=\(access_token())"
    }
    
    // MARK: ------ 地址管理
    /// 获取地址分级信息
    ///
    /// - Parameters:
    ///   - level: level description
    ///   - parent_id: parent_id description
    /// - Returns: return value description
    class func returnAddressMenuUrl(level:Int, parent_id:Int) -> String {
        return "\(basePath)m=api&c=other&a=region&level=\(level)&parent_id=\(parent_id)"
    }
    
    /// 获取地址列表
    ///
    /// - Returns: return value description
    class func returnAddressListUrl() -> String {
        return "\(basePath)m=api&c=user&a=getAddressList&unique_id=\(SingleManager.getUUID())&token=\(access_token())"
    }
    
    /// 添加地址
    ///
    /// - Returns: return value description
    class func returnAddAddressUrl() -> String {
        return "\(basePath)m=api&c=user&a=addAddress&unique_id=\(SingleManager.getUUID())&token=\(access_token())"
    }
    
    /// 删除地址
    ///
    /// - Returns: return value description
    class func returnDelAddressUrl() -> String {
        return "\(basePath)m=api&c=user&a=del_address&unique_id=\(SingleManager.getUUID())&token=\(access_token())"
    }
}
