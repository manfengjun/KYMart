//
//  LoginViewController.swift
//  HNLYSJB
//
//  Created by jun on 2017/6/2.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result
import IQKeyboardManagerSwift

class SJBLoginViewController: UIViewController {

    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var accountT: UITextField!
    @IBOutlet weak var passwordT: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    /// 闭包回调传值
    var LoginResultClosure: LoginClosure?     // 闭包
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.sharedManager().enable = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.sharedManager().enable = false
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        validated()
    }
    
    func setupUI() {
        self.title = "登录"
        setLeftButtonInNav(imageUrl: "nav_del.png", action: #selector(goback))
        loginBtn.layer.masksToBounds = true
        loginBtn.layer.cornerRadius = 5
        
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 5
        
        menuView.layer.masksToBounds = true
        menuView.layer.cornerRadius = 5
    }
    func loginHandle() {
        SJBRequestModel.pull_fetchVerifyCodeData { (response, status) in
            if status == 1 {
                let verifycode = response as! String
                let account = self.accountT.text
                let password = self.passwordT.text
                let params = ["username":account!, "password":password!, "unique_id":SingleManager.getUUID(), "capache":verifycode, "push_id":""]
                SJBRequestModel.push_fetchLoginData(params: params, completion: { (response, status) in
                    if status == 1{
                        SingleManager.instance.loginInfo = response as? KYLoginInfoModel
                        SingleManager.instance.isLogin = true
                        self.Toast(content: "登陆成功")
                        self.dismiss(animated: true, completion: nil)
                        self.LoginResultClosure?(true)
                    }
                    else
                    {
                        
                        self.Toast(content: response as! String)
                        self.LoginResultClosure?(false)
                    }
                })
            }
            else
            {
                self.Toast(content: "未知错误")
                self.LoginResultClosure?(false)
            }
        }
    }
    /**
     登录响应闭包回调
     */
    func loginResult(_ finished: @escaping LoginClosure) {
        LoginResultClosure = finished
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - 响应事件
extension SJBLoginViewController{
    @IBAction func loginAction(_ sender: UIButton) {
        loginHandle()
    }
    @IBAction func regAction(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "L_register_SegueID", sender: sender)
        
    }
    @IBAction func forgetAction(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "L_forget_SegueID", sender: sender)
        
    }
    override func goback() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - 业务逻辑
extension SJBLoginViewController
{
    
    /// 验证数据正确性
    func validated() {
        let accountSignal = accountT.reactive.continuousTextValues.map { (text) -> Bool in
            if let str = text {
                return self.ContentIsValidated(text: str)
            }
            return false
        }
        let passSignal = passwordT.reactive.continuousTextValues.map { (text) -> Bool in
            if let str = text {
                return self.PassWordIsValidated(text: str)
            }
            return false
        }
        Signal.combineLatest(accountSignal, passSignal).observeValues { (accountLegal, passLegal) in
            if accountLegal && passLegal{
                self.loginBtn.isUserInteractionEnabled = true
                self.loginBtn.backgroundColor = BAR_TINTCOLOR
            }
            else
            {
                self.loginBtn.isUserInteractionEnabled = false
                self.loginBtn.backgroundColor = UIColor.lightGray
            }
        }
    }
}
