//
//  Request.swift
//  HNLYSJB
//
//  Created by jun on 2017/5/22.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import Alamofire
extension NSObject{
    }
class SJBRequest: NSObject {
    class func Get(url:String, completion:@escaping (AnyObject,Int) -> Void) {
        Alamofire.request(url).responseJSON { response in
            //            print(response.request ?? "request")  // original URL request
            //            print(response.response ?? "response") // HTTP URL response
            //            print(response.data ?? "data")     // server data
            //            print(response.result)   // result of response serialization
            if let JSON = response.result.value {
                let responseDic = JSON as! NSDictionary
                if let status = responseDic["status"] {
                    if status as! Int == 1 {
                        completion(responseDic["result"] as AnyObject,status as! Int)
                    }
                    else
                    {
                        XHToast.showBottomWithText("请求失败！")
                        completion(responseDic["msg"] as AnyObject,status as! Int)
                    }

                }
                else
                {
                    XHToast.showBottomWithText("请求失败！")
                    completion("error" as AnyObject,500)
                }
            }
            else
            {
                XHToast.showBottomWithText("请求失败！")
                completion("error" as AnyObject,500)
            }
        }
    }
    class func Post(url:String, params:[String:AnyObject]?, completion:@escaping (AnyObject,Int) -> Void) {
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response) in
            if let JSON = response.result.value {
                let responseDic = JSON as! NSDictionary
                if let status = responseDic["status"] {
                    if status as! Int == 1 {
                        completion(responseDic["result"] as AnyObject,status as! Int)
                    }
                    else
                    {
                        
                        completion(responseDic["msg"] as AnyObject,status as! Int)
                    }
                    
                }
                else
                {
                    XHToast.showBottomWithText("请求失败！")
                    completion("error" as AnyObject,500)
                }
            }
            else
            {
                XHToast.showBottomWithText("请求失败！")
                completion("error" as AnyObject,500)
            }
        }
    }

}
