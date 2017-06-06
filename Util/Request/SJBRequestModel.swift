//
//  RequestModel.swift
//  HNLYSJB
//
//  Created by jun on 2017/5/22.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
enum ModelType {
    case HomePage//首页
    case HomePageProduct//猜我喜欢
    case Section//一级分类
    case SubSection//二三级分类
    case ProductList//商品列表
}
class SJBRequestModel: NSObject {
    class func dataToModel(type:ModelType, response:AnyObject, status:Int, completion:(AnyObject,Int)-> Void) {
        if status == 1 {
            switch type {
            case .HomePage:
                let temmodel = KYHomeModel.yy_model(with: response as! [AnyHashable : Any])
                if let model = temmodel {
                    completion(model,status)
                }
                break
            case .ProductList:
                let temmodel = KYProductListModel.yy_model(with: response as! [AnyHashable : Any])
                if let model = temmodel {
                    completion(model,status)
                }
                break
            default:
                break
            }
        }
        else
        {
            completion("error" as AnyObject,status)
        }
    }
    class func dataArrayToModel(type:ModelType, response:AnyObject,  status:Int, completion:(AnyObject,Int)-> Void) {
        let dataArray = NSMutableArray()
        if status == 1 {
            switch type {
            case .HomePageProduct:
                let result = response as! NSDictionary
                if let array = result["favourite_goods"] {
                    for item in array as! NSArray {
                        let temmodel = Good.yy_model(with: item as! [AnyHashable : Any])
                        if let model = temmodel {
                            dataArray.add(model)
                        }
                    }
                }
                break
            case .Section:
                for item in response as! NSArray {
                    let temmodel = FJSectionModel.yy_model(with: item as! [AnyHashable : Any])
                    if let model = temmodel {
                        dataArray.add(model)
                    }
                }
                break
            case .SubSection:
                for item in response as! NSArray {
                    let temmodel = FJSubSectionModel.yy_model(with: item as! [AnyHashable : Any])
                    if let model = temmodel {
                        dataArray.add(model)
                    }
                }
                break
            default:
                break
            }
            completion(dataArray,status)
        }
        else
        {
            completion("error" as AnyObject,status)
        }
    }
    
    /// 首页数据
    ///
    /// - Parameter completion: completion description
    class func pull_fetchHomePageData(completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Get(url: SJBRequestUrl.returnHomePageUrl()) { (response, status) in
            self.dataToModel(type: .HomePage, response: response, status: status, completion: completion)
        }
    }
    
    /// 猜我喜爱
    ///
    /// - Parameters:
    ///   - page: page description
    ///   - completion: completion description
    class func pull_fetchFavoriteProductData(page:Int, completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Get(url: SJBRequestUrl.returnHomePageProductUrl(page: page)) { (response, status) in
            self.dataArrayToModel(type: .HomePageProduct, response: response, status: status, completion: completion)
        }
    }
    
    /// 一级分类
    ///
    /// - Parameter completion: completion description
    class func pull_fetchSectionData(completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Get(url: SJBRequestUrl.returnSectionUrl()) { (response, status) in
            self.dataArrayToModel(type: .Section, response: response, status: status, completion: completion)
        }
    }
    
    /// 二级分类
    ///
    /// - Parameters:
    ///   - parent_id: parent_id description
    ///   - completion: completion description
    class func pull_fetchSubSectionData(parent_id:Int, completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Get(url: SJBRequestUrl.returnSubSectionUrl(parent_id: parent_id)) { (response, status) in
            self.dataArrayToModel(type: .SubSection, response: response, status: status, completion: completion)
        }
    }
    
    class func pull_fetchProductListData(id:Int, page:Int, orderby:String?, orderdesc:String?, completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Get(url: SJBRequestUrl.returnProductLisyUrl(id: id, orderby: orderby, orderdesc: orderdesc, page: page)) { (response, status) in
            self.dataToModel(type: .ProductList, response: response, status: status, completion: completion)
        }
    }

}
