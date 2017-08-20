//
//  RequestUrl.swift
//  HNLYSJB
//
//  Created by jun on 2017/5/22.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
//let basePath = "http://test.kymart.cn/index.php?"
//let baseHref = "http://test.kymart.cn"
//let imgPath = "http://test.kymart.cn"
let basePath = "http://api.kymart.cn/index.php?"
let baseHref = "http://api.kymart.cn"
let imgPath = "http://api.kymart.cn"
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
    class func returnProductListUrl(url:String, page:Int) -> String {
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
    // MARK: ------ 分享区、促销区、秒杀区
    /// 获取首页分区商品列表
    ///
    /// - Parameter zid: zid description
    /// - Returns: return value description
    class func returnSectionProductListUrl(url:String) -> String {
        return "\(basePath)\(url)"
    }
    
    /// 分区获取更多
    ///
    /// - Returns: return value description
    class func returnSectionMoreProductListUrl(url:String,page:String) -> String {
        return "\(basePath)\(url)&p=\(page)"
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
    // MARK: ------ 订单
    /// 生成订单
    ///
    /// - Returns: return value description
    class func returnOrderUrl() -> String {
        return "\(basePath)m=Api&c=Cart&a=cart2&token=\(access_token())"

    }
    
    /// 订单金额信息
    ///
    /// - Returns: return value description
    class func returnOrderMoneyUrl() -> String {
        return "\(basePath)m=Api&c=Cart&a=cart3&token=\(access_token())"
    }
    /// 提交订单编号
    ///
    /// - Returns: return value description
    class func returnPostOrderIdUrl() -> String {
        return "\(basePath)m=Api&c=Cart&a=cart4&token=\(access_token())"
    }
    

    /// 订单列表
    ///
    /// - Returns: return value description
    class func returnOrderListUrl(page:Int,user_id:String,type:String) -> String {
        if type == "all" {
            return "\(basePath)m=Api&c=User&a=getOrderList&user_id=\(user_id)&p=\(page)&token=\(access_token())"
        }
        return "\(basePath)m=Api&c=User&a=getOrderList&user_id=\(user_id)&type=\(type)&p=\(page)&token=\(access_token())"
    }
    
    
    /// 订单详情
    ///
    /// - Parameters:
    ///   - id: id description
    ///   - user_id: user_id description
    ///   - type: type description
    /// - Returns: return value description
    class func returnOrderInfoUrl(id:String,user_id:String) -> String {
        return "\(basePath)m=Api&c=order&a=order_detail&user_id=\(user_id)&id=\(id)&token=\(access_token())"
    }
    
    /// 物流信息
    ///
    /// - Parameter user_id: user_id description
    /// - Returns: return value description
    class func returnOrderShipUrl(order_id:Int) -> String {
        return "\(basePath)m=Api&c=user&a=express&order_id=\(order_id)&token=\(access_token())"
    }
    /// 删除订单
    ///
    /// - Returns: return value description
    class func returnDelOrderUrl() -> String {
        return "\(basePath)m=Api&c=user&a=cancelOrder&token=\(access_token())"
    }
    
    /// 确认收货
    ///
    /// - Returns: return value description
    class func returnConfirmOrderUrl() -> String {
        return "\(basePath)m=Api&c=user&a=orderConfirm&token=\(access_token())"
    }
    // MARK: ------ 支付
    /// 微信支付
    ///
    /// - Returns: return value description
    class func returnWeiXinPayUrl() -> String {
        return "\(basePath)m=Api&c=wxpay&a=dopay&token=\(access_token())"
    }
    /// 支付宝支付
    ///
    /// - Returns: return value description
    class func returnAlipayPayUrl() -> String {
        return "\(basePath)m=Api&c=payment&a=alipay_sign&token=\(access_token())"
    }
    /// 快钱支付
    ///
    /// - Returns: return value description
    class func returnKuaiQianPayUrl(order_sn:String,user_id:String) -> String {
        return "\(baseHref)/index.php/api/payment/bill.html?order_sn=\(order_sn)&user_id=\(user_id)"
    }
    /// 微信充值
    ///
    /// - Returns: return value description
    class func returnWeiXinRechargeUrl() -> String {
        return "\(basePath)m=Api&c=wxpay&a=recharge"
    }
    /// 支付宝充值
    ///
    /// - Returns: return value description
    class func returnAlipayRechargeUrl() -> String {
        return "\(basePath)m=Api&c=payment&a=recharge_alipay"
    }
    /// 快钱充值
    ///
    /// - Returns: return value description
    class func returnKuaiQianRechargeUrl() -> String {
        return "\(basePath)m=Api&c=payment&a=recharge_bill"
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
    
    /// 更改用户信息
    ///
    /// - Returns: return value description
    class func returnChangeUserInfoUrl() -> String {
        return "\(basePath)m=api&c=User&a=updateUserInfo&unique_id=\(SingleManager.getUUID())&token=\(access_token())"
    }
    
    /// 修改密码
    ///
    /// - Returns: return value description
    class func returnChangePasswordUrl() -> String {
        return "\(basePath)m=api&c=User&a=password&unique_id=\(SingleManager.getUUID())&token=\(access_token())"
    }
    // MARK: ------ 明细
    /// 消费明细
    ///
    /// - Returns: return value description
    class func returnSellListUrl(page:Int) -> String {
        // sell_list 消费明细
        return "\(basePath)m=api&c=User&a=money_list&unique_id=\(SingleManager.getUUID())&token=\(access_token())&p=\(page)"
        
    }
    
    /// 奖金明细
    ///
    /// - Returns: return value description
    class func returnBonusListUrl(page:Int) -> String {
        // bonus_list 分享明细
        return "\(basePath)m=api&c=User&a=bonus_list&unique_id=\(SingleManager.getUUID())&token=\(access_token())&p=\(page)"
        
    }
    
    /// 提现记录
    ///
    /// - Returns: return value description
    class func returnWithdrawListUrl(page:Int) -> String {
        return "\(basePath)m=api&c=User&a=withdrawals_list&unique_id=\(SingleManager.getUUID())&token=\(access_token())&p=\(page)"
        
    }

    /// 提现处理
    ///
    /// - Returns: return value description
    class func returnWithdrawalsUrl() -> String {
        return "\(basePath)m=api&c=User&a=withdrawals&unique_id=\(SingleManager.getUUID())&token=\(access_token())"
        
    }
    /// 奖金转金额
    ///
    /// - Returns: return value description
    class func returnBonusToMoneyUrl() -> String {
        return "\(basePath)m=api&c=User&a=changebonus&unique_id=\(SingleManager.getUUID())&token=\(access_token())"
    }

    // MARK: ------ 分享二维码
    /// 二维码
    ///
    /// - Returns: return value description
    class func returnQrCodeUrl() -> String {
        return "\(basePath)m=api&c=User&a=qr_code&token=\(access_token())"
        
    }
    // MARK: ------ 分享会员
    /// 分享会员
    ///
    /// - Returns: return value description
    class func returnShareMemberUrl(page:Int) -> String {
        return "\(basePath)m=api&c=User&a=lower_list&level=1&token=\(access_token())&p=\(page)"
        
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
    
    /// 设置默认地址
    ///
    /// - Returns: return value description
    class func returnDefaultAddressUrl() -> String {
        return "\(basePath)m=api&c=user&a=setDefaultAddress&token=\(access_token())"
    }
}
