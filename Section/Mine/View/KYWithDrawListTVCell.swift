//
//  KYWithDrawListTVCell.swift
//  KYMart
//
//  Created by JUN on 2017/6/29.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYWithDrawListTVCell: UITableViewCell {

    @IBOutlet weak var numberL: UILabel!
    @IBOutlet weak var timeL: UILabel!
    @IBOutlet weak var moneyL: UILabel!
    @IBOutlet weak var statusL: UILabel!
    var result:Result?{
        didSet {
            if let text = result?.id {
                numberL.text = "\(text)"
            }
            if let text = result?.create_time {
                timeL.text = "\(text)".timeStampToString()
            }
            if let text = result?.money {
                moneyL.text = "\(text)"
            }
            if let text = result?.status_text {
                statusL.text = "\(text)"
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
