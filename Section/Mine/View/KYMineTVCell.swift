//
//  KYMineTVCell.swift
//  KYMart
//
//  Created by jun on 2017/6/14.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYMineTVCell: UITableViewCell {

    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var cellIV: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
