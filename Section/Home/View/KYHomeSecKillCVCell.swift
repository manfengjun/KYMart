//
//  KYHomeSecKillCVCell.swift
//  KYMart
//
//  Created by Jun on 2017/6/4.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYHomeSecKillCVCell: UICollectionViewCell {

    @IBOutlet weak var productIV: UIImageView!
    @IBOutlet weak var productInfoL: UILabel!
    @IBOutlet weak var countL: UILabel!
    @IBOutlet weak var buyBtn: UIButton!
    var good:Good?{
        didSet {
            if let id = good?.goods_id {
                productIV.sd_setImage(with: imageUrl(goods_id: id), placeholderImage: nil)
            }
            if let text = good?.goods_name {
                productInfoL.text = text
            }
            if let text = good?.shop_price {
                countL.text = text
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
