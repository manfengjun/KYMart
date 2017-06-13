//
//  CartTVCell.swift
//  KYMart
//
//  Created by Jun on 2017/6/11.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import PPNumberButtonSwift
class CartTVCell: UITableViewCell {

    @IBOutlet weak var selectIV: UIImageView!
    @IBOutlet weak var productIV: UIImageView!
    @IBOutlet weak var productInfoL: UILabel!
    @IBOutlet weak var productPriceL: UILabel!
    @IBOutlet weak var selectView: UIView!
    @IBOutlet weak var selectBtn: UIButton!
    var btnSelected:Bool = false
    /// 闭包回调传值
    var CartChangeClosure: CartChangeClosure?     // 闭包

    fileprivate lazy var selectNumBtn:PPNumberButton = {
        let selectNumBtn = PPNumberButton(frame: CGRect(x: 0, y: 0, width: 80, height: 20))
        selectNumBtn.shakeAnimation = true
        selectNumBtn._minValue = 1
        selectNumBtn.maxValue = 100
        selectNumBtn.borderColor(UIColor.hexStringColor(hex: "#666666"))
        selectNumBtn.numberResult { (number) in
            self.cartForm?.goodsNum = number
            self.CartChangeClosure?(self.cartForm!)
        }
        return selectNumBtn
    }()
    var cartForm:KYCartFormModel?
    var model:CartList?{
        didSet {
            if let id = model?.goods_id {
                if let text = Int(id) {
                    productIV.sd_setImage(with: imageUrl(goods_id: text), placeholderImage: nil)
                }
                
            }
            if let text = model?.goods_name {
                productInfoL.text = text
            }
            if let text = model?.goods_price {
                productPriceL.text = "¥\(text)元"
            }
            if let text = model?.store_count {
                selectNumBtn.maxValue = Int(text)!
            }
            if let text = model?.goods_num {
                selectNumBtn.currentNumber = text
            }
            btnSelected = model?.selected == "1" ? true : false
            selectBtn.setImage(btnSelected ? UIImage(named: "cart_select_yes") : UIImage(named: "cart_select_no"), for: .normal)
            // 初始化购物车
            cartForm = KYCartFormModel()
            cartForm?.cartID = model?.id
            cartForm?.goodsNum = model?.goods_num
            cartForm?.storeCount = model?.store_count
            cartForm?.selected = model?.selected
        }
    }
    
    @IBAction func selectAction(_ sender: UIButton) {
        btnSelected = btnSelected ? false : true
        self.cartForm?.selected = btnSelected ? "1" : "0"
        self.CartChangeClosure?(self.cartForm!)

    }
    /**
     属性选择闭包回调
     */
    func cartChangeResult(_ finished: @escaping CartChangeClosure) {
        CartChangeClosure = finished
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectView.addSubview(selectNumBtn)
                // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
