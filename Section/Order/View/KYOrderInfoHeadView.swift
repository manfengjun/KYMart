//
//  KYOrderInfoHeadView.swift
//  KYMart
//
//  Created by jun on 2017/7/11.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYOrderInfoHeadView: UIView {

    //状态，编号，配送费
    @IBOutlet weak var statusL: UILabel!
    @IBOutlet weak var ordersnL: UILabel!
    @IBOutlet weak var shipMoneyL: UILabel!
    //支付
    @IBOutlet weak var payTypeL: UILabel!
    @IBOutlet weak var amountL: UILabel!
    //收货信息
    @IBOutlet weak var consignorL: UILabel!
    @IBOutlet weak var addressL: UILabel!
    @IBOutlet weak var phoneL: UILabel!
    
    //物流信息
    @IBOutlet weak var shipTypeL: UILabel!
    @IBOutlet weak var shipsnL: UILabel!
    //店铺信息
    @IBOutlet weak var storeNameL: UILabel!
    @IBOutlet weak var storeQQL: UILabel!
    @IBOutlet weak var storePhoneL: UILabel!
    
    
    @IBOutlet var contentView: UIView!
    var model:KYOrderInfoModel? {
        didSet {
            if let text = model?.order_status {
                var statusStr:String = ""
                switch text {
                case 0:
                    statusStr = "待确认"
                    break
                case 1:
                    statusStr = "已确认"
                    break
                case 2:
                    statusStr = "已收货"
                    break
                case 3:
                    statusStr = "已取消"
                    break
                case 4:
                    statusStr = "已完成"
                    break
                case 5:
                    statusStr = "已作废"
                    break
                default:
                    break
                }
                statusL.text = "订单状态：\(statusStr)"
            }

            if let text = model?.order_sn {
                ordersnL.text = "订单号： \(text)"
            }
            if let text = model?.shipping_price {
                shipMoneyL.text = "配送费用：￥\(text)"
            }
            
            if let text = model?.pay_code {
                payTypeL.text = "所选支付方式：\(text)"
            }
            if let text = model?.order_prom_amount {
                amountL.text = "应付款余额：￥\(text)"
            }
            
            if let text = model?.consignee {
                consignorL.text = "收货人：￥\(text)"
            }
            var addressStr = ""
            if let provice = model?.province {
                addressStr += getAddressName(id: provice)
                if let city = model?.city{
                    addressStr += getAddressName(id: city)
                    if let district = model?.district {
                        addressStr += getAddressName(id: district)
                        if let twon = model?.twon {
                            addressStr += getAddressName(id: twon)
                            if let address = model?.address {
                                addressStr += "\(address)"
                                addressL.text = addressStr
                            }
                        }
                    }
                }
            }
            if let text = model?.mobile {
                phoneL.text = "电话：￥\(text)"
            }

            if let text = model?.shipping_name {
                shipTypeL.text = "配送方式：\(text)"
            }
            if let text = model?.invoice_no {
                shipsnL.text = "快递单号：\(text)"
            }
            
            if let text = model?.store_name {
                storeNameL.text = "店铺名称：\(text)"
            }
            if let text = model?.store_qq {
                storeQQL.text = "qq：\(text)"
            }
            if let text = model?.store_phone {
                storePhoneL.text = "联系电话：\(text)"
            }
            
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("KYOrderInfoHeadView", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        addSubview(contentView)
        awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
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

}
