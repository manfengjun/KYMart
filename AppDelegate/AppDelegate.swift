//
//  AppDelegate.swift
//  KYMart
//
//  Created by jun on 2017/6/1.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import YYCache
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,WXApiDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.backgroundColor = UIColor.white
//        window?.makeKeyAndVisible()
////        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let rootVC = DemoViewController()
//        window?.rootViewController = rootVC
        CitiesDataTool.sharedManager().requestGetData()
        let cache = YYCache(name: "KYMart")
        if let data = cache?.object(forKey: "loginInfo")
        {
            /// 本地
            SingleManager.instance.loginInfo = data as? KYLoginInfoModel

            SJBRequestModel.pull_fetchVerifyCodeData { (response, status) in
                if status == 1 {
                    let verifycode = response as! String
                    let account = SingleManager.instance.loginInfo?.mobile
                    let password = SingleManager.instance.loginInfo?.password
                    let params = ["username":account!, "password":password!, "unique_id":SingleManager.getUUID(), "capache":verifycode, "push_id":""]
                    SJBRequestModel.push_fetchLoginData(params: params as [String : AnyObject], completion: { (response, status) in
                        if status == 1{
                            SingleManager.instance.loginInfo = response as? KYLoginInfoModel
                            print("token=\(String(describing: SingleManager.instance.loginInfo?.token))")
                            print("uuid=\(SingleManager.getUUID())")
                            SingleManager.instance.loginInfo?.password = password
                            SingleManager.instance.isLogin = true
                            let cache = YYCache(name: "KYMart")
                            cache?.setObject(SingleManager.instance.loginInfo, forKey: "loginInfo")
                            
                        }
                    })
                }
            }

        }
        //微信支付
        WXApi.registerApp("wxcf54c829295655ba")
        //键盘
        setupIQKeyboardManager()
        //友盟分享
        FJUmSocialUtil.instance.setup()

        return true
    }
    /// 微信支付
    ///
    /// - Parameter resp: resp description
    
    func onResp(_ resp: BaseResp!) {
        if resp is PayResp {
            switch resp.errCode {
            case 0:
                NotificationCenter.default.post(name:WeiXinPayNotification, object: nil)
                break
            default:
                Toast(content: "支付失败")
                break
            }
        }
    }
    /// 键盘管理
    func setupIQKeyboardManager() {
        let manager = IQKeyboardManager.sharedManager()
        manager.enable = false
        manager.shouldResignOnTouchOutside = true
        manager.enableAutoToolbar = false
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let result = UMSocialManager.default().handleOpen(url, options: options)
        if !result {
            if url.host == "safepay" {
                AlipaySDK.defaultService().processOrder(withPaymentResult: url, standbyCallback: { (result) in
                    print(result ?? "result")
                })
            }
            else{
                //微信回调
                WXApi.handleOpen(url, delegate: self)
            }
        }
        return result
    }
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        let result = UMSocialManager.default().handleOpen(url)
        if !result {
            if url.host == "safepay" {
                AlipaySDK.defaultService().processOrder(withPaymentResult: url, standbyCallback: { (result) in
                    print(result ?? "result")
                    
                })
            }
            else{
                //微信回调
                WXApi.handleOpen(url, delegate: self)
            }
        }
        return result
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

