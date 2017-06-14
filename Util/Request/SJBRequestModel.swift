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
    case RegVerifyCode//注册短信验证码
    case Register//注册
    case ForgetVerifyCode//重置密码验证码
    case Forget//重置密码
    case CartList//购物车列表
    case AddCart//添加购物车
    case DelCart//删除购物车商品
    case UserInfo//用户信息
    
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
            case .RegVerifyCode:
                completion("success" as AnyObject,status)

                break
            case .ForgetVerifyCode:
                completion("success" as AnyObject,status)
                
                break
            case .Register:
                let temmodel = KYLoginInfoModel.yy_model(with: response as! [AnyHashable : Any])
                if let model = temmodel {
                    completion(model,status)
                }
                break
            case .Forget:
                completion(response,status)
                break
            case .CartList:
                let temmodel = KYCartListModel.yy_model(with: response as! [AnyHashable : Any])
                if let model = temmodel {
                    completion(model,status)
                }
                break
            case .AddCart:
                completion(response,status)
                break
            case .DelCart:
                completion(response,status)
                break
            case .UserInfo:
                let temmodel = KYUserInfoModel.yy_model(with: response as! [AnyHashable : Any])
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
        SJBRequest.Post(url: SJBRequestUrl.returnProductInfoUrl(), params: params as [String : AnyObject]) { (response, status) in
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
    
    /// 获取用户信息
    ///
    /// - Parameter completion: completion description
    class func pull_fetchUserInfoData(completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Get(url: SJBRequestUrl.returnUserInfoUrl()) { (response, status) in
            self.dataToModel(type: .UserInfo, response: response, status: status, completion: completion)
        }
    }
    // MARK: ------------------ Push
    
    /// 登录
    ///
    /// - Parameters:
    ///   - params: params description
    ///   - completion: completion description
    class func push_fetchLoginData(params:[String:AnyObject], completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Post(url: SJBRequestUrl.returnLoginUrl(), params: params) { (response, status) in
            self.dataToModel(type: .Login, response: response, status: status, completion: completion)
        }
    }
    
    /// 注册验证码
    ///
    /// - Parameters:
    ///   - phone: phone description
    ///   - code: code description
    ///   - completion: completion description
    class func push_fetchRegVerifyCodeData(phone:String,code:String, completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Get(url:  SJBRequestUrl.returnRegVerifyCodeUrl(phone: phone, code: code)) { (response, status) in
            self.dataToModel(type: .RegVerifyCode, response: response, status: status, completion: completion)
        }
    }
    
    /// 注册
    ///
    /// - Parameters:
    ///   - params: params description
    ///   - completion: completion description
    class func push_fetchRegisterData(params:[String:AnyObject], completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Post(url: SJBRequestUrl.returnRegisterUrl(), params: params) { (response, status) in
            self.dataToModel(type: .Register, response: response, status: status, completion: completion)
        }
    }
    
    /// 获取重置密码验证码
    ///
    /// - Parameters:
    ///   - params: params description
    ///   - completion: completion description
    class func push_fetchForgetVerifyCodeData(phone:String, completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Get(url:  SJBRequestUrl.returnRegVerifyCodeUrl(phone: phone)) { (response, status) in
            self.dataToModel(type: .ForgetVerifyCode, response: response, status: status, completion: completion)
        }
    }

    /// 重置密码
    ///
    /// - Parameters:
    ///   - params: params description
    ///   - completion: completion description
    class func push_fetchForgetData(params:[String:AnyObject], completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Post(url: SJBRequestUrl.returnForgetUrl(), params: params) { (response, status) in
            self.dataToModel(type: .Forget, response: response, status: status, completion: completion)
        }
    }
    
    /// 添加购物车
    ///
    /// - Parameters:
    ///   - params: params description
    ///   - completion: completion description
    class func push_fetchAddCartProductData(params:[String:AnyObject], completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Post(url: SJBRequestUrl.returnAddCartUrl(), params: params) { (response, status) in
            self.dataToModel(type: .AddCart, response: response, status: status, completion: completion)
        }
    }
    
    /// 购物车商品列表
    ///
    /// - Parameters:
    ///   - params: params description
    ///   - completion: completion description
    class func push_fetchCartProductData(params:[String:AnyObject], completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Post(url: SJBRequestUrl.returnCartListUrl(), params: params) { (response, status) in
            self.dataToModel(type: .CartList, response: response, status: status, completion: completion)
        }
    }
    
    /// 删除购物车商品
    ///
    /// - Parameters:
    ///   - params: params description
    ///   - completion: completion description
    class func push_fetchCartDelData(params:[String:AnyObject], completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Post(url: SJBRequestUrl.returnDelCartUrl(), params: params) { (response, status) in
            self.dataToModel(type: .DelCart, response: response, status: status, completion: completion)
        }
    }
    
}
