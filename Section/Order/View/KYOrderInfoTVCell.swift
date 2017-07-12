//
//  KYOrderInfoTVCell.swift
//  KYMart
//
//  Created by jun on 2017/7/11.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYOrderInfoTVCell: UITableViewCell {
    @IBOutlet weak var productIV: UIImageView!
    @IBOutlet weak var productInfoL: UILabel!
    @IBOutlet weak var productPropertyL: UILabel!
    @IBOutlet weak var moneyL: UILabel!
    @IBOutlet weak var countL: UILabel!
    @IBOutlet weak var statusL: UILabel!
    @IBOutlet weak var totalAmountL: UILabel!
    
    
    var model : Order_Info_Goods_list?{
        didSet {
            if let text = model?.goods_name {
                productInfoL.text = text
            }
            if let text = model?.goods_id {
                let url = imageUrl(goods_id: text)
                productIV.sd_setImage(with: url, placeholderImage: nil)
            }
            if let text = model?.goods_price {
                moneyL.text = "¥\(text)"
            }
            if let text = model?.goods_num {
                countL.text = "X\(text)"
            }
            if let text = model?.spec_key_name {
                productPropertyL.text = text
            }
            if let text = model?.member_goods_price {
                totalAmountL.text = text
            }
        }
    }
    @IBAction func refundAction(_ sender: UIButton) {
        //申请退款
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
