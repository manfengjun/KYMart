//
//  KYUserInfoViewController.swift
//  KYMart
//
//  Created by Jun on 2017/6/18.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYUserInfoViewController: BaseViewController {
    @IBOutlet weak var nickNameL: UITextField!
    @IBOutlet weak var oldPassL: UITextField!
    @IBOutlet weak var newPassL: UITextField!
    var sexSelect:Int = 0
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    func setupUI() {
        setBackButtonInNav()
        if let text = SingleManager.instance.loginInfo?.nickname {
            nickNameL.text = text
        }
    }
    @IBAction func selectAction(_ sender: UITapGestureRecognizer) {
        let tag = sender.view?.tag
        sexSelect = tag! - 1
        for i in 1..<4 {
            let imageView = view.viewWithTag(i)?.viewWithTag(11) as! UIImageView
            imageView.image = (i == tag ? UIImage(named: "cart_select_yes") : UIImage(named: "cart_select_no"))
        }
        

    }
    @IBAction func saveInfoAction(_ sender: UIButton) {
        if (nickNameL.text?.isEmpty)! {
            Toast(content: "昵称不能为空")
        }
        let params = ["nickname":nickNameL.text!,"sex":String(sexSelect)]
        sender.isUserInteractionEnabled = false
        SJBRequestModel.push_fetchChangeUserInfoData(params: params as [String : AnyObject]) { (response, status) in
            sender.isUserInteractionEnabled = true

            if status == 1 {
                SingleManager.instance.loginInfo?.nickname = self.nickNameL.text
                self.Toast(content: "修改成功")
            }
            else
            {
                self.Toast(content: response as! String)
            }
        }
    }
    @IBAction func savePhoneAction(_ sender: UIButton) {
        //修改密码
        if (oldPassL.text?.isEmpty)! {
            Toast(content: "旧密码不能为空")
        }
        if (newPassL.text?.isEmpty)! {
            Toast(content: "新密码不能为空")
        }
        let params = ["old_password":oldPassL.text!,"new_password":newPassL.text!]
        SJBRequestModel.push_fetchChangePasswordData(params: params as [String : AnyObject]) { (response, status) in
            if status == 1{
                self.Toast(content: "修改密码成功！")
            }
            else
            {
                self.Toast(content: response as! String)

            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
