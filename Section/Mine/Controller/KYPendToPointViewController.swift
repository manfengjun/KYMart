//
//  KYBonusToMoneyViewController.swift
//  KYMart
//
//  Created by JUN on 2017/7/3.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
class KYPendToPointViewController: BaseViewController {
    
    @IBOutlet weak var codeBgView: UIView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var bonusL: UILabel!
    @IBOutlet weak var amountT: UITextField!
    @IBOutlet weak var codeT: UITextField!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var headH: NSLayoutConstraint!
    
    fileprivate lazy var codeView : PooCodeView = {
        let codeView = PooCodeView(frame: CGRect(x: 0, y: 0, width: 70, height: 25), andChange: nil)
        return codeView!
    }()
    fileprivate lazy var headView : KYUserInfoView = {
        let headView = KYUserInfoView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH*3/5 + 51 + 51))
        headView.userModel = SingleManager.instance.userInfo
        return headView
    }()
    var pay_points:Int?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.subviews[0].alpha = 0
        IQKeyboardManager.sharedManager().enable = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.subviews[0].alpha = 1
        IQKeyboardManager.sharedManager().enable = false
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func setupUI() {
        setBackButtonInNav()
        saveBtn.layer.masksToBounds = true
        saveBtn.layer.cornerRadius = 5.0
        codeBgView.addSubview(codeView)
        bonusL.text = "\(pay_points!)"
        headH.constant = SCREEN_WIDTH*3/5 + 51
        infoView.addSubview(headView)
        headView.titleL.text = "待发放转积分"
        headView.userModel = SingleManager.instance.userInfo
        
    }
    @IBAction func saveAction(_ sender: UIButton) {
        if (amountT.text?.isEmpty)! {
            Toast(content: "不能为空")
            return
        }
        let codeText = NSString(string: codeT.text!)
        let codeStr = NSString(string: codeView.changeString)
        let params = ["money":amountT.text!]
        if codeText.caseInsensitiveCompare(codeStr as String).rawValue == 0 {
            SJBRequestModel.push_fetchPendToPointData(params: params as [String : AnyObject], completion: { (response, status) in
                if status == 1{
                    self.Toast(content: "申请成功")
                    self.navigationController?.popViewController(animated: true)
                }
                else
                {
                    self.Toast(content: response as! String)
                }
            })
        }
        else
        {
            Toast(content: "验证码错误！")
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
