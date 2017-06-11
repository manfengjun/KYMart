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
    @IBOutlet weak var selectView: UIView!
    
    fileprivate lazy var selectBtn:PPNumberButton = {
        let selectBtn = PPNumberButton(frame: CGRect(x: 0, y: 0, width: 80, height: 20))
        selectBtn.shakeAnimation = true
        selectBtn._minValue = 1
        selectBtn.maxValue = 100
        selectBtn.borderColor(UIColor.hexStringColor(hex: "#666666"))
        selectBtn.numberResult { (number) in
            
        }
        return selectBtn
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        selectView.addSubview(selectBtn)
                // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
