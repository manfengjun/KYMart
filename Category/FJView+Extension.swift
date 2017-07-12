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
    
    /// 获得当前视图控制器
    ///
    /// - Returns: return value description
    func getCurrentController() -> UIViewController? {
        
        guard let window = UIApplication.shared.windows.first else {
            return nil
        }
        
        var tempView: UIView?
        
        for subview in window.subviews.reversed() {
            
            
            if subview.classForCoder.description() == "UILayoutContainerView" {
                
                tempView = subview
                
                break
            }
        }
        
        if tempView == nil {
            
            tempView = window.subviews.last
        }
        
        var nextResponder = tempView?.next
        
        var next: Bool {
            return !(nextResponder is UIViewController) || nextResponder is UINavigationController || nextResponder is UITabBarController
        }
        
        while next{
            
            tempView = tempView?.subviews.first
            
            if tempView == nil {
                
                return nil
            }
            
            nextResponder = tempView!.next
        }
        
        return nextResponder as? UIViewController
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
