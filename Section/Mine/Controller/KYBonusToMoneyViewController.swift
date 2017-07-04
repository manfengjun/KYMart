//
//  KYBonusToMoneyViewController.swift
//  KYMart
//
//  Created by JUN on 2017/7/3.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYBonusToMoneyViewController: BaseViewController {

    @IBOutlet weak var codeBgView: UIView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var bonusL: UILabel!
    @IBOutlet weak var amountT: UITextField!
    @IBOutlet weak var codeT: UITextField!
    
    fileprivate lazy var codeView : PooCodeView = {
        let codeView = PooCodeView(frame: CGRect(x: 0, y: 0, width: 70, height: 25), andChange: nil)
        return codeView!
    }()
    var bonus:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func setupUI() {
        navigationItem.title = "分享兑换余额"
        setBackButtonInNav()
        saveBtn.layer.masksToBounds = true
        saveBtn.layer.cornerRadius = 5.0
        codeBgView.addSubview(codeView)
        bonusL.text = bonus
    }
    @IBAction func saveAction(_ sender: UIButton) {
        if (amountT.text?.isEmpty)! {
            Toast(content: "金额不能为空")
            return
        }
        let codeText = NSString(string: codeT.text!)
        let codeStr = NSString(string: codeView.changeString)
        let params = ["money":amountT.text!]
        if codeText.caseInsensitiveCompare(codeStr as String).rawValue == 0 {
            SJBRequestModel.push_fetchBonusToMoneyData(params: params as [String : AnyObject], completion: { (response, status) in
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
