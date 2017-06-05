//
//  HomeViewController.swift
//  KYMart
//
//  Created by Jun on 2017/6/4.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
private let KYHomeMenuIdentifier = "kYHomeMenuCVCell"
private let KYProductScrollIdentifier = "kYProductScrollCVCell"
private let KYHomeHeadViewIdentifier = "kYHomeHeadView"
private let KYHomeFootViewIdentifier = "kYHomeFootView"
private let KYHomeSallHeadViewIdentifier = "kYHomeSallHeadView"
private let KYPoductIdentifier = "kYProductCVCell"
private let KYPoductHeadViewIdentifier = "kYProductHeadView"

private let headerIdentifier = "header"
class KYHomeViewController: UIViewController {
    
    var titleArray:[String] = ["全部分类","店铺街","品牌街","优惠活动","团购","我的订单","购物车","个人中心"]
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
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    /// 初始化UI
    func setupUI() {
//        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(collectionView)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: ------ SDCycleScrollViewDelegate
extension KYHomeViewController:SDCycleScrollViewDelegate{

}
extension KYHomeViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        if section == 4 {
            return 20
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
        else if indexPath.section == 4 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KYPoductIdentifier, for: indexPath) as! KYProductCVCell
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KYProductScrollIdentifier, for: indexPath) as! KYProductScrollCVCell
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var resableview = UICollectionReusableView()
        if kind == UICollectionElementKindSectionHeader {
            if indexPath.section == 0 {
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KYHomeHeadViewIdentifier, for: indexPath) as! KYHomeHeadView
                view.images = ["1.jpg","2.jpg"]
                resableview = view
            }
            else if indexPath.section == 4 {
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KYPoductHeadViewIdentifier, for: indexPath) as! KYProductHeadView
                resableview = view
            }
            else {
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KYHomeSallHeadViewIdentifier, for: indexPath) as! KYHomeSallHeadView
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
}
