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
    var specNameArray:[String] = []
    var specItemArray:[[String]] = []
    var model:KYGoodInfoModel? {
        didSet {
            print("sdfs")
            specNameArray.removeAll()
            specItemArray.removeAll()
            if let array = model?.goods.goods_spec_list {
                for item in array {
                    specNameArray.append(item.spec_name)
                    var tagArray:[String] = []
                    for item in item.spec_list {
                        tagArray.append(item.item)
                    }
                    specItemArray.append(tagArray)
                }
            }
            tableView.reloadData()
        }
    }
    fileprivate lazy var layout : HXTagCollectionViewFlowLayout = {
        let layout = HXTagCollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        return layout
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
        let footView = KYPropertyFootView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 40))
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
        return specNameArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KYPropertyTVCellIdentifier, for: indexPath) as! HXTagsCell
        cell.layout = layout
        let array = specItemArray[indexPath.section]
        cell.tags = array
        cell.completion = {(selectTags,currentIndex) in
            print(currentIndex)
//            self.tags = selectTags as! [String]
        }
        cell.reloadData()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let array = specItemArray[indexPath.section]
        let height = HXTagsCell.getHeightWithTags(array, layout: layout, tagAttribute: nil, width: tableView.frame.size.width)
        return height
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return KYPropertyHeadView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 25))
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
}
