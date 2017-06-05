//
//  FJSectionHeadView.swift
//  FJTools
//
//  Created by jun on 2017/6/5.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class FJSectionHeadView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleL: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("FJSectionHeadView", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        addSubview(contentView)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
//        titleL.text = "全部>>".verticalString()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
