//
//  View+Extension.swift
//  HNLYSJB
//
//  Created by jun on 2017/6/1.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

extension UIView{
    
    /// 获取视图底部Y坐标
    ///
    /// - Returns: return value description
    func bottom() -> CGFloat {
        return self.frame.origin.y + self.frame.size.height
    }
    ///
    ///
    /// - Returns: return value description
    func height() -> CGFloat {
        return self.frame.size.height
    }
    ///
    ///
    /// - Returns: return value description
    func width() -> CGFloat {
        return self.frame.size.height
    }

}
extension CGRect{
    /// 获取底部Y坐标
    ///
    /// - Returns: return value description
    func bottom() -> CGFloat {
        return self.origin.y + self.size.height
    }
}
