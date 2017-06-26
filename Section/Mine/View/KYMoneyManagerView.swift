//
//  KYMoneyManagerView.swift
//  KYMart
//
//  Created by JUN on 2017/6/26.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYMoneyManagerView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var moneyL: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("KYMoneyManagerView", owner: self, options: nil)?.first as! UIView
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
