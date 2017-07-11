//
//  KYOrderListViewController.swift
//  KYMart
//
//  Created by JUN on 2017/7/10.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import MJRefresh
fileprivate let KYOrderListTVCellIdentifier = "kYOrderListTVCell"

//fileprivate let KYOrderListTVCellIdentifier = "kYOrderListTVCell"

class KYOrderListViewController: BaseViewController {
    /// 头部标题
    var dataType:String?{
        didSet {
            
        }
    }
    /// 列表
    fileprivate lazy var tableView : UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64 - 40), style: .grouped)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "KYOrderListTVCell", bundle: nil), forCellReuseIdentifier: KYOrderListTVCellIdentifier)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = true
        return tableView
    }()
    /// 下拉刷新
    fileprivate lazy var header:MJRefreshNormalHeader = {
        let header = MJRefreshNormalHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        return header
    }()
    /// 上拉加载
    fileprivate lazy var footer:MJRefreshAutoNormalFooter = {
        let footer = MJRefreshAutoNormalFooter()
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        return footer
    }()
    /// 刷新页数
    var page = 1
    /// 数据源
    fileprivate lazy var dataArray:NSMutableArray = {
        let dataArray = NSMutableArray()
        return dataArray
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        dataRequest()
        // Do any additional setup after loading the view.
    }
    func setupUI() {
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        tableView.mj_header = header
        tableView.mj_footer = footer
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
    
    func dataRequest() {
        if let user_id = SingleManager.instance.loginInfo?.user_id {
            SJBRequestModel.pull_fetchOrderListData(page: page,user_id: user_id, type: dataType!, completion: { (response, status) in
                self.tableView.mj_header.endRefreshing()
                if status == 1 {
                    if self.page == 1{
                        self.dataArray.removeAllObjects()
                    }
                    else
                    {
                        if response.count == 0{
                            XHToast.showBottomWithText("没有更多数据")
                            self.page -= 1
                            self.tableView.mj_footer.endRefreshing()
                            return
                        }
                        else
                        {
                            self.tableView.mj_footer.endRefreshing()
                        }
                    }
                    if self.dataArray.count > 0{
                        //去重
                        for item in response as! [KYOrderListModel] {
                            let predicate = NSPredicate(format: "order_id = %@", String(item.order_id))
                            let result = self.dataArray.filtered(using: predicate)
                            if result.count <= 0{
                                self.dataArray.add(item)
                            }
                        }
                        
                    }
                    else
                    {
                        self.dataArray.addObjects(from: response as! [Any])
                    }
                    self.tableView.reloadData()
                }

            })
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension KYOrderListViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let orderModel = dataArray[section] as! KYOrderListModel
        if let array = orderModel.goods_list{
            return array.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KYOrderListTVCellIdentifier, for: indexPath) as! KYOrderListTVCell
        let orderModel = dataArray[indexPath.section] as! KYOrderListModel
        if let array = orderModel.goods_list{
            cell.model = array[indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = KYOrderListHeadView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 100))
        let orderModel = dataArray[section] as! KYOrderListModel
        view.model = orderModel
        return view
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104.5
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = KYOrderListFootView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 106))
        let orderModel = dataArray[section] as! KYOrderListModel
        view.model = orderModel
        return view
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 111
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noneVC = KYOrderInfoViewController()
        self.navigationController?.pushViewController(noneVC, animated: true)
    }
}
