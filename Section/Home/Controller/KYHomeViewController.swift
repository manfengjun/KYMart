//
//  HomeViewController.swift
//  KYMart
//
//  Created by Jun on 2017/6/4.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import MJRefresh
private let KYHomeMenuIdentifier = "kYHomeMenuCVCell"
private let KYProductScrollIdentifier = "kYProductScrollCVCell"
private let KYHomeHeadViewIdentifier = "kYHomeHeadView"
private let KYHomeFootViewIdentifier = "kYHomeFootView"
private let KYHomeSallHeadViewIdentifier = "kYHomeSallHeadView"
private let KYPoductIdentifier = "kYProductCVCell"
private let KYPoductHeadViewIdentifier = "kYProductHeadView"

private let headerIdentifier = "header"
class KYHomeViewController: UIViewController {
    var sectionCount:Int = 0
    var scrollSectionTitles:[String] = []
    var scrollSectionData:NSMutableArray = NSMutableArray()
    var productArray:[Good] = []
    var homepagemodel:KYHomeModel? {
        didSet {
            if let array = self.homepagemodel?.promotion_goods {
                if array.count > 0 {
                    self.sectionCount += 1
                    self.scrollSectionTitles.append("促销商品")
                    self.scrollSectionData.add(array)
                }
            }
            if let array = self.homepagemodel?.high_quality_goods {
                if array.count > 0 {
                    self.sectionCount += 1
                    self.scrollSectionTitles.append("精品推荐")
                    self.scrollSectionData.add(array)
                }
            }
            if let array = self.homepagemodel?.flash_sale_goods {
                if array.count > 0 {
                    self.sectionCount += 1
                    self.scrollSectionTitles.append("抢购")
                    self.scrollSectionData.add(array)
                }
            }
            if let array = self.homepagemodel?.new_goods {
                if array.count > 0 {
                    self.sectionCount += 1
                    self.scrollSectionTitles.append("新品上市")
                    self.scrollSectionData.add(array)
                }
            }
            if let array = self.homepagemodel?.hot_goods {
                if array.count > 0 {
                    self.sectionCount += 1
                    self.scrollSectionTitles.append("热销商品")
                    self.scrollSectionData.add(array)
                }
            }
            self.sectionCount += 2

        }
    }
    var titleArray:[String] = ["店铺街","品牌街","我的订单","个人中心"]
    //刷新页数
    var page = 1
    /// 列表
    fileprivate lazy var collectionView : UICollectionView = {
        let homeLayout = KYHomeLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64), collectionViewLayout: homeLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.hexStringColor(hex: "#F2F2F2")
        collectionView.register(UINib(nibName:"KYHomeMenuCVCell", bundle:Bundle.main), forCellWithReuseIdentifier: KYHomeMenuIdentifier)
        collectionView.register(UINib(nibName:"KYProductScrollCVCell", bundle:Bundle.main), forCellWithReuseIdentifier: KYProductScrollIdentifier)
        collectionView.register(UINib(nibName:"KYProductCVCell", bundle:Bundle.main), forCellWithReuseIdentifier: KYPoductIdentifier)

        collectionView.register(KYHomeHeadView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KYHomeHeadViewIdentifier)
        collectionView.register(KYHomeFootView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: KYHomeFootViewIdentifier)
        collectionView.register(KYHomeSallHeadView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KYHomeSallHeadViewIdentifier)
        collectionView.register(KYProductHeadView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KYPoductHeadViewIdentifier)

