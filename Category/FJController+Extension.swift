//
//  Controller+Extension.swift
//  HNLYSJB
//
//  Created by jun on 2017/5/23.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import PopupDialog
extension BaseViewController{
    /// 导航栏返回按钮
    ///
    /// - Parameters:
    ///   - imageUrl: imageUrl description
    ///   - action: action description
    func setBackButtonInNav() {
        let image = UIImage(named: "nav_back.png")
        let backBtn = UIButton(type: UIButtonType.custom)
        backBtn.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        backBtn.addTarget(self, action: #selector(goback), for: UIControlEvents.touchUpInside)
        backBtn.setImage(image, for: UIControlState.normal)
        let item = UIBarButtonItem(customView: backBtn)
        navigationItem.leftBarButtonItem = item
    }

    /// 导航栏左侧按钮
    ///
    /// - Parameters:
    ///   - imageUrl: imageUrl description
    ///   - action: action description
    func setLeftButtonInNav(imageUrl: String, action: Selector) {
        let image = UIImage(named: imageUrl)
        let backBtn = UIButton(type: UIButtonType.custom)
        backBtn.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        backBtn.addTarget(self, action: action, for: UIControlEvents.touchUpInside)
        backBtn.setImage(image, for: UIControlState.normal)
        let item = UIBarButtonItem(customView: backBtn)
        navigationItem.leftBarButtonItem = item
    }
    /// 导航栏右侧按钮
    ///
    /// - Parameters:
    ///   - imageUrl: imageUrl description
    ///   - action: action description
    func setRightButtonInNav(imageUrl: String, action: Selector) {
        let image = UIImage(named: imageUrl)
        let backBtn = UIButton(type: UIButtonType.custom)
        backBtn.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        backBtn.addTarget(self, action: action, for: UIControlEvents.touchUpInside)
        backBtn.setImage(image, for: UIControlState.normal)
        let item = UIBarButtonItem(customView: backBtn)
        navigationItem.rightBarButtonItem = item
    }
    /// 导航栏右侧按钮(无图)
    ///
    /// - Parameters:
    ///   - title: imageUrl description
    ///   - action: action description
    func setRightButtonInNav(title: String, action: Selector, size:CGSize?) {
        let backBtn = UIButton(type: UIButtonType.custom)
        let point = CGPoint(x: 0, y: 0)
        backBtn.frame = CGRect(origin: point, size: CGSize(width: 24, height: 24))
        if size != nil {
            backBtn.frame = CGRect(origin: point, size: size!)
        }
        backBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        backBtn.addTarget(self, action: action, for: UIControlEvents.touchUpInside)
        backBtn.setTitle(title, for: .normal)
        let item = UIBarButtonItem(customView: backBtn)
        navigationItem.rightBarButtonItem = item
    }
    
    /// 提示弹窗
    ///
    /// - Parameters:
    ///   - content: content description
    ///   - sure: sure description
    ///   - cancel: cancel description
    func popupDialog(content:String,sure:@escaping () -> Void,cancel:@escaping () -> Void) {
        // Prepare the popup
        let title = "提  示"
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
        self.present(popup, animated: true, completion: nil)
    }
    
    /// 提示弹窗
    ///
    /// - Parameters:
    ///   - content: content description
    ///   - cancelTitle: cancelTitle description
    ///   - sureTitle: sureTitle description
    ///   - sure: sure description
    ///   - cancel: cancel description
    func popupDialog(content:String,cancelTitle:String,sureTitle:String,sure:@escaping () -> Void,cancel:@escaping () -> Void) {
        // Prepare the popup
        let title = "提  示"
        // Create the dialog
        let popup = PopupDialog(title: title, message: content, buttonAlignment: .horizontal, transitionStyle: .zoomIn, gestureDismissal: true) {
            
        }
        
        // Create first button
        let buttonOne = CancelButton(title: cancelTitle) {
            cancel()
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: sureTitle) {
            sure()
        }
        buttonTwo.titleColor = BAR_TINTCOLOR
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        self.present(popup, animated: true, completion: nil)
    }
    
}
