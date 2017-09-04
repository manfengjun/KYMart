//
//  KYOrderListFootView.swift
//  KYMart
//
//  Created by JUN on 2017/7/10.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import PopupDialog
class KYOrderListFootView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var amountL: UILabel!
    var buttonArray:[KYOrderButton] = []
    var model:KYOrderListModel?{
        didSet {
            if let text = model?.order_amount {
                if let array = model?.goods_list {
                    let attributedStr = NSMutableAttributedString(string: "共\(array.count)件商品应付：")
                    attributedStr.addAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 14),NSForegroundColorAttributeName:UIColor.hexStringColor(hex: "#666666")], range: NSRange(location: 0, length: attributedStr.length))
                    let amountStr = NSMutableAttributedString(string: "￥\(text)")
                    amountStr.addAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 14),NSForegroundColorAttributeName:BAR_TINTCOLOR], range: NSRange(location: 0, length: amountStr.length))
                    attributedStr.append(amountStr)
                    amountL.attributedText = attributedStr
                }
            }
            if let text = model?.pay_btn {
                if text == 1 {
                    let button = KYOrderButton(frame: CGRect(x: 0, y: 0, width: 80, height: 25))
                    button.title = "立即付款"
                    button.bgColor = BAR_TINTCOLOR
                    button.borderColor = BAR_TINTCOLOR
                    button.textColor = UIColor.white
                    button.selectResult({ (sender) in
                        if let viewController = self.getCurrentController() {
                            KYOrderMenuUtil.payOrder(order_id: (self.model?.order_sn)!, order_money: (self.model?.order_amount)!, target: viewController)
                        }
                        
                    })
                    buttonArray.append(button)
                }
            }
            if let text = model?.cancel_btn {
                if text == 1 {
                    let button = KYOrderButton(frame: CGRect(x: 0, y: 0, width: 80, height: 25))
                    button.title = "取消订单"
                    button.selectResult({ (sender) in
                        KYOrderMenuUtil.delOrder(order_id: (self.model?.order_id)!, completion: { (isSuccess) in
                            if isSuccess {
                                NotificationCenter.default.post(name:OrderListRefreshNotification, object: nil)

                            }
                            else
                            {
                                
                            }
                        })
                    })
                    buttonArray.append(button)

                }
            }
            if let text = model?.receive_btn {
                if text == 1 {
                    let button = KYOrderButton(frame: CGRect(x: 0, y: 0, width: 80, height: 25))
                    button.title = "确认收货"
                    button.selectResult({ (sender) in
                        let title = "提示"
                        let message = "是否确认收货"
                        let popup = PopupDialog(title: title, message: message, image: nil)
                        let buttonOne = CancelButton(title: "取消") {
                        }
                        let buttonTwo = DefaultButton(title: "确定") {
                            KYOrderMenuUtil.confirmOrder(order_id: (self.model?.order_id)!, completion: { (isSuccess) in
                                if isSuccess {
                                    NotificationCenter.default.post(name:OrderListRefreshNotification, object: nil)
                                }
                                else
                                {
                                    
                                }
                            })

                        }
                        popup.addButtons([buttonOne, buttonTwo])
                        self.getCurrentController()?.present(popup, animated: true, completion: nil)
                    })

                    buttonArray.append(button)

                }
            }
            if let text = model?.shipping_btn {
                if text == 1 {
//                    let button = KYOrderButton(frame: CGRect(x: 0, y: 0, width: 80, height: 25))
//                    button.title = "查看物流"
//                    buttonArray.append(button)

                }
            }
            if let text = model?.return_btn {
                if text == 1 {
//                    let button = KYOrderButton(frame: CGRect(x: 0, y: 0, width: 80, height: 25))
//                    button.title = "申请退货"
//                    button.selectResult({ (sender) in
//                        print("sdff");
//                    })
//                    buttonArray.append(button)
                    
                }
            }
            for (index,item) in buttonArray.enumerated() {
                item.frame = CGRect(x: SCREEN_WIDTH - 15 - CGFloat(80*(index + 1)) - CGFloat(10*index), y: 51 + 12.5, width: 80, height: 25)
                self.addSubview(item)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("KYOrderListFootView", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        addSubview(contentView)
        awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.addSubview(tagsView)
    }


}
