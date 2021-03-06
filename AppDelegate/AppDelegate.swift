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
                    var registrationID = ""
                    if UserDefaults.standard.object(forKey: "registrationID") != nil
                    {
                        registrationID = UserDefaults.standard.object(forKey: "registrationID") as! String
                    }

                    let params = ["username":account!, "password":password!, "unique_id":SingleManager.getUUID(), "capache":verifycode, "push_id":registrationID]
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
        //极光推送
        if #available(iOS 10.0, *){
            let entiity = JPUSHRegisterEntity()
            entiity.types = Int(UNAuthorizationOptions.alert.rawValue |
                UNAuthorizationOptions.badge.rawValue |
                UNAuthorizationOptions.sound.rawValue)
            JPUSHService.register(forRemoteNotificationConfig: entiity, delegate: self)
        } else if #available(iOS 8.0, *) {
            let types = UIUserNotificationType.badge.rawValue |
                UIUserNotificationType.sound.rawValue |
                UIUserNotificationType.alert.rawValue
            JPUSHService.register(forRemoteNotificationTypes: types, categories: nil)
        }else {
            let type = UIRemoteNotificationType.badge.rawValue |
                UIRemoteNotificationType.sound.rawValue |
                UIRemoteNotificationType.alert.rawValue
            JPUSHService.register(forRemoteNotificationTypes: type, categories: nil)
        }
        //推送初始化
        JPUSHService.setup(withOption: launchOptions, appKey: "d9055d012c5556b5ac97a95b", channel: "App Store", apsForProduction: true)
        JPUSHService.registrationIDCompletionHandler { (resCode, registrationID) in
            if resCode == 0{
                //获取registrationID成功
                UserDefaults.standard.setValue(registrationID, forKey: "registrationID")
            }
            else
            {
                //获取registrationID失败

            }
        }
        // 获取推送消息
        let remote = launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] as? Dictionary<String,Any>;
        // 如果remote不为空，就代表应用在未打开的时候收到了推送消息
        if remote != nil {
            // 收到推送消息实现的方法
            self.perform(#selector(receivePush), with: remote, afterDelay: 1.0);
        }
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
extension AppDelegate:JPUSHRegisterDelegate{
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        JPUSHService.registerDeviceToken(deviceToken)
        print("Notification token: ", NSString(data:deviceToken ,encoding: String.Encoding.utf8.rawValue) ?? "1234")
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("did Fail To Register For Remote Notifications With Error: %@", error);
        
    }
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        //iOS10后台打开消息
        let userinfo = response.notification.request.content.userInfo
        print(userinfo)
        if (response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.classForCoder()))! {
            JPUSHService.handleRemoteNotification(userinfo)
            UIApplication.shared.applicationIconBadgeNumber -= 1
            FJJPushUtil.jpushMessageManagerBackground(userInfo: userinfo, appdelegate: self)
        }
        completionHandler()
    }
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        //iOS10前台收到消息
        let userinfo = notification.request.content.userInfo
        print(userinfo)
        if (notification.request.trigger?.isKind(of: UNPushNotificationTrigger.classForCoder()))! {
            JPUSHService.handleRemoteNotification(userinfo)
            FJJPushUtil.jpushMessageManagerForeground(userInfo: userinfo, appdelegate: self)
        }
        completionHandler(Int(UNNotificationPresentationOptions.alert.rawValue))
        
    }
    //iOS7及以上系统，收到通知
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        //前台收到消息执行，后台消息点击执行
        JPUSHService.handleRemoteNotification(userInfo);
        print(userInfo);
        let dic = userInfo as NSDictionary
        print(dic.yy_modelToJSONString() ?? "")
        if ( application.applicationState == .active) {
            // 程序在运行过程中受到推送通知
            print("前台")
            
            FJJPushUtil.jpushMessageManagerForeground(userInfo: userInfo, appdelegate: self)

            
        } else {
            //在background状态受到推送通知
            print("后台")
            UIApplication.shared.applicationIconBadgeNumber -= 1
            FJJPushUtil.jpushMessageManagerBackground(userInfo: userInfo, appdelegate: self)

            
        }

        completionHandler(UIBackgroundFetchResult.newData);
    }
    //iOS6及以下系统，收到通知
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        JPUSHService.handleRemoteNotification(userInfo);
        if ( application.applicationState == .active) {
            // 程序在运行过程中受到推送通知
            print("前台")
            FJJPushUtil.jpushMessageManagerForeground(userInfo: userInfo, appdelegate: self)

            
        } else {
            //在background状态受到推送通知
            print("后台")
            UIApplication.shared.applicationIconBadgeNumber -= 1
            FJJPushUtil.jpushMessageManagerBackground(userInfo: userInfo, appdelegate: self)

            
        }
    }
    // 接收到推送实现的方法
    func receivePush(_ userInfo : Dictionary<String,Any>) {
        print("收到推送")
        // 角标变0
        //        UIApplication.shared.applicationIconBadgeNumber = 0;
        //        // 剩下的根据需要自定义
        //        self.tabBarVC?.selectedIndex = 0;
        //        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationName_ReceivePush), object: NotificationObject_Sueecess, userInfo: userInfo)
    }

}
