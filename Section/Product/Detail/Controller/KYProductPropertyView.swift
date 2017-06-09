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
    @IBOutlet weak var productIV: UIImageView!
    @IBOutlet weak var priceL: UILabel!
    @IBOutlet weak var productNumL: UILabel!
    var isLoadData:Bool = false
    var currentTags:NSMutableArray = NSMutableArray()
    var model:KYGoodInfoModel?{
        didSet {
            if !isLoadData {
                if let id = model?.goods.goods_id {
                    productIV.layer.masksToBounds = true
                    productIV.layer.cornerRadius = 5.0
                    productIV.layer.borderColor = UIColor.hexStringColor(hex: "#DEDEDE", alpha: 0.6).cgColor
                    productIV.layer.borderWidth = 0.5
                    productIV.sd_setImage(with: imageUrl(goods_id: id), placeholderImage: nil)
                }
                
                if let text = model?.goods.goods_sn {
                    productNumL.text = "商品编号：\(text)"
                }
                if let text = model?.goods.shop_price {
                    priceL.text = "¥\(text)"
                }
                tableView.reloadData()
                isLoadData = true
            }
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
        tableView.register(HXTagCustomeCell.classForCoder(), forCellReuseIdentifier: KYPropertyTVCellIdentifier)
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
        if let array = model?.goods.goods_spec_list {
            return array.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KYPropertyTVCellIdentifier, for: indexPath) as! HXTagCustomeCell
        cell.layout = layout
        if let goods_spec_list =  model?.goods.goods_spec_list[indexPath.section]{
            cell.goods_spec_list = goods_spec_list
            cell.sectionIndex = indexPath.section
            self.currentTags.add(goods_spec_list.spec_list[0])

        }
        cell.completion = {(selectTags,currentIndex) in
            self.currentTags.replaceObject(at: currentIndex, with: selectTags[0])
            var key:String = ""
            let resultArray = self.currentTags.sortedArray(options: .stable, usingComparator: { (object1, object2) -> ComparisonResult in
                let spec_list1 = object1 as! Spec_list
                let spec_list2 = object2 as! Spec_list

                if spec_list1.item_id > spec_list2.item_id{
                    return ComparisonResult.orderedDescending
                }
                if spec_list1.item_id > spec_list2.item_id{
                    return ComparisonResult.orderedAscending
                }
                return ComparisonResult.orderedSame
            })
            for item in resultArray {
                let spec_list = item as! Spec_list
                key = key.appending("_\(spec_list.item_id)")
            }
            let str = NSString(string: key).substring(from: 1)
            let predicate = NSPredicate(format: "key = %@", str)
            let array = self.model?.spec_goods_price as! NSMutableArray
            let result = array.filtered(using: predicate)
            if result.count > 0{
//                print((result[0] as! Spec_goods_price).yy_modelToJSONString() ?? "")
                let spec_goods_price = result[0] as! Spec_goods_price
                if let text = spec_goods_price.price {
                        self.priceL.text = "¥\(text)"

                }
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let goods_spec_list = model?.goods.goods_spec_list[indexPath.item]

        let height = HXTagCustomeCell.getCellHeight(tags: (goods_spec_list?.spec_list)!, layout: layout, width: tableView.frame.size.width)
        return height
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let goods_spec_list = model?.goods.goods_spec_list[section]
        let view = KYPropertyHeadView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 25))
        view.titleL.text = goods_spec_list?.spec_name
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let sectionHeaderH:CGFloat = 30
        if tableView.contentOffset.y < sectionHeaderH && tableView.contentOffset.y > 0 {
            tableView.contentInset = UIEdgeInsetsMake(-tableView.contentOffset.y, 0, 0, 0)
        }
        else if (tableView.contentOffset.y >= sectionHeaderH){
            tableView.contentInset = UIEdgeInsetsMake(-sectionHeaderH, 0, 0, 0)
        }
    }
}
