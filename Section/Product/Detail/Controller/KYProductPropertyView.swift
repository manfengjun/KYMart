//
//  KYProductPropertyView.swift
//  KYMart
//
//  Created by Jun on 2017/6/7.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
fileprivate let KYPropertyTVCellIdentifier = "kYPropertyTVCell"

class KYProductPropertyView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!

    fileprivate lazy var layout : HXTagCollectionViewFlowLayout = {
        let layout = HXTagCollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        return layout
    }()
    fileprivate lazy var tags : [String] = {
        return ["火游戏影ol游戏","问游戏道","天游戏龙游戏八游戏部","枪神纪游戏"]
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("KYProductPropertyView", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        addSubview(contentView)
        tableView.register(HXTagsCell.classForCoder(), forCellReuseIdentifier: KYPropertyTVCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = footView
        awakeFromNib()
    }
    fileprivate lazy var footView : KYPropertyFootView = {
        let footView = KYPropertyFootView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 50))
        return footView
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
extension KYProductPropertyView:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KYPropertyTVCellIdentifier, for: indexPath) as! HXTagsCell
        cell.tags = tags
        cell.layout = layout
        cell.completion = {(selectTags,currentIndex) in
            print(currentIndex)
            self.tags = selectTags as! [String]
        }
        cell.reloadData()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = HXTagsCell.getHeightWithTags(tags, layout: layout, tagAttribute: nil, width: tableView.frame.size.width)
        return height
    }
}
