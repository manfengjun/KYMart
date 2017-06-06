//
//  FJSectionTitleCVCellCell.swift
//  FJTools
//
//  Created by jun on 2017/6/5.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class FJSectionTitleCVCellCell: UICollectionViewCell {

    @IBOutlet weak var titleL: UILabel!
    var model:Sub_category?{
        didSet {
            if let text = model?.mobile_name{
                titleL.text = text
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.hexStringColor(hex: "#e5e5e5").cgColor
        layer.borderWidth = 0.5
        // Initialization code
    }

}
