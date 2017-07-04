//
//  KYMemberTVCell.swift
//  KYMart
//
//  Created by JUN on 2017/7/4.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYMemberTVCell: UITableViewCell {

    @IBOutlet weak var headIV: UIImageView!
    @IBOutlet weak var nickNameL: UILabel!
    @IBOutlet weak var phoneL: UILabel!
    @IBOutlet weak var timeL: UILabel!
    @IBOutlet weak var userIDL: UILabel!
    
    var model:List? {
        didSet {
            if let text = model?.head_pic {
                if text.hasSuffix("http") {
                    let imageUrl = URL(string: text)
                    headIV.sd_setImage(with: imageUrl, placeholderImage: nil)
                }
                else{
                    let imageUrl = URL(string: imgPath + text)
                    headIV.sd_setImage(with: imageUrl, placeholderImage: nil)
                }
            }
            if let text = model?.nickname {
                nickNameL.text = "昵称：" + text
            }
            if let text = model?.reg_time {
                timeL.text = "加盟时间：" + String(text).timeStampToString()

            }
            if let text = model?.user_id {
                userIDL.text = "会员ID：\(text)"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
