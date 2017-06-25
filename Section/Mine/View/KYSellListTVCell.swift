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
    
    var model:KYSellListModel?{
        didSet {
            if let text = model?.desc {
                contentL.text = text
            }
            if let text = model?.user_money {
                moneyL.text = text
            }
            if let text = model?.change_time {
                timeL.text = String(text).timeStampToString()
            }
        }
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
