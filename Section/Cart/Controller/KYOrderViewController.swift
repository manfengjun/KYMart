//
//  KYOrderViewController.swift
//  KYMart
//
//  Created by JUN on 2017/7/5.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
fileprivate let KYOrderTVCellIdentifier = "kYOrderTVCell"

class KYOrderViewController: BaseViewController {

    @IBOutlet var headView: UIView!
    @IBOutlet var footView: UIView!
    @IBOutlet weak var tableView: UITableView!
    //地址
    @IBOutlet weak var consignorL: UILabel!
    @IBOutlet weak var addressL: UILabel!
    @IBOutlet weak var phoneL: UILabel!
    //订单价钱
    @IBOutlet weak var goodsFeeL: UILabel!
    @IBOutlet weak var postFeeL: UILabel!
    @IBOutlet weak var couponFeeL: UILabel!
    @IBOutlet weak var ponitsfeeL: UILabel!
    @IBOutlet weak var balanceL: UILabel!
    @IBOutlet weak var order_prom_amountL: UILabel!
    @IBOutlet weak var payablesL: UILabel!
    
    @IBOutlet weak var doBalanceL: UILabel!
    @IBOutlet weak var doPonitsfeeL: UILabel!
    
    @IBOutlet weak var ponitsfeeT: UITextField!
    @IBOutlet weak var balanceT: UITextField!
    
