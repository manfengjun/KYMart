//
//  KYProductDetailBuyView.swift
//  KYMart
//
//  Created by Jun on 2017/6/11.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYProductDetailBuyView: UIView {

    @IBOutlet var contentView: UIView!
    /// 闭包回调传值
    var ButtonResultClosure: ResultClosure?     // 闭包
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("KYProductDetailBuyView", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        addSubview(contentView)
        awakeFromNib()

    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func buyAction(_ sender: UIButton) {
        ButtonResultClosure?(sender.tag)
    }
    /**
     属性选择闭包回调
     */
    func buttonResult(_ finished: @escaping ResultClosure) {
        ButtonResultClosure = finished
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  

}
