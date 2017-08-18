//
//  KYProduceSectionListViewController.swift
//  KYMart
//
//  Created by jun on 2017/8/18.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
fileprivate let KYProductListCVCellIdentifier = "kYProductListCVCell"
fileprivate let KYHomeSallHeadViewIdentifier = "kYHomeSallHeadView"

class KYProduceSectionListViewController: BaseViewController {
    var url:String?{
        didSet{
            SJBRequestModel.pull_fetchProductSectionListData(url: url!) { (response, status) in
                if status == 1{
                    self.dataArray = response as! NSMutableArray
                    self.collectionView.reloadData()
                }
            }
        }
    }
    /// 头部标题
    var navTitle:String?{
        didSet {
            navigationItem.title = navTitle
        }
    }
    /// 商品列表
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.hexStringColor(hex: "#F1F1F1")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(UINib(nibName: "KYProductListCVCell", bundle: nil), forCellWithReuseIdentifier: KYProductListCVCellIdentifier)
        collectionView.register(KYHomeSallHeadView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KYHomeSallHeadViewIdentifier)

        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    /// 数据源
    fileprivate lazy var dataArray:NSMutableArray = {
        let dataArray = NSMutableArray()
        return dataArray
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    /// 页面初始化
    func setupUI() {
        setBackButtonInNav()
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension KYProduceSectionListViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataArray.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let model = dataArray[section] as! KYProductSectionListModel
        if let array = model.item {
            return array.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KYProductListCVCellIdentifier, for: indexPath) as! KYProductListCVCell
        let sectionModel = dataArray[indexPath.section] as! KYProductSectionListModel
        if let array = sectionModel.item {
            cell.model = array[indexPath.row]
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var resableview = UICollectionReusableView()
        if kind == UICollectionElementKindSectionHeader {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KYHomeSallHeadViewIdentifier, for: indexPath) as! KYHomeSallHeadView
            let model = dataArray[indexPath.section] as! KYProductSectionListModel
            if let text = model.mobile_name {
                view.titleL.text = text;
            }
            view.moreBtn.isHidden = true;
            if let text = model.more_url {
                if text.characters.count > 0 {
                    view.moreBtn.isHidden = false;
                    view.selectResult {
                        let listVC = KYProductSectionMoreListViewController()
                        listVC.url = model.more_url
                        listVC.navTitle = model.mobile_name
                        self.navigationController?.pushViewController(listVC, animated: true)
                    }
                }
            }
            resableview = view
        }
        return resableview
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: 40)
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
        let model = dataArray[indexPath.section] as! KYProductSectionListModel
        if let array = model.item {
            let model = array[indexPath.row]
            detailVC.id = model.goods_id
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

