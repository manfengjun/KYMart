//
//  KYAddAddressViewController.swift
//  KYMart
//
//  Created by Jun on 2017/6/15.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYAddAddressViewController: BaseViewController {

    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var addressAreaL: UILabel!
    @IBOutlet weak var nameT: UITextField!
    @IBOutlet weak var addressT: UITextField!
    @IBOutlet weak var phoneT: UITextField!
    @IBOutlet weak var codeT: UITextField!
    @IBOutlet weak var defaultIV: UIImageView!
    
    /// 默认选中
    var isDefault:Bool = false
    
    /// 编辑状态下数据
    var model:KYAddressModel?
    
    fileprivate var params:[String:AnyObject]?
    fileprivate lazy var bgView : UIView = {
        let bgView = UIView(frame: UIScreen.main.bounds)
        bgView.backgroundColor = UIColor.rgbColor(r: 0, g: 0, b: 0, a: 0.3)
        let tap = UITapGestureRecognizer(target: self, action: #selector(hide))
        tap.delegate = self
        bgView.addGestureRecognizer(tap)
        return bgView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButtonInNav()
        navigationItem.title = "添加地址"
        saveBtn.layer.masksToBounds = true
        saveBtn.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

// MARK: - 按钮事件
extension KYAddAddressViewController {
    
    /// 保存
    ///
    /// - Parameter sender: sender description
    @IBAction func saveAction(_ sender: UIButton) {
        if (nameT.text?.isEmpty)! {
            Toast(content: "收货人不能为空")
            return
        }
        if (addressAreaL.text?.isEmpty)! {
            Toast(content: "所在地区不能为空")
            return
        }

        if (addressT.text?.isEmpty)! {
            Toast(content: "详细地址不能为空")
            return
        }

        if (phoneT.text?.isEmpty)! {
            Toast(content: "手机号不能为空")
            return
        }
        if (codeT.text?.isEmpty)! {
            Toast(content: "邮政编码不能为空")
            return
        }
        if let text = SingleManager.instance.loginInfo?.user_id {
            params?["user_id"] = text as AnyObject
            params?["consignee"] = nameT.text as AnyObject
            params?["mobile"] = phoneT.text as AnyObject
            params?["address"] = addressT.text as AnyObject
            params?["zipcode"] = codeT.text as AnyObject
            params?["is_default"] = (isDefault ? "1" : "0") as AnyObject
            SJBRequestModel.push_fetchAddAddressData(params: params!) { (response, status) in
                if status == 1{
                    self.Toast(content: "保存地址成功")
                    self.navigationController?.popViewController(animated: true)
                }
                else
                {
                    self.Toast(content: "保存地址失败")
                }
            }
        }
        else
        {
            Toast(content: "未登录")
        }
    }
    
    /// 是否设置为默认
    ///
    /// - Parameter sender: sender description
    @IBAction func setDafaultAction(_ sender: UITapGestureRecognizer) {
        defaultIV.image = isDefault ? UIImage(named: "cart_select_no") : UIImage(named: "cart_select_yes")
        isDefault = isDefault ? false : true
    }
    
    /// 地址选择器
    ///
    /// - Parameter sender: sender description
    @IBAction func selectAddress(_ sender: UITapGestureRecognizer) {
        let chooseView = ChooseLocationView(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 300, width: SCREEN_WIDTH, height: 300))
        chooseView.chooseFinish = {(result,address) in
            if let dic = result {
                self.params = dic as? [String:AnyObject]

            }
            if let text = address {
                self.addressAreaL.text = text
            }
            self.bgView.removeFromSuperview()
        }
        bgView.addSubview(chooseView)
        UIApplication.shared.keyWindow?.addSubview(bgView)
    }

    /// 显示隐藏侧滑菜单
    func hide() {
        bgView.removeFromSuperview()
    }
}
extension KYAddAddressViewController:UIGestureRecognizerDelegate {
    /// 解决手势冲突
    ///
    /// - Parameters:
    ///   - gestureRecognizer: gestureRecognizer description
    ///   - touch: touch description
    /// - Returns: return value description
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isEqual(bgView))! {
            return true
        }
        return false
    }
}