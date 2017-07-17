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
    @IBOutlet weak var productIV: UIImageView!
    @IBOutlet weak var productInfoL: UILabel!
    @IBOutlet weak var priceL: UILabel!
    @IBOutlet weak var buyBtn: UIButton!
    @IBOutlet weak var productTypeIV: UIImageView!
    
    var model: Goods_list? {
        didSet {
            if let id = model?.goods_id {
                productIV.sd_setImage(with: imageUrl(goods_id: id), placeholderImage: nil)
            }
            if let text = model?.goods_name {
                productInfoL.text = text
            }
            if let text = model?.shop_price {
                priceL.text = text
            }
            if let text = model?.ky_type {
                switch text {
                case 0:
                    productTypeIV.image = UIImage(named: "product_type_0.png")
                    break
                case 1:
                    productTypeIV.image = UIImage(named: "product_type_1.png")
                    
                    break
                    
                case 3:
                    productTypeIV.image = UIImage(named: "product_type_3.png")
                    
                    break
                    
                default:
                    break
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.white
//        numberView.layer.borderColor = UIColor.hexStringColor(hex: "#ddd9da").cgColor
//        numberView.layer.borderWidth = 0.5
        // Initialization code
    }

}
