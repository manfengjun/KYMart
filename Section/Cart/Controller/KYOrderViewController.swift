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
            var addressStr = ""
            if let provice = orderModel?.addressList?.province {
                addressStr += getAddressName(id: provice)
                if let city = orderModel?.addressList?.city{
                    addressStr += getAddressName(id: city)
                    if let district = orderModel?.addressList?.district {
                        addressStr += getAddressName(id: district)
                        if let twon = orderModel?.addressList?.twon {
                            addressStr += getAddressName(id: twon)
                            if let address = orderModel?.addressList?.address {
                                addressStr += "\(address)"
                                addressL.text = addressStr
                            }
                        }
                    }
                }
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
    
    /// 获取显示地址
    ///
    /// - Parameter id: id description
    /// - Returns: return value description
    func getAddressName(id:Int) -> String {
        if let array = CitiesDataTool.sharedManager().queryData(with: id) {
            if array.count > 0 {
                return array[0] as! String + " "
            }
        }
        return " "
    }
    
    /// 拼接价格
    ///
    /// - Parameters:
    ///   - text: text description
    ///   - value: value description
    /// - Returns: return value description
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
                goodsFeeL.text = "￥\(text)元"
//                goodsFeeL.attributedText = returnAttributedStr(text: "商品总额：¥", value: "\(text)")
            }
            if let text = orderPriceModel?.postFee {
                postFeeL.text = "￥\(text)元"

//                postFeeL.attributedText = returnAttributedStr(text: "配送费用：¥", value: "\(text)")

            }
            if let text = orderPriceModel?.couponFee {
                couponFeeL.text = "￥\(text)元"

//                couponFeeL.attributedText = returnAttributedStr(text: "使用优惠券：-¥", value: "\(text)")

            }
            if let text = orderPriceModel?.pointsFee {
                ponitsfeeL.text = "￥\(text)元"

//                ponitsfeeL.attributedText = returnAttributedStr(text: "使用积分：-¥", value: "\(text)")

            }
            if let text = orderPriceModel?.balance {
                balanceL.text = "￥\(text)元"

//                balanceL.attributedText = returnAttributedStr(text: "使用金额：-¥", value: "\(text)")

            }
            if let text = orderPriceModel?.order_prom_amount {
                order_prom_amountL.text = "￥\(text)元"
//                order_prom_amountL.attributedText = returnAttributedStr(text: "优惠活动：-¥", value: "\(text)")

            }
            if let text = orderPriceModel?.payables {
                payablesL.text = "￥\(text)元"

//                payablesL.attributedText = returnAttributedStr(text: "应付金额：¥", value: "\(text)")

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
                self.Toast(content: response as! String)
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let addAddressVC = storyboard.instantiateViewController(withIdentifier: "addAddressVC") as! KYAddAddressViewController
                addAddressVC.saveResult({ 
                    self.dataRequest()
                })
                self.navigationController?.pushViewController(addAddressVC, animated: true)
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
            else
            {
                cart_form_data.user_note[String(store.store_id)] = ""

            }
            
        }
        if let user_id = SingleManager.instance.loginInfo?.user_id {
            var formparams = ["user_id":user_id,"act":"order_price","address_id":String(model.addressList.address_id),"cart_form_data":cart_form_data.yy_modelToJSONString()!]
            formparams["user_money"] = (balanceT.text?.isEmpty)! ? "" : balanceT.text
            formparams["pay_points"] = (ponitsfeeT.text?.isEmpty)! ? "" : ponitsfeeT.text
            if type == "submit" {
                formparams["act"] = "submit_order"
                
            }
            SJBRequestModel.push_fetchOrderMoneyData(params: formparams as [String : AnyObject], completion: { (response, status) in
                if status == 1 {
                    if type == "update" || type == "balance" || type == "ponitsfee"{
                        // 刷新信息
                        self.orderPriceModel = response as? KYOrderPriceModel
                        self.orderModel = model
                    }
                    else
                    {
                        //提交订单成功
                        let order_id = response
                        self.Toast(content: "提交订单成功！")
                        let params = ["master_order_sn":order_id]
                        SJBRequestModel.push_fetchPostOrderIdData(params: params, completion: { (response, status) in
                            if status == 1 {
                                if response as! Float == 0 {
                                    self.Toast(content: "支付成功")
                                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                    let pageOrderVC = storyboard.instantiateViewController(withIdentifier: "pageOrderVC") as! KYPageOrderViewController
                                    pageOrderVC.isPresent = true
                                    let nav = BaseNavViewController(rootViewController: pageOrderVC)
                                    self.present(nav, animated: true, completion: nil)

                                }
                                else
                                {
                                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                    let orderPayVC = storyboard.instantiateViewController(withIdentifier: "OrderPayVC") as! KYOrderPayViewController
                                    orderPayVC.orderID = order_id as? String
                                    orderPayVC.orderMoney = String(response as! Float)
                                    self.navigationController?.pushViewController(orderPayVC, animated: true)
                                }
                                
                            }
                            else
                            {
                                self.Toast(content: "调用支付失败！")
                            }
                        })
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
            self.postOrderInfo(type: "submit", model: model)

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
                        self.postOrderInfo(type: "update", model: model)
                        
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
                        self.postOrderInfo(type: "update", model: model)
                        
                    }
                }
                else
                {
                    Toast(content: "可用积分不够")
                }
            }
        }
    }
    @IBAction func selectAddressAction(_ sender: UITapGestureRecognizer) {
        let addressVC = KYShopAddressViewController()
        addressVC.isSelectAddress = true
        addressVC.selectResult { (addressmodel) in
            let model = self.orderModel
            model?.addressList = addressmodel as! KYAddressModel
            self.orderModel = model
//            self.orderModel?.addressList = addressmodel as! KYAddressModel
//            self.tableView.reloadData()
        }
        
        self.navigationController?.pushViewController(addressVC, animated: true)
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
