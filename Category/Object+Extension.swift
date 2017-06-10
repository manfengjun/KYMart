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
        XHToast.showBottomWithText(content, duration: 1)
    }
    /// 信息提示
    ///
    /// - Parameter content: content description
    func Toast(content:String,duration:CGFloat) {
        XHToast.showBottomWithText(content, duration: duration)
    }}
// MARK: ------ 输入合法性验证
extension NSObject{
    enum ValidatedType {
        case Email
        case PhoneNumber
        case PassWord
        case Number
    }
    
    
    /// 正则匹配
    ///
    /// - Parameters:
    ///   - type: type description
    ///   - validateString: validateString description
    /// - Returns: return value description
    func ValidateText(validatedType type: ValidatedType, validateString: String) -> Bool {
        if validateString.characters.count <= 0 {
            return false
        }
        do {
            var pattern: String?
            if type == ValidatedType.Email {
                pattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
                
            }
            else if type == ValidatedType.PhoneNumber{
                pattern = "1[3|5|7|8|][0-9]{9}"
                
            }
            else if type == ValidatedType.PassWord{
                pattern = "^\\w+$"
            }
            else if type == ValidatedType.Number{
                pattern = "^[0-9]*$"
            }
            let regex: NSRegularExpression = try NSRegularExpression(pattern: pattern!, options: NSRegularExpression.Options.caseInsensitive)
            let matches = regex.matches(in: validateString, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, validateString.characters.count))
            return matches.count > 0
        }
        catch {
            return false
        }
    }
    
    /// 邮箱
    ///
    /// - Parameter text: text description
    /// - Returns: return value description
    func EmailIsValidated(text: String) -> Bool {
        return ValidateText(validatedType: ValidatedType.Email, validateString: text)
    }
    
    /// 密码
    ///
    /// - Parameter text: text description
    /// - Returns: return value description
    func PassWordIsValidated(text: String) -> Bool {
        return ValidateText(validatedType: ValidatedType.PassWord, validateString: text)
    }
    func NumberIsVailidated(text: String) -> Bool {
        return ValidateText(validatedType: ValidatedType.Number, validateString: text)
    }
    /// 非空
    ///
    /// - Parameter text: text description
    /// - Returns: return value description
    func ContentIsValidated(text: String) -> Bool {
        return text.characters.count > 0 ? true : false
    }
    
    /// 手机号
    ///
    /// - Parameter text: text description
    /// - Returns: return value description
    func PhoneNumberIsValidated(text: String) -> Bool {
        if text.characters.count > 11 {
            return false
        }
        return ValidateText(validatedType: ValidatedType.PhoneNumber, validateString: text)
    }
    
}
