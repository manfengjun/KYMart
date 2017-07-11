//
//  KYOrderListHeadView.swift
//  KYMart
//
//  Created by JUN on 2017/7/10.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYOrderListHeadView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var storeNameL: UILabel!
    @IBOutlet weak var orderIdL: UILabel!
    var model:KYOrderListModel?{
        didSet {
            if let text = model?.store_name {
                storeNameL.text = text
            }
            if let text = model?.order_sn {
                orderIdL.text = "订单号：\(text)"
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("KYOrderListHeadView", owner: self, options: nil)?.first as! UIView
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
    


}
