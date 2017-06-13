//
//  KYCartFootView.swift
//  KYMart
//
//  Created by Jun on 2017/6/11.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYCartFootView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var selectAllBtn: UIButton!
    /// 闭包回调传值
    var SelectAllClosure: BackClosure?     // 闭包

    var cartListModel:KYCartListModel?{
        didSet {
            if let text = cartListModel?.total_price.total_fee {
                totalPrice.text = "¥\(text)元"
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("KYCartFootView", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        addSubview(contentView)
        awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func selectAllAction(_ sender: UIButton) {
        SelectAllClosure?()
    }
    /**
     属性选择闭包回调
     */
    func selectAllResult(_ finished: @escaping BackClosure) {
        SelectAllClosure = finished
    }
}
