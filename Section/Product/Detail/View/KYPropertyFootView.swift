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
        buyCountView.layer.borderWidth = 0.5
        buyCountView.layer.borderColor = UIColor.hexStringColor(hex: "#666666").cgColor
    }
}
