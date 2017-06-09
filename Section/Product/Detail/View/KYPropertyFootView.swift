//
//  KYPropertyFootView.swift
//  KYMart
//
//  Created by jun on 2017/6/8.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
class KYPropertyFootView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var buyCountView: UIView!
    @IBOutlet weak var reduceBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var countL: UILabel!
    //闭包类型 回调数据
    var completion:((Int)->())?
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("KYPropertyFootView", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        addSubview(contentView)
        awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        buyCountView.layer.masksToBounds = true
        buyCountView.layer.cornerRadius = 5.0
        buyCountView.layer.borderWidth = 0.5
        buyCountView.layer.borderColor = UIColor.hexStringColor(hex: "#666666").cgColor
    }
    @IBAction func selectAction(_ sender: UIButton) {
        let count = Int(countL.text!)
        if sender.tag == 1 {
            if count == 1 {
                return
            }
            else {
                countL.text = "\(count! - 1)"
            }
        }
        else{
            countL.text = "\(count! + 1)"
        }
        if completion != nil{
            completion!(count!)
        }
    }
}