        return collectionView
    }()
    /// 上拉加载
    fileprivate lazy var footer:MJRefreshAutoNormalFooter = {
        let footer = MJRefreshAutoNormalFooter()
        footer.setRefreshingTarget(self, refreshingAction: #selector(KYHomeViewController.footerRefresh))
        return footer
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    /// 初始化UI
    func setupUI() {
        navigationController?.navigationBar.barTintColor = HOME_BAR_TINTCOLOR
        automaticallyAdjustsScrollViewInsets = true
        view.addSubview(collectionView)
        collectionView.mj_footer = footer
        dataHomeRequest()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - 数据请求
extension KYHomeViewController {
    /// 促销、热门、推荐、轮播等
    func dataHomeRequest() {
        SJBRequestModel.pull_fetchHomePageData { (response, status) in
            if status == 1{
                
                self.dataProductRequest()
                self.homepagemodel = response as? KYHomeModel
            }
        }
    }
    
    /// 猜我喜欢
    func dataProductRequest() {
        SJBRequestModel.pull_fetchFavoriteProductData(page: self.page) { (response, status) in
            self.collectionView.mj_footer.endRefreshing()
            if status == 1{
//                var currentArray = NSMutableArray()
//                currentArray = self.productArray as! NSMutableArray
                if response.count == 0 {
                    XHToast.showBottomWithText("没有更多数据")
                    self.page -= 1

                    return
                }
                if self.productArray.count > 0 {
                    //去重
                    for item in response as! Array<Good> {
                        let predicate = NSPredicate(format: "goods_id = %@", String(item.goods_id))
                        let array = self.productArray as! NSMutableArray
                        let result = array.filtered(using: predicate)
                        if result.count <= 0{
                            self.productArray.append(item)
                        }
                    }
                }
                else{
                    self.productArray = response as! [Good]
                }
                self.collectionView.reloadData()
                
            }
        }
    }
    
    /// 上拉加载
    func footerRefresh() {
        page += 1
        dataProductRequest()
    }

}
// MARK: ------ 轮播图片
extension KYHomeViewController:SDCycleScrollViewDelegate{

}

// MARK: - 数据列表
extension KYHomeViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionCount
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        }
        else if section == sectionCount - 1 {
            return productArray.count
        }
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KYHomeMenuIdentifier, for: indexPath) as! KYHomeMenuCVCell
            cell.menutitleL.text = titleArray[indexPath.row]
            cell.menuIV.image = UIImage(named: "home_menu_\(indexPath.row + 1)")
            return cell
        }
        if indexPath.section == sectionCount - 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KYPoductIdentifier, for: indexPath) as! KYProductCVCell
            cell.good = productArray[indexPath.row]
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KYProductScrollIdentifier, for: indexPath) as! KYProductScrollCVCell
            let models = scrollSectionData[indexPath.section - 1] as? [Good]
            cell.models = models
            cell.selectResult({ 
                let detailVC = KYProductDetailViewController()
                let model = models?[indexPath.row]
                detailVC.id = model?.goods_id
                self.navigationController?.pushViewController(detailVC, animated: true)
            })
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var resableview = UICollectionReusableView()
        if kind == UICollectionElementKindSectionHeader {
            if indexPath.section == 0 {
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KYHomeHeadViewIdentifier, for: indexPath) as! KYHomeHeadView
                if let images = homepagemodel?.ad {
                    view.images = images
                }
                resableview = view
            }
            else if indexPath.section == sectionCount - 1 {
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KYPoductHeadViewIdentifier, for: indexPath) as! KYProductHeadView
                resableview = view
            }
            else {
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KYHomeSallHeadViewIdentifier, for: indexPath) as! KYHomeSallHeadView
                view.titleL.text = scrollSectionTitles[indexPath.section - 1]
                resableview = view
            }
            
        }
        else
        {
            
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: KYHomeFootViewIdentifier, for: indexPath) as! KYHomeFootView
            resableview = view

        }
        return resableview
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == sectionCount - 1 {
            let detailVC = KYProductDetailViewController()
            let model = productArray[indexPath.row]
            detailVC.id = model.goods_id
            self.navigationController?.pushViewController(detailVC, animated: true)

        }
//        let detailVC = KYProductDetailViewController()
//        let model = dataArray[indexPath.row] as? Goods_list
//        detailVC.id = model?.goods_id
//        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
