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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - 响应事件
extension SJBLoginViewController{
    @IBAction func loginAction(_ sender: UIButton) {
        
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
                return self.PhoneNumberIsValidated(text: str)
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