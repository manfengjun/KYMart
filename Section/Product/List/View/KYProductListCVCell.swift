//
//  KYProductListCVCell.swift
//  KYMart
//
//  Created by jun on 2017/6/6.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYProductListCVCell: UICollectionViewCell {

    @IBOutlet weak var numberView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.white
        numberView.layer.borderColor = UIColor.hexStringColor(hex: "#ddd9da").cgColor
        numberView.layer.borderWidth = 0.5
        // Initialization code
    }

}
