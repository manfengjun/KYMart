//
//  Request.swift
//  HNLYSJB
//
//  Created by jun on 2017/5/22.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
extension NSObject{
}
class SJBRequest: NSObject {
    class func Get(url:String, completion:@escaping (AnyObject,Int) -> Void) {
        print("Get请求 ------ \(url)")
        
        Alamofire.request(url).responseJSON { response in
            if let JSON = response.result.value {
                let responseDic = JSON as! NSDictionary
                if let status = responseDic["status"] {
                    if status as! Int == 1 {
                        completion(responseDic["result"] as AnyObject,status as! Int)
                    }
                    else
                    {
                        if status as! Int == -101 || status as! Int == -102{
                            SingleManager.instance.isLogin = false
                            presentLogin()
                        }
                        else {
                            XHToast.showBottomWithText(responseDic["msg"] as! String)
                            completion(responseDic["msg"] as AnyObject,status as! Int)
                        }
                    }
                }
                else
                {
                    XHToast.showBottomWithText("请求失败！",duration:1)
                    completion("error" as AnyObject,500)
                }
            }
            else
            {
                XHToast.showBottomWithText("请求失败！",duration:1)
                completion("error" as AnyObject,500)
            }
        }
    }
    class func GetAll(url:String, completion:@escaping (AnyObject,Int) -> Void) {
        print("Get请求 ------ \(url)")
        