    fileprivate var orderModel:KYOrderModel?{
        didSet {
            self.tableView.reloadData()
            if let text = orderModel?.addressList.consignee {
                consignorL.text = text
            }
            if let text = orderModel?.addressList.address {
                addressL.text = text
            }
            if let text = orderModel?.addressList.mobile {
                phoneL.text = text
            }
            if let text = orderModel?.userInfo.user_money {
                doBalanceL.text = "您的可用余额：\(text)"
            }
            if let text = orderModel?.userInfo.pay_points {
                doPonitsfeeL.text = "您的可用积分：\(text)"
            }
        }
    }
    func returnAttributedStr(text:String,value:String) -> NSMutableAttributedString {
        let attStr = NSMutableAttributedString(string: text)
        attStr.addAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 12),NSForegroundColorAttributeName:UIColor.hexStringColor(hex: "#666666")], range: NSRange(location: 0, length: attStr.length))
        let valueArrStr = NSMutableAttributedString(string: value)
        valueArrStr.addAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 12),NSForegroundColorAttributeName:BAR_TINTCOLOR], range: NSRange(location: 0, length: valueArrStr.length))
        attStr.append(valueArrStr)
        let unitArrStr = NSMutableAttributedString(string: "元")
        unitArrStr.addAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 12),NSForegroundColorAttributeName:UIColor.hexStringColor(hex: "#666666")], range: NSRange(location: 0, length: unitArrStr.length))
        attStr.append(unitArrStr)
        return attStr
    }
    fileprivate var orderPriceModel:KYOrderPriceModel?{
        didSet {
            if let text = orderPriceModel?.goodsFee {
                goodsFeeL.attributedText = returnAttributedStr(text: "商品总额：¥", value: "\(text)")
            }
            if let text = orderPriceModel?.postFee {
                postFeeL.attributedText = returnAttributedStr(text: "配送费用：¥", value: "\(text)")

            }
            if let text = orderPriceModel?.couponFee {
                couponFeeL.attributedText = returnAttributedStr(text: "使用优惠卷：-¥", value: "\(text)")

            }
            if let text = orderPriceModel?.pointsFee {
                ponitsfeeL.attributedText = returnAttributedStr(text: "使用积分：-¥", value: "\(text)")

            }
            if let text = orderPriceModel?.balance {
                balanceL.attributedText = returnAttributedStr(text: "使用金额：-¥", value: "\(text)")

            }
            if let text = orderPriceModel?.order_prom_amount {
                order_prom_amountL.attributedText = returnAttributedStr(text: "优惠活动：-¥", value: "\(text)")

            }
            if let text = orderPriceModel?.payables {
                payablesL.attributedText = returnAttributedStr(text: "应付金额：¥", value: "\(text)")

            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        dataRequest()
        // Do any additional setup after loading the view.
    }
    func setupUI() {
        setBackButtonInNav()
        headView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 80)
        footView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 355)
        tableView.tableHeaderView = headView
        tableView.tableFooterView = footView
            }
    func dataRequest() {
        let params = ["user_id":SingleManager.instance.loginInfo?.user_id]
        SJBRequestModel.push_fetchOrderProductData(params: params as [String : AnyObject]) { (response, status) in
            if status == 1{
                self.postOrderInfo(type: "update", model: response as! KYOrderModel)
            }
            else
            {
                self.Toast(content: "生成订单失败！")
            }
        }
    }
    
    /// 获取／更新订单信息
    ///
    /// - Parameters:
    ///   - type: type description
    ///   - model: model description
    func postOrderInfo(type:String,model:KYOrderModel) {
        let cart_form_data = KYCartFormDataModel()
        for store in model.storeList {
            cart_form_data.shipping_code[String(store.store_id)] = store.shippingList[0].shipping_code
            if let text = store.user_note {
                cart_form_data.user_note[String(store.store_id)] = text
            }
            
        }
        if let user_id = SingleManager.instance.loginInfo?.user_id {
            var formparams = ["user_id":user_id,"act":"order_price","address_id":String(model.addressList.address_id),"cart_form_data":cart_form_data.yy_modelToJSONString()!]
            if type == "balance" {
                formparams["pay_points"] = balanceT.text
            }
            if type == "ponitsfee" {
                formparams["user_money"] = ponitsfeeT.text

            }

            SJBRequestModel.push_fetchOrderMoneyData(params: formparams as [String : AnyObject], completion: { (response, status) in
                if status == 1 {
                    if type == "update" {
                        self.orderPriceModel = response as? KYOrderPriceModel
                        self.orderModel = model
                    }
                    else
                    {
                    }
                }
                else
                {
                    self.Toast(content: response as! String)
                }
            })
        }

    }
    @IBAction func submitAction(_ sender: UIButton) {
        if let model = self.orderModel {
            self.postOrderInfo(type: "submite", model: model)

        }
        else
        {
            Toast(content: "提交失败！")
        }
    }
    @IBAction func userAction(_ sender: UIButton) {
        if sender.tag == 1 {
            if (balanceT.text?.isEmpty)!  {
                Toast(content: "余额不能为空！")
                return
            }
            if let text = orderModel?.userInfo.user_money {
                if Float(balanceT.text!)! < Float(text)! {
                    if let model = self.orderModel {
                        self.postOrderInfo(type: "balance", model: model)
                        
                    }
                }
                else
                {
                    Toast(content: "可用余额不够")
                }
            }
        }
        else
        {
            if (ponitsfeeT.text?.isEmpty)! {
                Toast(content: "积分不能为空！")
                return
            }
            if let text = orderModel?.userInfo.pay_points {
                if Int(ponitsfeeT.text!)! < text {
                    if let model = self.orderModel {
                        self.postOrderInfo(type: "ponitsfee", model: model)
                        
                    }
                }
                else
                {
                    Toast(content: "可用积分不够")
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension KYOrderViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if let array = orderModel?.storeList {
            return array.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = orderModel?.storeList {
            let storeList = array[section]
            if let cartArray = storeList.cartList {
                return cartArray.count
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KYOrderTVCellIdentifier, for: indexPath) as! KYOrderTVCell
        if let array = orderModel?.storeList {
            let storeModel = array[indexPath.section]
            if let cartArray = storeModel.cartList {
                cell.model = cartArray[indexPath.row]
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = KYOrderSectionHeadView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 41))
        if let array = orderModel?.storeList {
            let storeModel = array[section]
            view.model = storeModel
        }
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 41
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = KYOrderSectionFootView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 61))
        view.noteResult { (text) in
            let storeModel = self.orderModel?.storeList[section]
            storeModel?.user_note = text as! String
        }
        return view
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 61
    }
}
