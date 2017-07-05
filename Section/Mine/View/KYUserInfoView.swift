//
//  KYUserInfoView.swift
//  KYMart
//
//  Created by JUN on 2017/7/4.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYUserInfoView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var portraitBgV: UIView!
    @IBOutlet weak var portraitIV: UIImageView!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var recommendL: UILabel!
    @IBOutlet weak var usermoneyL: UILabel!
    @IBOutlet weak var bonusL: UILabel!
    @IBOutlet weak var userTypeL: UILabel!
    @IBOutlet weak var titleL: UILabel!
    var userModel:KYUserInfoModel?{
        didSet {
            if let text = userModel?.nickname {
                nameL.text = text
            }
            if let imgUrl = userModel?.head_pic {
                portraitIV.sd_setImage(with: URL(string: baseHref + imgUrl), placeholderImage: nil)
            }
            if let text = userModel?.bonus {
                bonusL.text = "¥\(text)"
            }
            if let text = userModel?.user_money {
                usermoneyL.text = "¥\(text)"
            }
            if let text = userModel?.ref_nickname {
                recommendL.text = "推荐人:\(text)"
            }
            if let text = userModel?.sell_status {
                userTypeL.text = (text == 0 ? "预备会员" : "开心果")
            }

        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("KYUserInfoView", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        addSubview(contentView)
        awakeFromNib()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView = Bundle.main.loadNibNamed("KYUserInfoView", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        addSubview(contentView)
        awakeFromNib()    }
}
