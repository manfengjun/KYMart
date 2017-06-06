//
//  FJSectionRowHeadView.swift
//  KYMart
//
//  Created by Jun on 2017/6/5.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class FJSectionRowHeadView: UICollectionReusableView {

    @IBOutlet var contentView: UICollectionReusableView!
    @IBOutlet weak var titleL: UILabel!
    var model:FJSubSectionModel?{
        didSet {
            if let text = model?.mobile_name{
                titleL.text = text
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("FJSectionRowHeadView", owner: self, options: nil)?.first as! UICollectionReusableView
        contentView.frame = self.bounds
        addSubview(contentView)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
