//
//  KYSellListTVCell.swift
//  KYMart
//
//  Created by JUN on 2017/6/25.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYSellListTVCell: UITableViewCell {

    @IBOutlet weak var contentL: UILabel!
    @IBOutlet weak var moneyL: UILabel!
    @IBOutlet weak var timeL: UILabel!
    @IBOutlet weak var circleView: UIView!
    
    var sellModel:KYSellListModel?{
        didSet {
            if let text = sellModel?.desc {
                contentL.text = text
            }
            if let text = sellModel?.user_money {
                moneyL.text = text
            }
            if let text = sellModel?.change_time {
                timeL.text = String(text).timeStampToString()
            }
        }
    }
    var bonusModel:KYBonusListModel?{
        didSet {
            if let text = bonusModel?.type_text {
                contentL.text = text
            }
            if let text = bonusModel?.amount {
                moneyL.text = text
            }
            if let text = bonusModel?.create_time {
                timeL.text = String(text).timeStampToString()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        circleView.layer.masksToBounds = true
        circleView.layer.cornerRadius = 4
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
