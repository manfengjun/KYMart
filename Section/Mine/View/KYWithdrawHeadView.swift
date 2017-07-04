//
//  KYWithdrawHeadView.swift
//  KYMart
//
//  Created by JUN on 2017/6/29.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYWithdrawHeadView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var balanceBtn: UIImageView!
    @IBOutlet weak var bonusBtn: UIImageView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var moneyT: UITextField!
    @IBOutlet weak var bankNameT: UITextField!
    @IBOutlet weak var bankCardT: UITextField!
    @IBOutlet weak var realNameT: UITextField!
    @IBOutlet weak var codeT: UITextField!
    @IBOutlet weak var codeBgView: UIView!
    //闭包类型
    var SaveResultClosure: SelectClosure?     // 闭包
    
    var info:Info? {
        willSet {
            info?.changetype = "1"
        }
        didSet {
            if let text = info?.bank_name {
                bankNameT.text = text
            }
            if let text = info?.bank_card {
                bankCardT.text = text
            }
            if let text = info?.realname {
                realNameT.text = text
            }

        }
    }
    fileprivate lazy var codeView : PooCodeView = {
        let codeView = PooCodeView(frame: CGRect(x: 0, y: 0, width: 60, height: 25), andChange: nil)
        return codeView!
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("KYWithdrawHeadView", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        addSubview(contentView)
        awakeFromNib()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        codeBgView.addSubview(codeView)
        saveBtn.layer.masksToBounds = true
        saveBtn.layer.cornerRadius = 5.0
    }
    @IBAction func selectAction(_ sender: UITapGestureRecognizer) {
        balanceBtn.image = sender.view?.tag == 1 ? UIImage(named: "cart_select_yes.png") : UIImage(named: "cart_select_no.png")
        bonusBtn.image = sender.view?.tag == 2 ? UIImage(named: "cart_select_yes.png") : UIImage(named: "cart_select_no.png")
        if let text = sender.view?.tag {
            info?.changetype = String(text)
        }

    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        if (moneyT.text?.isEmpty)! {
            Toast(content: "金额不能为空")
            return
        }
        if (bankNameT.text?.isEmpty)! {
            Toast(content: "银行名称不能为空")
            return
        }
        if (bankCardT.text?.isEmpty)! {
            Toast(content: "收款账号不能为空")
            return
        }
        if (realNameT.text?.isEmpty)! {
            Toast(content: "开户名称不能为空")
            return
        }
        info?.bank_name = bankNameT.text
        info?.bank_card = bankCardT.text
        info?.realname = realNameT.text
        info?.money = moneyT.text
        let codeText = NSString(string: codeT.text!)
        let codeStr = NSString(string: codeView.changeString)
        let params = ["changetype":info?.changetype,"money":info?.money,"bank_name":info?.bank_name,"bank_card":info?.bank_card,"realname":info?.realname]
        if codeText.caseInsensitiveCompare(codeStr as String).rawValue == 0 {
            SJBRequestModel.push_fetchWithdrawalsData(params: params as [String : AnyObject], completion: { (response, status) in
                if status == 1{
                    self.Toast(content: "申请成功")
                    self.SaveResultClosure?()
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
    /**
     选择闭包回调
     */
    func saveResult(_ finished: @escaping SelectClosure) {
        SaveResultClosure = finished
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
