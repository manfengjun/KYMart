//
//  KYOrderSectionHeadView.swift
//  KYMart
//
//  Created by JUN on 2017/7/8.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYOrderSectionHeadView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var storeNameL: UILabel!
    
    var model:OrderStoreList?{
        didSet {
            if let text = model?.store_name {
                storeNameL.text = text
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("KYOrderSectionHeadView", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        addSubview(contentView)
        awakeFromNib()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
