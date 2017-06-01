//
//  Controller+Extension.swift
//  HNLYSJB
//
//  Created by jun on 2017/5/23.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
extension UIViewController{
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
    
    /// 返回
    func goback() {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        }
        else
        {
            dismiss(animated: true, completion: nil)
        }
    }

}
