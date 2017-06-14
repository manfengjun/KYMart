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
    
    /// 是否已加载数据
    var isLoadData:Bool = false
    
    /// 当前选择的标签
//    var currentTags:NSMutableArray = NSMutableArray()
    
    /// 当前的采购数量
//    var currentCount:String = "0"
    
    /// 数据源
    var model:KYGoodInfoModel?{
        didSet {
            if !isLoadData {
                if let id = model?.goods.goods_id {
                    productIV.sd_setImage(with: imageUrl(goods_id: id), placeholderImage: nil)
                }
                
                if let text = model?.goods.goods_sn {
                    productNumL.text = "商品编号：\(text)"
                }
                if let text = SingleManager.instance.productBuyInfoModel?.good_buy_price {
                    priceL.text = "¥\(text)"
                }
                tableView.reloadData()
                isLoadData = true
            }
        }
    }
    
    /// 布局文件
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
    
    /// 底部选择数量
    fileprivate lazy var footView : KYPropertyFootView = {
        let footView = KYPropertyFootView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 40))
        footView.countResult({ (count) in
            SingleManager.instance.productBuyInfoModel?.good_buy_count = count
            //刷新数据
            SingleManager.instance.productBuyInfoModel?.reloadData()
            //通知
            NotificationCenter.default.post(name:SelectProductProperty, object: nil)
        })
        return footView
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // 圆角和边框
        productIV.layer.masksToBounds = true
        productIV.layer.cornerRadius = 5.0
        productIV.layer.borderColor = UIColor.hexStringColor(hex: "#DEDEDE", alpha: 0.6).cgColor
        productIV.layer.borderWidth = 0.5

    }

    @IBAction func addCartAction(_ sender: UIButton) {
        //加入购物车
        if SingleManager.instance.isLogin {
            CartUtil.addCart()
        }
        else
        {
            self.Toast(content: "请先登录")
        }
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
            // 属性数组传值
            cell.goods_spec_list = goods_spec_list
            cell.sectionIndex = indexPath.section
            // 点击选中
            cell.propertyResult({ (selectTags, currentIndex) in
                SingleManager.instance.productBuyInfoModel?.good_buy_propertys[currentIndex].good_buy_spec_list = selectTags[0]
                
                print(SingleManager.instance.productBuyInfoModel?.good_buy_propertys[0].yy_modelToJSONString() ?? "")
                //刷新数据
                SingleManager.instance.productBuyInfoModel?.reloadData()
                
                /// 刷新库存
                self.footView.reloadMaxValue()
                if let text =  SingleManager.instance.productBuyInfoModel?.good_buy_price{
                    self.priceL.text = "¥\(text)"
                }
                //通知
                NotificationCenter.default.post(name:SelectProductProperty, object: nil)
            })
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let goods_spec_list = model?.goods.goods_spec_list[indexPath.item]

        let height = HXTagCustomeCell.getCellHeight(tags: (goods_spec_list?.spec_list)!, layout: layout, width: tableView.frame.size.width)
        return height
    }
     // 头部视图
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let goods_spec_list = model?.goods.goods_spec_list[section]
        let view = KYPropertyHeadView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 25))
        view.titleL.text = goods_spec_list?.spec_name
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    // 去除头部悬停
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
