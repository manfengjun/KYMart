//
//  FJJPushUtil.swift
//  KYMart
//
//  Created by jun on 2017/9/5.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import PopupDialog
class FJJPushUtil: NSObject {
    //推送类型
    var type:String?
    //推送数据id
    var id:String?

    
    /// 前台收到通知
    ///
    /// - Parameter userInfo: userInfo description
    func jpushMessageManagerForeground(userInfo: [AnyHashable : Any],appdelegate:AppDelegate){
        let model = FJJPushModel.yy_model(with: userInfo)
        let currentController = appdelegate.window?.rootViewController
        self.jpushAlert(target: currentController!, content: (model?.aps.alert)!, sure: {
        }) {

        }
    }
    
    /// 后台收到通知
    ///
    /// - Parameter userInfo: userInfo description
    func jpushMessageManagerBackground(userInfo: [AnyHashable : Any],appdelegate:AppDelegate){
        let model = FJJPushModel.yy_model(with: userInfo)
        var currentController = appdelegate.window?.rootViewController

    }
    
    /// 前台收到通知弹窗
    ///
    /// - Parameters:
    ///   - content: content description
    ///   - sure: sure description
    ///   - cancel: cancel description
    func jpushAlert(target:UIViewController,content:String,sure:@escaping () -> Void,cancel:@escaping () -> Void) {
        // Prepare the popup
        let title = "通  知"
        // Create the dialog
        let popup = PopupDialog(title: title, message: content, buttonAlignment: .horizontal, transitionStyle: .zoomIn, gestureDismissal: true) {
            
        }
        
        // Create first button
        let buttonOne = CancelButton(title: "取消") {
            cancel()
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "确定") {
            sure()
        }
        buttonTwo.titleColor = BAR_TINTCOLOR
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        target.present(popup, animated: true, completion: nil)
    }

}
