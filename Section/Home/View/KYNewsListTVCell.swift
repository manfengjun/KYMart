//
//  KYNewsListTVCell.swift
//  KYMart
//
//  Created by jun on 2017/9/5.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYNewsListTVCell: UITableViewCell {

    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var timeL: UILabel!
    var model:KYNewsListModel?{
        didSet{
            if let text = model?.title {
                titleL.text = text
            }
            else{
                if let text = model?.content {
                    titleL.text = text
                }
            }
            if let text = model?.create_time {
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