        Alamofire.request(url).responseJSON { response in
            if let JSON = response.result.value {
                let responseDic = JSON as! NSDictionary
                if let status = responseDic["status"] {
                    if status as! Int == 1 {
                        completion(responseDic as AnyObject,status as! Int)
                    }
                    else
                    {
                        if status as! Int == -101 || status as! Int == -102{
                            SingleManager.instance.isLogin = false
                            presentLogin()
                        }
                        else {
                            XHToast.showBottomWithText(responseDic["msg"] as! String)
                            completion(responseDic["msg"] as AnyObject,status as! Int)
                        }
                    }
                }
                else
                {
                    XHToast.showBottomWithText("请求失败！",duration:1)
                    completion("error" as AnyObject,500)
                }
            }
            else
            {
                XHToast.showBottomWithText("请求失败！",duration:1)
                completion("error" as AnyObject,500)
            }
        }
    }
    class func Post(url:String, params:[String:AnyObject]?, completion:@escaping (AnyObject,Int) -> Void) {
        print("Post请求 ------ \(url)     Params: \(String(describing: params))")

        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            ///101 token失效
            if let JSON = response.result.value {
                let responseDic = JSON as! NSDictionary
                if let status = responseDic["status"] {
                    if status as! Int == 1 {
                        completion(responseDic["result"] as AnyObject,status as! Int)
                    }
                    else
                    {
                        if status as! Int == -101 || status as! Int == -102{
                            SingleManager.instance.isLogin = false
                            presentLogin()
                        }
                        else
                        {
                            completion(responseDic["msg"] as AnyObject,status as! Int)
                            XHToast.showBottomWithText(responseDic["msg"] as! String,duration:1)

                        }
                    }
                    
                }
                else
                {
                    XHToast.showBottomWithText("请求失败！",duration:1)
                    completion("error" as AnyObject,500)
                }
            }
            else
            {
                XHToast.showBottomWithText("请求失败！",duration:1)
                completion("error" as AnyObject,500)
            }
        }
    }
    class func PostAll(url:String, params:[String:AnyObject]?, completion:@escaping (AnyObject,Int) -> Void) {
        print("Post请求 ------ \(url)     Params: \(String(describing: params))")
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            ///101 token失效
            if let JSON = response.result.value {
                let responseDic = JSON as! NSDictionary
                if let status = responseDic["status"] {
                    if status as! Int == 1 {
                        completion(responseDic as AnyObject,status as! Int)
                    }
                    else
                    {
                        if status as! Int == -101 || status as! Int == -102{
                            SingleManager.instance.isLogin = false
                            presentLogin()
                        }
                        else
                        {
                            completion(responseDic["msg"] as AnyObject,status as! Int)
                            
                        }
                    }
                    
                }
                else
                {
                    XHToast.showBottomWithText("请求失败！",duration:1)
                    completion("error" as AnyObject,500)
                }
            }
            else
            {
                XHToast.showBottomWithText("请求失败！",duration:1)
                completion("error" as AnyObject,500)
            }
        }
    }
    /// 上传图片
    ///
    /// - Parameters:
    ///   - url: url description
    ///   - image: image description
    ///   - completion: completion description
    class func UpLoad(url:String, image:UIImage, completion:@escaping (AnyObject,Int) -> Void) {
        // When
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            //设置时间显示样式
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale.current //设置时区，时间为当前系统时间
            //输出样式
            dateFormatter.dateFormat = "yyyyMMddHHmmss"
            let stringDate = dateFormatter.string(from: Date())
            multipartFormData.append(UIImageJPEGRepresentation(image, 1)!, withName: "head_pic", fileName: "\(stringDate).jpeg", mimeType: "image/jpeg")
        }, to:url)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print(progress.fractionCompleted)
                    SVProgressHUD.showProgress(Float(progress.fractionCompleted))
                })
                
                upload.responseJSON { response in
                    SVProgressHUD.dismiss()
                    if let JSON = response.result.value {
                        let responseDic = JSON as! NSDictionary
                        if let status = responseDic["status"] {
                            if status as! Int == 1 {
                                completion(responseDic["result"] as AnyObject,status as! Int)
                            }
                            else
                            {
                                if status as! Int == 101{
                                    SingleManager.instance.isLogin = false
                                    
                                }
                                else
                                {
                                    completion(responseDic["msg"] as AnyObject,status as! Int)
                                    
                                }
                            }
                            
                        }
                        else
                        {
                            XHToast.showBottomWithText("请求失败！",duration:1)
                            completion("error" as AnyObject,500)
                        }
                    }
                    else
                    {
                        XHToast.showBottomWithText("请求失败！",duration:1)
                        completion("error" as AnyObject,500)
                    }

                }
                
            case .failure( _):
                XHToast.showBottomWithText("上传失败！",duration:1)
                completion("error" as AnyObject,500)
            }
        }
    }
    /// 上传图片（多张）
    ///
    /// - Parameters:
    ///   - url: url description
    ///   - images: [UIImage] description
    ///   - completion: completion description
    class func UpLoadImages(url:String, model:Order_Info_Goods_list, images:[UIImage], completion:@escaping (AnyObject,Int) -> Void) {
        // When
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(String(model.goods_id).data(using: String.Encoding.utf8)!, withName: "goods_id")
            multipartFormData.append(model.order_sn.data(using: String.Encoding.utf8)!, withName: "order_sn")
            multipartFormData.append(String(model.order_id).data(using: String.Encoding.utf8)!, withName: "order_id")
            multipartFormData.append(model.spec_key.data(using: String.Encoding.utf8)!, withName: "spec_key")
            multipartFormData.append((String(model.goods_num).data(using: String.Encoding.utf8)!), withName: "goods_num")
            multipartFormData.append(model.reason.data(using: String.Encoding.utf8)!, withName: "reason")
            for (index,image) in images.enumerated(){
                //设置时间显示样式
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale.current //设置时区，时间为当前系统时间
                //输出样式
                dateFormatter.dateFormat = "yyyyMMddHHmmss"
                let stringDate = dateFormatter.string(from: Date())
                multipartFormData.append(UIImageJPEGRepresentation(image, 1)!, withName: "return_imgs[0]", fileName: "\(stringDate)_\(index).jpeg", mimeType: "image/jpeg")
            }
        }, to:url)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print(progress.fractionCompleted)
                    SVProgressHUD.showProgress(Float(progress.fractionCompleted))
                })
                
                upload.responseJSON { response in
                    SVProgressHUD.dismiss()
                    if let JSON = response.result.value {
                        let responseDic = JSON as! NSDictionary
                        if let status = responseDic["status"] {
                            if status as! Int == 1 {
                                completion(responseDic["msg"] as AnyObject,status as! Int)
                            }
                            else
                            {
                                if status as! Int == 101{
                                    SingleManager.instance.isLogin = false
                                    
                                }
                                else
                                {
                                    completion(responseDic["msg"] as AnyObject,status as! Int)
                                    
                                }
                            }
                            
                        }
                        else
                        {
                            XHToast.showBottomWithText("请求失败！",duration:1)
                            completion("error" as AnyObject,500)
                        }
                    }
                    else
                    {
                        XHToast.showBottomWithText("请求失败！",duration:1)
                        completion("error" as AnyObject,500)
                    }

                }
                
            case .failure( _):
                XHToast.showBottomWithText("提交失败！",duration:1)
                completion("error" as AnyObject,500)
            }
        }
    }

    class func presentLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "loginNav")
        UIApplication.shared.keyWindow?.rootViewController?.present(loginVC, animated: true, completion: nil)
    }
}
