//
//  KYSellListViewController.swift
//  KYMart
//
//  Created by JUN on 2017/6/25.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import MJRefresh
fileprivate let KYSellListTVCellIdentifier = "kYSellListTVCell"

class KYSellListViewController: BaseViewController {
    var bonusMoney:String?{
        didSet {
            headView.moneyL.text = bonusMoney
        }
    }
    
    var navTitle:String?{
        
        didSet {
            self.navigationItem.title = navTitle
        }
    }

    /// 列表
    fileprivate lazy var tableView : UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "KYSellListTVCell", bundle: nil), forCellReuseIdentifier: KYSellListTVCellIdentifier)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = self.headView
        return tableView
    }()
    fileprivate lazy var headView:KYMoneyManagerView = {
        let headView = KYMoneyManagerView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 100))
        return headView
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
    //刷新页数
    var page = 1

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
    func setupUI() {
        view.addSubview(tableView)
        setBackButtonInNav()
        view.backgroundColor = UIColor.white
        tableView.mj_header = header
        tableView.mj_footer = footer
        dataRequest()
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

    func dataRequest(){
        SJBRequestModel.pull_fetchSellListData(page: page) { (response, status) in
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
                    for item in response as! [KYSellListModel] {
                        let predicate = NSPredicate(format: "log_id = %@", String(item.log_id))
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
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension KYSellListViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KYSellListTVCellIdentifier, for: indexPath) as! KYSellListTVCell
        let model = dataArray[indexPath.row]
        cell.sellModel = model as? KYSellListModel
        cell.circleView.backgroundColor = UIColor.hexStringColor(hex: "#666666")
        if indexPath.row == 0 {
            cell.circleView.backgroundColor = BAR_TINTCOLOR
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
