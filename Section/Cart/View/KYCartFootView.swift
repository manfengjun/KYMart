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

}
