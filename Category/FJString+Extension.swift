//
//  String+Extension.swift
//  BaoKanIOS
//
//  Created by jianfeng on 16/2/22.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import Foundation

extension String {
    
    
    /// 自适应宽度
    ///
    /// - Parameter size: size description
    func widthForsize(size:CGSize,font:CGFloat) -> CGFloat{
        let attrbute = [NSFontAttributeName:UIFont.systemFont(ofSize: font)]
        let nsStr = NSString(string: self)
        return nsStr.boundingRect(with: size, options: [.usesLineFragmentOrigin,.usesFontLeading,.truncatesLastVisibleLine], attributes: attrbute, context: nil).size.width
    }
    /**
     时间戳转为时间
     
     - returns: 时间字符串
     */
    func timeStampToString() -> String {
        
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd"
        let string = NSString(string: self)
        let timeSta: TimeInterval = string.doubleValue
        let date = Date(timeIntervalSince1970: timeSta)
        let dateStr = dfmatter.string(from: date)
        return dateStr
    }
    /// md5
    ///
    /// - Returns: md5加密后的字符串
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize()
        
        return String(format: hash as String)
    }

}
