//
//  KYShopAddressTVCell.swift
//  KYMart
//
//  Created by Jun on 2017/6/14.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
fileprivate let KYShopAddressTVCellIdentifier = "kYShopAddressTVCell"

class KYShopAddressTVCell: UITableViewCell {
//    fileprivate lazy var tableView : UITableView = {
//        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH/4, height: SCREEN_HEIGHT - 113), style: .plain)
//        tableView.showsVerticalScrollIndicator = false
//        tableView.separatorStyle = .none
//        tableView.register(UINib(nibName: "FJLeftMenuTVCell", bundle: nil), forCellReuseIdentifier: LeftMenuTVCellIdentifier)
//        tableView.backgroundColor = UIColor.white
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.bounces = false
//        return tableView
//    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
