//
//  RequestUrl.swift
//  HNLYSJB
//
//  Created by jun on 2017/5/22.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class SJBRequestUrl: NSObject {
    static let basePath = "http://test.kymart.cn/index.php?"
    /// access_token
    ///
    /// - Returns: return value description
    class func access_token() -> String {
        return SingleManager.instance.access_token!
    }
    
    /// 菜单Url
    ///
    /// - Returns: return value description
    class func returnMenuUrl() -> String {
        return ""
    }
    
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
    
    
    /// 获取商品列表
    ///
    /// - Parameter id: id description
    /// - Returns: return value description
    class func returnProductLisyUrl(id:Int, orderby:String?, orderdesc:String?, page:Int) -> String {
        var url = "\(basePath)m=Api&c=Goods&a=goodsList&id=\(id)&p=\(page)"
        if let str = orderby {
            url = url.appending("&orderby=\(str)")
        }
        if let str = orderdesc {
            url = url.appending("&orderdesc=\(str)")
        }
        return "\(basePath)m=Api&c=Goods&a=goodsList&id=\(id)&p=\(page)"
    }
}
