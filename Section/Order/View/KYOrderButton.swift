//
//  KYOrderButton.swift
//  KYMart
//
//  Created by jun on 2017/7/11.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYOrderButton: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var button: UIButton!
    
    var SelectResultClosure: ResultValueClosure?     // 闭包

    var textColor:UIColor = UIColor.hexStringColor(hex: "#333333"){
        didSet {
            button.setTitleColor(textColor, for: .normal)
        }
    }
    var title:String = "取消订单"{
        didSet {
            button.setTitle(title, for: .normal)
        }
    }
    var bgColor:UIColor = UIColor.white{
        didSet {
            button.backgroundColor = bgColor
        }
    }
    var borderColor:UIColor = UIColor.hexStringColor(hex: "#333333"){
        didSet {
            layer.borderColor = borderColor.cgColor
            layer.borderWidth = 0.5
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("KYOrderButton", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        addSubview(contentView)
        
        awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.masksToBounds = true
        layer.cornerRadius = 3.0
        button.setTitle(title, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.backgroundColor = bgColor
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = 0.5
        isUserInteractionEnabled = true
    }
    @IBAction func selectAction(_ sender: UIButton) {
        SelectResultClosure?(sender)
    }
    /**
     加减按钮的响应闭包回调
     */
    func selectResult(_ finished: @escaping ResultValueClosure) {
        SelectResultClosure = finished
    }
}
