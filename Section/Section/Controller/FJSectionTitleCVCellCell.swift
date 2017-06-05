//
//  FJSectionTitleCVCellCell.swift
//  FJTools
//
//  Created by jun on 2017/6/5.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class FJSectionTitleCVCellCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.hexStringColor(hex: "#e5e5e5").cgColor
        layer.borderWidth = 0.5
        // Initialization code
    }

}
