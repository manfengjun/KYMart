//
//  FJLeftMenuTVCell.swift
//  FJTools
//
//  Created by jun on 2017/6/5.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class FJLeftMenuTVCell: UITableViewCell {

    @IBOutlet weak var indicateView: UIView!
    @IBOutlet weak var titleL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    func setupUI() {
        selectionStyle = .none
        titleL.highlightedTextColor = UIColor.hexStringColor(hex: "#DE3535")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = selected ? UIColor.hexStringColor(hex: "#F1F1F1") : UIColor.white
        isHighlighted = selected
        indicateView.isHidden = !selected
        titleL.isHighlighted = selected
        // Configure the view for the selected state
    }
    
}
