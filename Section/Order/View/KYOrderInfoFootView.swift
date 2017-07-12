//
//  KYOrderInfoFootView.swift
//  KYMart
//
//  Created by jun on 2017/7/11.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYOrderInfoFootView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var goodsFeeL: UILabel!
    @IBOutlet weak var postFeeL: UILabel!
    @IBOutlet weak var couponFeeL: UILabel!
    @IBOutlet weak var ponitsfeeL: UILabel!
    @IBOutlet weak var balanceL: UILabel!
    @IBOutlet weak var order_prom_amountL: UILabel!
    @IBOutlet weak var payablesL: UILabel!
    var model:KYOrderInfoModel? {
        didSet {
            if let text = model?.goods_price {
                goodsFeeL.text = "￥" + text + "元"
            }
            if let text = model?.shipping_price {
                postFeeL.text = "￥" + text + "元"
            }
            if let text = model?.shipping_price {
                postFeeL.text = "￥" + text + "元"
            }
            if let text = model?.coupon_price {
                couponFeeL.text = "￥" + text + "元"
            }
            if let text = model?.integral_money {
                ponitsfeeL.text = "￥" + text + "元"
            }
            if let text = model?.user_money {
                balanceL.text = "￥" + text + "元"
            }
            if let text = model?.order_prom_amount {
                order_prom_amountL.text = "￥" + text + "元"
            }
            if let text = model?.total_amount {
                payablesL.text = "￥" + text + "元"
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("KYOrderInfoFootView", owner: self, options: nil)?.first as! UIView
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

}
