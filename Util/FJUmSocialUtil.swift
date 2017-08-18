//
//  UMSocialUtil.swift
//  FJOAuth
//
//  Created by jun on 2017/7/10.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import SDWebImage
/// 友盟AppID
let UMSocialAppKey = "59925fc0734be4098a00007e"
/// 微信AppID
let WeChatAppKey = "wxcf54c829295655ba"
let WeChatAppSecret = "2e1ab0bef224a0e149e35fff1f6979ee"
/// QQ AppID
let QQAppID = "1106145757"
let QQAppKey = "EET6qPviK5XKeTwh"
///// 微博 AppID
//let SigaAppKey = "1851014210"
//let SigaAppSecret = "ff018316f48f5208d9190f16172aefbe"
//let RedirectURLAppSecret = "https://sns.whalecloud.com/sina2/callback"
class FJUmSocialUtil: NSObject {
    /// 单例
    static let instance = FJUmSocialUtil()
    func setup() {
        UMSocialManager.default().openLog(true)
        UMSocialManager.default().umSocialAppkey = UMSocialAppKey
        configUSharePlatforms()
        confitUShareSettings()
    }
    /// 第三方AppID
    func configUSharePlatforms() {
        // 微信
        UMSocialManager.default().setPlaform(.wechatSession, appKey: WeChatAppKey, appSecret: WeChatAppSecret, redirectURL: nil)
        // QQ
        UMSocialManager.default().setPlaform(.QQ, appKey: QQAppID, appSecret: nil, redirectURL: nil)
//        // 新浪微博
//        UMSocialManager.default().setPlaform(.sina, appKey: SigaAppKey, appSecret: SigaAppSecret, redirectURL: RedirectURLAppSecret)
    }
    
    /// 友盟设置
    func confitUShareSettings() {
        
    }
    
}

// MARK: - 分享面板
extension FJUmSocialUtil{
    
    class func setupShareMenu(completion:@escaping (UMSocialPlatformType,[AnyHashable : Any]?) -> Void) {
        UMSocialUIManager.setPreDefinePlatforms([NSNumber(integerLiteral:UMSocialPlatformType.wechatSession.rawValue),NSNumber(integerLiteral:UMSocialPlatformType.QQ.rawValue),NSNumber(integerLiteral:UMSocialPlatformType.wechatTimeLine.rawValue)
            ]
        )
        UMSocialUIManager.showShareMenuViewInWindow { (platformType, userInfo) in
            completion(platformType,userInfo)
        }
    }
}
extension FJUmSocialUtil{
    
    /// 微信登录
    ///
    /// - Parameter completion: completion description
    class func getAuthWithUserInfoFromWechat(completion:@escaping (AnyObject,Bool) -> Void) {
        UMSocialManager.default().getUserInfo(with: .wechatSession, currentViewController: nil) { (result, error) in
            if error == nil {
                let resp = result as! UMSocialUserInfoResponse
                completion(resp, true)
                
            }
            else
            {
                completion("授权失败！" as AnyObject, false)
            }
        }
    }
    
    /// 新浪登录
    ///
    /// - Parameter completion: completion description
    class func getAuthWithUserInfoFromSina(completion:@escaping (AnyObject,Bool) -> Void) {
        UMSocialManager.default().getUserInfo(with: .sina, currentViewController: nil) { (result, error) in
            if error == nil {
                let resp = result as! UMSocialUserInfoResponse
                completion(resp, true)
                
            }
            else
            {
                completion("授权失败！" as AnyObject, false)
            }
        }
    }
    
    /// QQ登录
    ///
    /// - Parameter completion: completion description
    class func getAuthWithUserInfoFromQQ(completion:@escaping (AnyObject,Bool) -> Void) {
        UMSocialManager.default().getUserInfo(with: .QQ, currentViewController: nil) { (result, error) in
            if error == nil {
                let resp = result as! UMSocialUserInfoResponse
                completion(resp, true)
                
            }
            else
            {
                completion("授权失败！" as AnyObject, false)
            }
        }
    }
}
// MARK: - 分享（文本、图片、卡片链接）
extension FJUmSocialUtil{
    /// 单文本分享
    ///
    /// - Parameters:
    ///   - platformType: platformType description
    ///   - image: image description
    class func shareTextToPlatformType(platformType:UMSocialPlatformType,message:String) {
        let messageObject = UMSocialMessageObject()
        
        messageObject.text = message
        UMSocialManager.default().share(to: platformType, messageObject: messageObject, currentViewController: nil) { (data, error) in
            if ((error) != nil){
                Toast(content: "分享失败")
                
            }else
            {
                Toast(content: "分享成功")
            }
        }
    }
    /// 单图分享
    ///
    /// - Parameters:
    ///   - platformType: platformType description
    ///   - image: image description
    class func shareImageToPlatformType(platformType:UMSocialPlatformType,image:AnyObject) {
        let messageObject = UMSocialMessageObject()
        let shareObject = UMShareImageObject()
        
        shareObject.shareImage = image
        messageObject.shareObject = shareObject
        UMSocialManager.default().share(to: platformType, messageObject: messageObject, currentViewController: nil) { (data, error) in
            if ((error) != nil){
                Toast(content: "分享失败")
                
            }else
            {
                Toast(content: "分享成功")
            }
        }
    }
    
    /// 微博分享图文链接
    ///
    /// - Parameters:
    ///   - descr: descr description
    ///   - thumImage: thumImage description
    ///   - url: url description
    class func shareSinaToPlatformType(descr:String,thumImage:AnyObject,url:String) {
        let messageObject = UMSocialMessageObject()
        messageObject.text = descr + url
        let shareObject = UMShareImageObject()
        
        shareObject.shareImage = thumImage
        
        messageObject.shareObject = shareObject
        UMSocialManager.default().share(to: .sina, messageObject: messageObject, currentViewController: nil) { (data, error) in
            if ((error) != nil){
                Toast(content: "分享失败")
                
            }else
            {
                Toast(content: "分享成功")
            }
        }
    }

    /// 卡片链接分享（6.0微博分享失败未找到问题）
    ///
    /// - Parameters:
    ///   - platformType: platformType description
    ///   - title: title description
    ///   - descr: descr description
    ///   - thumImage: thumImage description
    ///   - url: url description
    class func shareWebPageToPlatformType(platformType:UMSocialPlatformType,title:String,descr:String,thumImage:AnyObject,url:String) {
        SDWebImageManager.shared().loadImage(with: URL(string:thumImage as! String), options: .highPriority, progress: nil) { (image, data, error, cacheType, finished, imageURL) in
            let messageObject = UMSocialMessageObject()
            let shareObject = UMShareWebpageObject.shareObject(withTitle: title, descr: descr, thumImage: image)
            
            shareObject?.webpageUrl = url
            
            messageObject.shareObject = shareObject
            UMSocialManager.default().share(to: platformType, messageObject: messageObject, currentViewController: nil) { (data, error) in
                if ((error) != nil){
                    Toast(content: "分享失败")
                    
                }else
                {
                    Toast(content: "分享成功")
                }
            }

        }
    }

}
 
