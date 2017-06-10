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
    case ProductInfo//商品详情
    case VerifyCode//验证码
    case Login
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
            case .ProductInfo:
                let temmodel = KYGoodInfoModel.yy_model(with: response as! [AnyHashable : Any])
                if let model = temmodel {
                    completion(model,status)
                }
                break
            case .VerifyCode:
                let text = response as! String
                SingleManager.instance.verify_code = text
                completion(text as AnyObject,status)
                break
            case .Login:
                let temmodel = KYLoginInfoModel.yy_model(with: response as! [AnyHashable : Any])
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
            completion(response as AnyObject,status)
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
            completion(response as AnyObject,status)
        }
    }
    // MARK: ------------------ Pull
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
    
    /// 获取商品列表
    ///
    /// - Parameters:
    ///   - id: id description
    ///   - page: page description
    ///   - url: url description
    ///   - completion: completion description
    class func pull_fetchProductListData(id:Int, page:Int, url:String, completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Get(url: SJBRequestUrl.returnProductLisyUrl(id: id, url: url, page: page )) { (response, status) in
            self.dataToModel(type: .ProductList, response: response, status: status, completion: completion)
        }
    }

    
    /// 获取商品详情
    ///
    /// - Parameters:
    ///   - id: id description
    ///   - completion: completion description
    class func pull_fetchProductInfoData(id:Int, completion:@escaping (AnyObject,Int) -> Void) {
        let params = ["id":String(id)]
        SJBRequest.Post(url: SJBRequestUrl.returnProductInfoUrl(), params: params) { (response, status) in
            self.dataToModel(type: .ProductInfo, response: response, status: status, completion: completion)
        }
    }
    
    /// 获取验证码
    ///
    /// - Parameter completion: completion description
    class func pull_fetchVerifyCodeData(completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Get(url: SJBRequestUrl.returnVerifyCodeUrl()) { (response, status) in
            self.dataToModel(type: .VerifyCode, response: response, status: status, completion: completion)
        }
    }
    // MARK: ------------------ Push
    
    /// 登录
    ///
    /// - Parameters:
    ///   - params: params description
    ///   - completion: completion description
    class func push_fetchLoginData(params:[String:String], completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Post(url: SJBRequestUrl.returnLoginUrl(), params: params) { (response, status) in
            self.dataToModel(type: .Login, response: response, status: status, completion: completion)
        }
    }
    
    class func push_fetchRegData(params:[String:String], completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Post(url: SJBRequestUrl.returnRegisterUrl(), params: params) { (response, status) in
//            self.dataToModel(type: .Login, response: response, status: status, completion: completion)
        }
    }
}
