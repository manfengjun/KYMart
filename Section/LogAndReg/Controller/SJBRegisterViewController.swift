//
//  RegisterViewController.swift
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

class SJBRegisterViewController: BaseViewController {

    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var phoneT: UITextField!
    @IBOutlet weak var cardT: UITextField!
    @IBOutlet weak var passwordT: UITextField!
    @IBOutlet weak var repassT: UITextField!
    @IBOutlet weak var verCodeBtn: UIButton!
    @IBOutlet weak var regBtn: UIButton!
    var isReg = false
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
            button.isUserInteractionEnabled = false
            self.regCodeHandle()
        }
    }
    func setupUI() {
        self.title = "注册"
        regBtn.layer.masksToBounds = true
        regBtn.layer.cornerRadius = 5
        
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 5
        setLeftButtonInNav(imageUrl: "nav_back.png", action: #selector(back))

    }
    func regCodeHandle() {
        SJBRequestModel.pull_fetchVerifyCodeData { (response, status) in
            self.verCodeBtn.isUserInteractionEnabled = true
            if status == 1 {
                let verifycode = response as! String
                SingleManager.instance.verify_code = verifycode
                let account = self.phoneT.text
                SJBRequestModel.push_fetchRegVerifyCodeData(phone: account!, code: verifycode, completion: { (response, status) in
                    if status == 1{
                        let countDown = SJBCountDown(button: self.verCodeBtn)
                        countDown.isCounting = true

                    }
                    
                })
            }
        }
    }
    func regHandle() {
        let verifycode = SingleManager.instance.verify_code
        let account = self.phoneT.text
        let card = self.cardT.text
        let password = self.passwordT.text
        let password2 = self.repassT.text
        let params = ["username":account!,"password":password!,"password2":password2!,"code":card!,"unique_id":SingleManager.getUUID(),"capache":verifycode!,"push_id":""]
        SJBRequestModel.push_fetchRegisterData(params: params as [String : AnyObject], completion: { (response, status) in
            if status == 1{
                self.Toast(content: "注册成功")
                //注册成功
                self.navigationController?.popViewController(animated: true)
            }
            else
            {
                
                
            }
        })

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
// MARK: - 响应事件
extension SJBRegisterViewController{
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func regAction(_ sender: UIButton) {
        if passwordT.text == repassT.text {
            regHandle()
        }
        else{
            Toast(content: "两次输入密码不一致")
        }
    }
}
// MARK: - 业务逻辑
extension SJBRegisterViewController{
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
                self.regBtn.isUserInteractionEnabled = true
                self.regBtn.backgroundColor = BAR_TINTCOLOR
            }
            else
            {
                self.regBtn.isUserInteractionEnabled = false
                self.regBtn.backgroundColor = UIColor.lightGray
            }

        }
    }

}
