//
//  KYOrderListViewController.swift
//  KYMart
//
//  Created by JUN on 2017/7/10.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import HMSegmentedControl
fileprivate let KYOrderListCVCellIdentifier = "kYOrderListCVCell"

//fileprivate let KYOrderListTVCellIdentifier = "kYOrderListTVCell"

class KYOrderListViewController: BaseViewController {
    /// 头部标题
    var navTitle:String?{
        didSet {
            navigationItem.title = navTitle
        }
    }
    /// 订单列表
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 40 + 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64 - 40), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib(nibName: "KYOrderListCVCell", bundle: nil), forCellWithReuseIdentifier: KYOrderListCVCellIdentifier)
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        
        collectionView.dataSource = self
        return collectionView
    }()

    
    /// 滚动菜单
    fileprivate lazy var segmentControl : HMSegmentedControl = {
        let segmentControl = HMSegmentedControl(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: 40))
        segmentControl.sectionTitles = ["全部","待付款","待发货","待收货","待评价"]
        segmentControl.backgroundColor = UIColor.clear
        segmentControl.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.hexStringColor(hex: "#666666"),NSFontAttributeName:UIFont.systemFont(ofSize: 14)]
        segmentControl.selectedTitleTextAttributes = [NSForegroundColorAttributeName:BAR_TINTCOLOR,NSFontAttributeName:UIFont.systemFont(ofSize: 14)]
        segmentControl.selectionIndicatorColor = BAR_TINTCOLOR
        segmentControl.selectionStyle = HMSegmentedControlSelectionStyle.fullWidthStripe
        segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocation.down
        segmentControl.selectionIndicatorHeight = 2
        segmentControl.indexChangeBlock = {(index) in
            self.collectionView.contentOffset = CGPoint(x: SCREEN_WIDTH*CGFloat(index), y: 0)
        }
        segmentControl.selectedSegmentIndex = 0
        return segmentControl
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    func setupUI() {
        view.backgroundColor = UIColor.white
        setBackButtonInNav()
        view.addSubview(segmentControl)
        view.addSubview(collectionView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension KYOrderListViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64 - 40)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KYOrderListCVCellIdentifier, for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.01
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.01
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = collectionView.contentOffset.x/SCREEN_WIDTH
        segmentControl.setSelectedSegmentIndex(UInt(index), animated: true)
    }

}
