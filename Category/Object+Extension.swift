//
//  Object+Extension.swift
//  HNLYSJB
//
//  Created by jun on 2017/5/23.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
extension NSObject{
    /// 信息提示
    ///
    /// - Parameter content: content description
    func Toast(content:String) {
        XHToast.showBottomWithText(content, duration: 0.2)
    }
}
