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
    case CartList//购物车列表
    case AddCart//添加购物车
    case DelCart//删除购物车商品
    
    case Order//生成订单
    case OrderMoney//订单金额
    case OrderSubmit//提交订单
    case PostOrderID//提交订单编号
    case OrderWenxinPay//微信支付
    case OrderAlipayPay//支付宝支付
    case OrderList//订单列表
    case OrderInfo//订单详情


    case VerifyCode//验证码
    case Login//登录
    case RegVerifyCode//注册短信验证码
    case Register//注册
    case ForgetVerifyCode//重置密码验证码
    case Forget//重置密码
    
    case UserInfo//用户信息
    case ChangePortrait//修改头像
    case ChangeUserInfo//更改用户信息
    
    case AddressSection//地址分级(未使用，改用本地sqlite)
    case AddAddRess//添加地址
    case AddRessList//地址列表
    case DelAddress//删除地址
    
    case SellList//消费明细
    case BonusList//分享记录
    case PayList//充值记录
    case WithdrawalsList//提现记录
    case Withdrawals//提现记录
    case BonusToMoney//奖金转金额
    
    case QrCode//二维码
    
    case ShareMember//分享会员

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
            case .WithdrawalsList:
                let temmodel = KYWithdrawListModel.yy_model(with: response as! [AnyHashable : Any])
                if let model = temmodel {
                    completion(model,status)
                }
                break
            case .Withdrawals:
                completion(response,status)
                break
            case .QrCode:
                completion(response,status)
                break
            case .BonusToMoney:
                completion(response,status)
                break
            case .ShareMember:
                let temmodel = KYMemberModel.yy_model(with: response as! [AnyHashable : Any])
                if let model = temmodel {
                    completion(model,status)
                }
                break
            case .Order:
                let temmodel = KYOrderModel.yy_model(with: response as! [AnyHashable : Any])
                if let model = temmodel {
                    completion(model,status)
                }
                break
            case .OrderMoney:
                let temmodel = KYOrderPriceModel.yy_model(with: response as! [AnyHashable : Any])
                if let model = temmodel {
                    completion(model,status)
                }
                break
            case .OrderSubmit:
                completion(response,status)

                break
            case .PostOrderID:
                completion(response,status)
                
                break
            case .OrderWenxinPay:
                let temmodel = KYWXPayModel.yy_model(with: response as! [AnyHashable : Any])
                if let model = temmodel {
                    completion(model,status)
                }
                break
            case .OrderAlipayPay:
                completion(response,status)
                
                break
            case .OrderInfo:
                let temmodel = KYOrderInfoModel.yy_model(with: response as! [AnyHashable : Any])
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
            case .AddRessList:
                for item in response as! NSArray {
                    let temmodel = KYAddressModel.yy_model(with: item as! [AnyHashable : Any])
                    if let model = temmodel {
                        dataArray.add(model)
                    }
                }
                break
            case .SellList:
                for item in response as! NSArray {
                    let temmodel = KYSellListModel.yy_model(with: item as! [AnyHashable : Any])
                    if let model = temmodel {
                        dataArray.add(model)
                    }
                }
                break
            case .BonusList:
                for item in response as! NSArray {
                    let temmodel = KYBonusListModel.yy_model(with: item as! [AnyHashable : Any])
                    if let model = temmodel {
                        dataArray.add(model)
                    }
                }
                break
            case .OrderList:
                for item in response as! NSArray {
                    let temmodel = KYOrderListModel.yy_model(with: item as! [AnyHashable : Any])
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
    // MARK: ------ 首页
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
    // MARK: ------ 分类
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
    // MARK: ------ 商品
    /// 获取商品列表
    ///
    /// - Parameters:
    ///   - id: id description
    ///   - page: page description
    ///   - url: url description
    ///   - completion: completion description
    class func pull_fetchProductListData(page:Int, url:String, completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Get(url: SJBRequestUrl.returnProductLisyUrl(url: url, page: page )) { (response, status) in
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
    // MARK: ------ 图形验证码
    /// 获取验证码
    ///
    /// - Parameter completion: completion description
    class func pull_fetchVerifyCodeData(completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Get(url: SJBRequestUrl.returnVerifyCodeUrl()) { (response, status) in
            self.dataToModel(type: .VerifyCode, response: response, status: status, completion: completion)
        }
    }
    
    
    
    
    // MARK: ------ 登录注册
    
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
    // MARK: ------ 购物车
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
    // MARK: ------ 订单

    /// 生成订单
    ///
    /// - Parameters:
    ///   - params: params description
    ///   - completion: completion description
    class func push_fetchOrderProductData(params:[String:AnyObject], completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Post(url: SJBRequestUrl.returnOrderUrl(), params: params) { (response, status) in
            self.dataToModel(type: .Order, response: response, status: status, completion: completion)
        }
    }
    /// 订单金额
    ///
    /// - Parameters:
    ///   - params: params description
    ///   - completion: completion description
    class func push_fetchOrderMoneyData(params:[String:AnyObject], completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Post(url: SJBRequestUrl.returnOrderMoneyUrl(), params: params) { (response, status) in
            if response is String {
                self.dataToModel(type: .OrderSubmit, response: response, status: status, completion: completion)
            }
            else
            {
                self.dataToModel(type: .OrderMoney, response: response, status: status, completion: completion)

            }
        }
    }
    
    /// 提交订单编号
    ///
    /// - Parameters:
    ///   - params: params description
    ///   - completion: completion description
    class func push_fetchPostOrderIdData(params:[String:AnyObject], completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Post(url: SJBRequestUrl.returnPostOrderIdUrl(), params: params) { (response, status) in
            self.dataToModel(type: .PostOrderID, response: response, status: status, completion: completion)
        }
    }

    /// 微信支付
    ///
    /// - Parameters:
    ///   - params: params description
    ///   - completion: completion description
    class func push_fetchOrderWeiXinPayData(params:[String:AnyObject], completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Post(url: SJBRequestUrl.returnWeiXinPayUrl(), params: params) { (response, status) in
            self.dataToModel(type: .OrderWenxinPay, response: response, status: status, completion: completion)
        }
    }
    
    /// 支付宝支付
    ///
    /// - Parameters:
    ///   - params: params description
    ///   - completion: completion description
    class func push_fetchOrderAlipayPayData(params:[String:AnyObject], completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Post(url: SJBRequestUrl.returnAlipayPayUrl(), params: params) { (response, status) in
            self.dataToModel(type: .OrderAlipayPay, response: response, status: status, completion: completion)
        }
    }
    /// 获取订单列表
    ///
    /// - Parameter completion: completion description
    class func pull_fetchOrderListData(page:Int,user_id:String,type:String,completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Get(url: SJBRequestUrl.returnOrderListUrl(page:page,user_id: user_id,type: type)) { (response, status) in
            self.dataArrayToModel(type: .OrderList, response: response, status: status, completion: completion)
        }
    }
    /// 获取订单详情
    ///
    /// - Parameter completion: completion description
    class func pull_fetchOrderInfoData(id:String,user_id:String,completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Get(url: SJBRequestUrl.returnOrderInfoUrl(id: id, user_id: user_id)) { (response, status) in
            self.dataToModel(type: .OrderInfo, response: response, status: status, completion: completion)
        }
    }

    // MARK: ------ 个人信息
    /// 更换头像
    ///
    /// - Parameters:
    ///   - params: params description
    ///   - completion: completion description
    class func push_fetchChangePortraitData(image:UIImage, completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.UpLoad(url: SJBRequestUrl.returnChangePortraitUrl(), image: image) { (response, status) in
            completion(response,status)
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
    
    /// 修改用户信息
    ///
    /// - Parameters:
    ///   - params: params description
    ///   - completion: completion description
    class func push_fetchChangeUserInfoData(params:[String:AnyObject],completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Post(url:SJBRequestUrl.returnChangeUserInfoUrl(), params: params) { (response, status) in
            completion(response,status)

        }
        
    }

    class func push_fetchChangePasswordData(params:[String:AnyObject],completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Post(url: SJBRequestUrl.returnChangePasswordUrl(), params: params) { (response, status) in
            completion(response,status)
        }
    }
    // MARK: ------ 地址管理
    /// 地址分级
    ///
    /// - Parameters:
    ///   - level: level description
    ///   - parent_id: parent_id description
    ///   - completion: completion description
    class func pull_fetchAddressSection(level:Int, parent_id:Int,completion:@escaping (AnyObject,Int) -> Void){
        SJBRequest.Get(url: SJBRequestUrl.returnAddressMenuUrl(level: level, parent_id: parent_id)) { (response, status) in
            self.dataArrayToModel(type: .AddressSection, response: response, status: status, completion: completion)
        }
    }
    
    /// 添加地址
    ///
    /// - Parameters:
    ///   - params: params description
    ///   - completion: completion description
    class func push_fetchAddAddressData(params:[String:AnyObject],completion:@escaping (AnyObject,Int) -> Void){
        SJBRequest.Post(url: SJBRequestUrl.returnAddAddressUrl(), params: params) { (response, status) in
            self.dataArrayToModel(type: .AddAddRess, response: response, status: status, completion: completion)
        }
    }
    
    /// 地址列表
    ///
    /// - Parameter completion: completion description
    class func pull_fetchAddressListData(completion:@escaping (AnyObject,Int) -> Void){
        SJBRequest.Get(url: SJBRequestUrl.returnAddressListUrl()) { (response, status) in
            self.dataArrayToModel(type: .AddRessList, response: response, status: status, completion: completion)
        }
    }
    
    /// 删除地址
    ///
    /// - Parameters:
    ///   - params: params description
    ///   - completion: completion description
    class func push_fetchAddressDelData(params:[String:AnyObject],completion:@escaping (AnyObject,Int) -> Void){
        SJBRequest.Post(url: SJBRequestUrl.returnDelAddressUrl(), params: params) { (response, status) in
            self.dataArrayToModel(type: .DelAddress, response: response, status: status, completion: completion)
        }
    }

    // MARK: ------ 明细
    
    /// 消费明细
    ///
    /// - Parameter completion: completion description
    class func pull_fetchSellListData(page:Int,completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Get(url: SJBRequestUrl.returnSellListUrl(page: page)) { (response, status) in
            self.dataArrayToModel(type: .SellList, response: response, status: status, completion: completion)
        }
    }
    /// 奖金明细
    ///
    /// - Parameter completion: completion description
    class func pull_fetchBonusListData(page:Int,completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Get(url: SJBRequestUrl.returnBonusListUrl(page: page)) { (response, status) in
            self.dataArrayToModel(type: .BonusList, response: response, status: status, completion: completion)
        }
    }
    
    /// 提现记录
    ///
    /// - Parameters:
    ///   - page: page description
    ///   - completion: completion description
    class func pull_fetchWithdrawListData(page:Int,completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.GetAll(url: SJBRequestUrl.returnWithdrawListUrl(page: page)) { (response, status) in
            self.dataToModel(type: .WithdrawalsList, response: response, status: status, completion: completion)
        }
    }
    /// 提现处理
    ///
    /// - Parameters:
    ///   - page: page description
    ///   - completion: completion description
    class func push_fetchWithdrawalsData(params:[String:AnyObject],completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Post(url: SJBRequestUrl.returnWithdrawalsUrl(), params: params) { (response, status) in
            self.dataToModel(type: .Withdrawals, response: response, status: status, completion: completion)
        }
    }
    
    /// 奖金转金额
    ///
    /// - Parameters:
    ///   - params: params description
    ///   - completion: completion description
    class func push_fetchBonusToMoneyData(params:[String:AnyObject],completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.Post(url: SJBRequestUrl.returnBonusToMoneyUrl(), params: params) { (response, status) in
            self.dataToModel(type: .BonusToMoney, response: response, status: status, completion: completion)
        }
    }

    // MARK: ------ 二维码

    /// 分享二维码
    ///
    /// - Parameter completion: completion description
    class func pull_fetchQrCodeData(completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.GetAll(url: SJBRequestUrl.returnQrCodeUrl()) { (response, status) in
            self.dataToModel(type: .QrCode, response: response, status: status, completion: completion)
        }
    }
    
    // MARK: ------ 分享会员
    /// 分享会员
    ///
    /// - Returns: return value description
    class func pull_fetchShareMemberData(page:Int,completion:@escaping (AnyObject,Int) -> Void) {
        SJBRequest.GetAll(url: SJBRequestUrl.returnShareMemberUrl(page: page)) { (response, status) in
            self.dataToModel(type: .ShareMember, response: response, status: status, completion: completion)
        }
    }
}
