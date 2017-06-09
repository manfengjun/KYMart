//
//  SJBCountDown.swift
//  HNLYSJB
//
//  Created by jun on 2017/6/5.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class SJBCountDown: NSObject {
    var codeBtn:UIButton?
    /// 计数器
    var remainingSeconds : Int = 0 {
        willSet {
            codeBtn?.setTitle("重新发送(\(newValue)s)", for: .normal)
            codeBtn?.setTitleColor(UIColor.lightGray, for: .normal)
            if newValue <= 0 {
                codeBtn?.setTitle("获取验证码", for: .normal)
                codeBtn?.setTitleColor(UIColor.hexStringColor(hex: "#007AFF"), for: .normal)
                isCounting = false
            }
        }
    }
    
    /// 定时器
    var countdownTimer : Timer?
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime(timer:)), userInfo: nil, repeats: true)
                remainingSeconds = 60
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
            }
            codeBtn?.isEnabled = !newValue
            
        }
    }
    init(button:UIButton) {
        super.init()
        codeBtn = button
    }
    func updateTime(timer: Timer) {
        remainingSeconds -= 1
    }
}
