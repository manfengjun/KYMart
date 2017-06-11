//
//  ForgetViewController.swift
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

class SJBForgetViewController: UIViewController {
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var phoneT: UITextField!
    @IBOutlet weak var cardT: UITextField!
    @IBOutlet weak var passwordT: UITextField!
    @IBOutlet weak var repassT: UITextField!
    @IBOutlet weak var verCodeBtn: UIButton!
    @IBOutlet weak var forgetBtn: UIButton!
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
        verCodeBtn.reactive.controlEvents(.touchUpInside).observeValues { (button) in
            let countDown = SJBCountDown(button: button)
            countDown.isCounting = true
        }
        // Do any additional setup after loading the view.
    }

    func setupUI() {
        self.title = "找回密码"
        forgetBtn.layer.masksToBounds = true
        forgetBtn.layer.cornerRadius = 5
        
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 5
        setLeftButtonInNav(imageUrl: "nav_back.png", action: #selector(goback))
    }
    func forgetCodeHandle() {
        let account = self.phoneT.text
        SJBRequestModel.push_fetchForgetVerifyCodeData(phone: account!, completion: { (response, status) in
            if status == 1{
                let countDown = SJBCountDown(button: self.verCodeBtn)
                countDown.isCounting = true
                
            }

        })
    }
    func forgetHandle() {
        let verifycode = SingleManager.instance.verify_code
        let account = self.phoneT.text
        let card = self.cardT.text
        let password = self.passwordT.text
        let params = ["mobile":account!,"password":password!,"check_code":card!,"unique_id":SingleManager.getUUID(),"capache":verifycode!]
        SJBRequestModel.pull_fetchVerifyCodeData { (response, status) in
            self.verCodeBtn.isUserInteractionEnabled = true
            if status == 1 {
                let verifycode = response as! String
                SingleManager.instance.verify_code = verifycode
                SJBRequestModel.push_fetchForgetData(params: params, completion: { (response, status) in
                    if status == 1{
                        self.Toast(content: "重置密码成功")
                        self.navigationController?.popViewController(animated: true)
                    }
                    else
                    {
                        
                        
                    }
                })
            }
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
// MARK: - 响应事件
extension SJBForgetViewController{
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
// MARK: - 业务逻辑
extension SJBForgetViewController{
    /// 验证数据正确性
    func validated() {
        let phoneSignal = phoneT.reactive.continuousTextValues.map { (text) -> Bool in
            if let str = text {
                return self.PhoneNumberIsValidated(text: str)
            }
            return false
        }
        let cardSignal = cardT.reactive.continuousTextValues.map { (text) -> Bool in
            if let str = text {
                return self.NumberIsVailidated(text: str)
            }
            return false
        }
        let passwordSignal = passwordT.reactive.continuousTextValues.map { (text) -> Bool in
            if let str = text {
                return self.PassWordIsValidated(text: str)
            }
            return false
        }
        let rePassSignal = repassT.reactive.continuousTextValues.map { (text) -> Bool in
            if let str = text {
                return self.PassWordIsValidated(text: str)
            }
            return false
        }
        Signal.combineLatest(phoneSignal, cardSignal, passwordSignal, rePassSignal).observeValues { (phoneLegal,cardLegal,passwordLegal,rePassLegal) in
            if phoneLegal && cardLegal && passwordLegal && rePassLegal {
                self.forgetBtn.isUserInteractionEnabled = true
                self.forgetBtn.backgroundColor = BAR_TINTCOLOR
            }
            else
            {
                self.forgetBtn.isUserInteractionEnabled = false
                self.forgetBtn.backgroundColor = UIColor.lightGray
            }
            
        }
    }

}
