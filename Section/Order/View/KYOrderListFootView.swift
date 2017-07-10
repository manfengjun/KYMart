//
//  KYOrderListFootView.swift
//  KYMart
//
//  Created by JUN on 2017/7/10.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYOrderListFootView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var payBtn: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("KYOrderListFootView", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        addSubview(contentView)
        awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        cancelBtn.layer.masksToBounds = true
        cancelBtn.layer.cornerRadius = 2.0
        cancelBtn.layer.borderWidth = 0.5
        cancelBtn.layer.borderColor = UIColor.hexStringColor(hex: "#333333").cgColor
        payBtn.layer.masksToBounds = true
        payBtn.layer.cornerRadius = 2.0
    }


}
