//
//  KYWithdrawSectionHeadView.swift
//  KYMart
//
//  Created by JUN on 2017/6/29.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYWithdrawSectionHeadView: UIView {

    @IBOutlet var contentView: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("KYWithdrawSectionHeadView", owner: self, options: nil)?.first as! UIView
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
