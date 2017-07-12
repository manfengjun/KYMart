//
//  KYProductDetailViewController.swift
//  KYMart
//
//  Created by jun on 2017/6/7.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import HMSegmentedControl
fileprivate let KYProductListCVCellIdentifier = "kYProductListCVCell"

class KYProductDetailViewController: BaseViewController {


    /// 新闻滚动菜单
    fileprivate lazy var segmentControl : HMSegmentedControl = {
        let segmentControl = HMSegmentedControl(frame: CGRect(x: 100, y: 20, width: SCREEN_WIDTH/2, height: 44))
        segmentControl.sectionTitles = ["商品","详情"]
        segmentControl.backgroundColor = UIColor.clear
        segmentControl.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.hexStringColor(hex: "#666666"),NSFontAttributeName:UIFont.systemFont(ofSize: 12)]
        segmentControl.selectedTitleTextAttributes = [NSForegroundColorAttributeName:UIColor.white,NSFontAttributeName:UIFont.systemFont(ofSize: 12)]
        segmentControl.selectionIndicatorColor = UIColor.white
        segmentControl.selectionStyle = HMSegmentedControlSelectionStyle.fullWidthStripe
        segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocation.down
        segmentControl.selectionIndicatorHeight = 2
        segmentControl.indexChangeBlock = {(index) in
            self.scrollView.contentOffset = CGPoint(x: SCREEN_WIDTH*CGFloat(index), y: 0)
        }
        segmentControl.selectedSegmentIndex = 0
        return segmentControl
    }()
    
    /// 滚动视图
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64))
        scrollView.contentSize = CGSize(width: 2*SCREEN_WIDTH, height: SCREEN_HEIGHT - 64 - 50)
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.delegate = self
        return scrollView
        
    }()
    var id:Int?{
        didSet{
            productInfoVC.id = id
            productContentVC.id = id
        }
    }
    
    /// 详情
    fileprivate lazy var productInfoVC:KYProductDetailHomeViewController = {
        let productInfoVC = KYProductDetailHomeViewController()
        productInfoVC.view.frame = CGRect(x: 0, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
        return productInfoVC
    }()
    
    /// 内容
    fileprivate lazy var productContentVC:KYProductContentViewController = {
        let productContentVC = KYProductContentViewController()
        productContentVC.view.frame = CGRect(x: SCREEN_WIDTH, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
        return productContentVC
    }()
    
    /// 购买菜单
    fileprivate lazy var buyView:KYProductDetailBuyView = {
        let buyView = KYProductDetailBuyView(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 50, width: SCREEN_WIDTH, height: 50))
        buyView.buttonResult({ (index) in
            if let isCanBuy = SingleManager.instance.productBuyInfoModel?.isCanBuy{
                if !isCanBuy {
                    self.Toast(content: "库存不够")
                    return
                }
            }
            if index == 1{
                //加入购物车
                if SingleManager.instance.isLogin {
                    CartUtil.addCart()
                }
                else
                {
                    self.Toast(content: "请先登录")
                }
            }else{
                //立即购买
            }
        })
        return buyView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButtonInNav()

        
        view.backgroundColor = UIColor.white
        view.addSubview(scrollView)
//        let tap = UITapGestureRecognizer(target: self, action: #selector(KYProductDetailViewController.ceshi))
//        scrollView.addGestureRecognizer(tap)
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        scrollView.addSubview(productInfoVC.view)
        addChildViewController(productInfoVC)
        scrollView.addSubview(productContentVC.view)
        addChildViewController(productContentVC)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.view.addSubview(segmentControl)
        UIApplication.shared.keyWindow?.addSubview(buyView)


    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        segmentControl.removeFromSuperview()
        buyView.removeFromSuperview()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension KYProductDetailViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x/SCREEN_WIDTH
        segmentControl.setSelectedSegmentIndex(UInt(index), animated: true)
    }
}
