//
//  KYOrderListTVCell.swift
//  KYMart
//
//  Created by JUN on 2017/7/10.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYOrderListTVCell: UITableViewCell {

    var model : Order_Goods_list?{
        didSet {
            if let text = model?.goods_name {
                productInfoL.text = text
            }
            if let text = model?.goods_id {
                if let id = Int(text) {
                    let url = imageUrl(goods_id: id)
                    productIV.sd_setImage(with: url, placeholderImage: nil)
                }
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
        }
    }
    @IBOutlet weak var productIV: UIImageView!
    @IBOutlet weak var productInfoL: UILabel!
    @IBOutlet weak var productPropertyL: UILabel!
    @IBOutlet weak var moneyL: UILabel!
    @IBOutlet weak var countL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
