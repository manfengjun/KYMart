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

class KYSearchProductListViewController: BaseViewController {
    /// 默认热门排序
    var url:String? {
        didSet {
            page = 1
            dataRequest()
        }
    }
    
    /// 头部标题
    var navTitle:String?{
        didSet {
            navigationItem.title = navTitle
        }
    }
    /// 当前选中
    var currentIndex = 0
    /// 搜索参数
    var kt:Int?
    /// 搜索进入
    var q:String? {
        didSet{
            page = 1
            if let text = kt {
                url = "/index.php/api/Goods/search/q/\(q!)/kt/\(text)"
            }
            else
            {
                url = "/index.php/api/Goods/search/q/\(q!)/sort/is_new/sort_asc/desc"

            }
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
    /// 下拉刷新
    fileprivate lazy var header:MJRefreshNormalHeader = {
        let header = MJRefreshNormalHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(KYProductListViewController.headerRefresh))
        return header
    }()
    /// 上拉加载
    fileprivate lazy var footer:MJRefreshAutoNormalFooter = {
        let footer = MJRefreshAutoNormalFooter()
        footer.setRefreshingTarget(self, refreshingAction: #selector(KYProductListViewController.footerRefresh))
        return footer
    }()
    /// 商品列表
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 40, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.hexStringColor(hex: "#F1F1F1")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(UINib(nibName: "KYProductListCVCell", bundle: nil), forCellWithReuseIdentifier: KYProductListCVCellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    fileprivate lazy var headView : KYProductMenuView = {
        let headView = KYProductMenuView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 40))
        headView.completionSignal?.observeValues({ (index) in
            if let model = self.productListModel {
                if self.currentIndex == index{
                    return
                }
                self.currentIndex = index
                switch index {
                case 1:
                    if let str = model.orderby_is_new {
                        self.url = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    }
                    break
                case 2:
                    if let str = model.orderby_sales_sum {
                        self.url = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    }
                    break
                case 3:
                    if let str = model.orderby_comment_count {
                        self.url = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    }
                    
                    break
                case 4:
                    if let str = model.orderby_price {
                        let array = str.components(separatedBy: "/")
                        self.url = str.replacingOccurrences(of: array.last!, with: "asc").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    }
                    break
                case 5:
                    if let str = model.orderby_price {
                        let array = str.components(separatedBy: "/")
                        self.url = str.replacingOccurrences(of: array.last!, with: "asc").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    }
                    break
                case 6:
                    if let str = model.orderby_price {
                        let array = str.components(separatedBy: "/")
                        self.url = str.replacingOccurrences(of: array.last!, with: "desc").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    }
                    break
                default:
                    break
                }
            }
            
        })
        return headView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        setupUI()
    }
    func setupUI() {
        setLeftButtonInNav(imageUrl: "nav_back.png", action: #selector(back))
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        view.addSubview(headView)
        collectionView.mj_header = header
        collectionView.mj_footer = footer
    }
    func back() {
        self.navigationController?.popViewController(animated: true)
        BackResultClosure?()
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
        SJBRequestModel.pull_fetchProductListData(page: page, url:url!) { (response, status) in
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
extension KYSearchProductListViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KYProductListCVCellIdentifier, for: indexPath) as! KYProductListCVCell
        cell.model = dataArray[indexPath.row] as? Goods_list
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (SCREEN_WIDTH - 30)/2, height: (SCREEN_WIDTH - 30)/2 + 66)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = KYProductDetailViewController()
        let model = dataArray[indexPath.row] as? Goods_list
        detailVC.isSearch = true
        detailVC.id = model?.goods_id
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailVC, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
}
