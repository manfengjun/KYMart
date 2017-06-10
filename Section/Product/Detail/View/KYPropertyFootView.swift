//
//  KYPropertyFootView.swift
//  KYMart
//
//  Created by jun on 2017/6/8.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import PPNumberButtonSwift

class KYPropertyFootView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var numberButton: PPNumberButton!
    var CountResultClosure: ResultClosure?     // 闭包
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("KYPropertyFootView", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        addSubview(contentView)
        awakeFromNib()
    }
    func reloadMaxValue(){
        numberButton.maxValue = (SingleManager.instance.productBuyInfoModel?.good_buy_store_count)!
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        numberButton.shakeAnimation = true
        numberButton._minValue = 1
        numberButton.maxValue = (SingleManager.instance.productBuyInfoModel?.good_buy_store_count)!
        numberButton.borderColor(UIColor.hexStringColor(hex: "#666666"))
        numberButton.numberResult { (number) in
            if let count = Int(number){
                self.CountResultClosure?(count)
            }
        }
    }
    /**
     加减按钮的响应闭包回调
     */
    func countResult(_ finished: @escaping ResultClosure) {
        CountResultClosure = finished
    }
}
