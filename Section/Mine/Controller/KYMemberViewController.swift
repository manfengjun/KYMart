//
//  KYMemberViewController.swift
//  KYMart
//
//  Created by JUN on 2017/7/4.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import MJRefresh
fileprivate let KYMemberTVCellIdentifier = "kYMemberTVCell"

class KYMemberViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
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
    fileprivate lazy var dataArray:NSMutableArray = {
        let dataArray = NSMutableArray()
        return dataArray
    }()
    fileprivate lazy var tableViewHeadView : KYUserInfoView = {
        let tableViewHeadView = KYUserInfoView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH*3/5 + 51))
        tableViewHeadView.userModel = SingleManager.instance.userInfo
        return tableViewHeadView
    }()
    //刷新页数
    var page = 1
    fileprivate var memberModel:KYMemberModel?{
        didSet {
            tableView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.subviews[0].alpha = 0
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.subviews[0].alpha = 1
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    func setupUI() {
        setBackButtonInNav()
        view.backgroundColor = UIColor.white
        tableView.tableHeaderView = tableViewHeadView
        tableView.mj_header = header
        tableView.mj_footer = footer
        dataRequest()
    }
    func dataRequest(){
        SJBRequestModel.pull_fetchShareMemberData(page: page) { (response, status) in
            self.tableView.mj_header.endRefreshing()
            if status == 1 {
                let model = response as! KYMemberModel
                self.memberModel = model
                if self.page == 1{
                    self.dataArray.removeAllObjects()
                }
                else
                {
                    if model.list.count == 0{
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
                    for item in model.list {
                        let predicate = NSPredicate(format: "user_id = %@", String(item.user_id))
                        let result = self.dataArray.filtered(using: predicate)
                        if result.count <= 0{
                            self.dataArray.add(item)
                        }
                    }
                    
                }
                else
                {
                    self.dataArray.addObjects(from: model.list!)
                }
                self.tableView.reloadData()
            }
        }
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension KYMemberViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KYMemberTVCellIdentifier, for: indexPath) as! KYMemberTVCell
        cell.model = dataArray[indexPath.row] as! List
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
