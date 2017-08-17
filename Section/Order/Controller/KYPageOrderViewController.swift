//
//  KYPageOrderViewController.swift
//  KYMart
//
//  Created by jun on 2017/7/11.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYPageOrderViewController: BaseViewController {
    fileprivate var titleArray:[String] = ["全部","待付款","待发货","待收货","待评价"]
    fileprivate var typeArray:[String] = ["all","WAITPAY","WAITSEND","WAITRECEIVE","WAITCCOMMENT"]
    fileprivate var currentPage = 0
    fileprivate lazy var childvcsArray:[UIViewController] = {
        var childvcsArray:[UIViewController] = []
        for (index,item) in self.titleArray.enumerated() {
            let newListVC = KYOrderListViewController()
            newListVC.dataType = self.typeArray[index]
            childvcsArray.append(newListVC)
        }
        return childvcsArray
    }()
    /// 滚动菜单
    fileprivate lazy var ninaPagerView:NinaPagerView = {
        let ninaPagerView = NinaPagerView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64), withTitles: self.titleArray, withVCs: self.childvcsArray)
        ninaPagerView?.unSelectTitleColor = UIColor.hexStringColor(hex: "#333333")
        ninaPagerView?.selectTitleColor = BAR_TINTCOLOR
        ninaPagerView?.titleFont = 13
        ninaPagerView?.titleScale = 1
        ninaPagerView?.underLineHidden = true
        ninaPagerView?.delegate = self
        ninaPagerView?.ninaPagerStyles = NinaPagerStyle.bottomLine
        return ninaPagerView!
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isTranslucent = false
        view.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector:#selector(refreshAction),name: OrderListRefreshNotification, object: nil)

        setupUI()
    }
    
    func setupUI() {
        navigationItem.title = "订单";
        view.backgroundColor = UIColor.white
        setBackButtonInNav()
        view.addSubview(ninaPagerView)
        
    }
    func refreshAction() {
        let vc = childvcsArray[currentPage] as! KYOrderListViewController
        vc.tableView.mj_header.beginRefreshing()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
extension KYPageOrderViewController:NinaPagerViewDelegate{
    func ninaCurrentPageIndex(_ currentPage: String!, currentObject: Any!) {
        self.currentPage = Int(currentPage)!
        //        let currentNewListVC = currentObject as! SJBNewSListNoViewController
        //        currentNewListVC.title = titleArray[Int(currentPage)!]
        //        currentNewListVC.cid = classIDArray[Int(currentPage)!]
    }
}
