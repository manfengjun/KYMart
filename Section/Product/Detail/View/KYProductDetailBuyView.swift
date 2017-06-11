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
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  

}
