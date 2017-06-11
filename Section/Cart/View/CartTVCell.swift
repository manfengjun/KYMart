//
//  CartTVCell.swift
//  KYMart
//
//  Created by Jun on 2017/6/11.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import PPNumberButtonSwift
class CartTVCell: UITableViewCell {

    @IBOutlet weak var selectIV: UIImageView!
    @IBOutlet weak var productIV: UIImageView!
    @IBOutlet weak var productInfoL: UILabel!
    @IBOutlet weak var productPriceL: UILabel!
    @IBOutlet weak var selectBtn: PPNumberButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectBtn.shakeAnimation = true
        selectBtn._minValue = 1
        selectBtn.maxValue = (SingleManager.instance.productBuyInfoModel?.good_buy_store_count)!
        selectBtn.borderColor(UIColor.hexStringColor(hex: "#666666"))
        selectBtn.numberResult { (number) in
            
        }
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
