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
class SJBRequestUrl: NSObject {
    
    /// access_token
    ///
    /// - Returns: return value description
    class func access_token() -> String {
        return SingleManager.instance.access_token!
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
    
    /// 注册
    ///
    /// - Returns: return value description
    class func returnRegisterUrl() -> String {
        return "\(basePath)m=Api&c=User&a=reg"
    }
}
