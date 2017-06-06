//
//  KYProductListViewController.swift
//  KYMart
//
//  Created by jun on 2017/6/6.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import MJRefresh
fileprivate let KYProductListCVCellIdentifier = "kYProductListCVCell"

class KYProductListViewController: UIViewController {

    var id:Int? {
        didSet {
            dataRequest()
        }
    }
    fileprivate var productListModel:KYProductListModel?
    /// 数据源
    fileprivate lazy var dataArray:NSMutableArray = {
        let dataArray = NSMutableArray()
        return dataArray
    }()
    //刷新页数
    var page = 1
    /// 上拉刷新
    fileprivate lazy var header:MJRefreshNormalHeader = {
        let header = MJRefreshNormalHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(KYProductListViewController.headerRefresh))
        return header
    }()
    /// 下拉加载
    fileprivate lazy var footer:MJRefreshAutoNormalFooter = {
        let footer = MJRefreshAutoNormalFooter()
        footer.setRefreshingTarget(self, refreshingAction: #selector(KYProductListViewController.footerRefresh))
        return footer
    }()
    /// 商品列表
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.hexStringColor(hex: "#F1F1F1")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(UINib(nibName: "KYProductListCVCell", bundle: nil), forCellWithReuseIdentifier: KYProductListCVCellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func setupUI() {
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        collectionView.mj_header = header
        collectionView.mj_footer = footer
    }
    // 下拉加载
    func headerRefresh() {
        page = 1
        dataRequest()
    }
    
    /// 上拉刷新
    func footerRefresh() {
        page += 1
        dataRequest()
    }
    
    /// 请求数据
    func dataRequest() {
        SJBRequestModel.pull_fetchProductListData(id: id!, page: page, orderby: nil, orderdesc: nil) { (response, status) in
            self.collectionView.mj_header.endRefreshing()

            if status == 1 {
                self.productListModel = response as? KYProductListModel
                if let goods = self.productListModel?.goods_list {
                    if self.page == 1{
                        self.dataArray.removeAllObjects()
                    }
                    else
                    {
                        if goods.count == 0{
                            XHToast.showBottomWithText("没有更多数据")
                            self.page -= 1
                            self.collectionView.mj_footer.endRefreshing()
                            return
                        }
                        else
                        {
                            self.collectionView.mj_footer.endRefreshing()
                        }
                    }
                    if goods.count > 0{
                        //去重
                        for item in (self.productListModel?.goods_list)! {
                            let predicate = NSPredicate(format: "goods_id = %@", String(item.goods_id))
                            let result = self.dataArray.filtered(using: predicate)
                            if result.count <= 0{
                                self.dataArray.add(item)
                            }
                        }
                        
                    }
                    else
                    {
                        self.dataArray.addObjects(from: goods)
                    }
                    self.collectionView.reloadData()

                }
            }

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension KYProductListViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KYProductListCVCellIdentifier, for: indexPath) as! KYProductListCVCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (SCREEN_WIDTH - 15)/2, height: (SCREEN_WIDTH - 15)/2 + 96)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
}
