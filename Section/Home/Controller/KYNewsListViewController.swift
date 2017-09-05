//
//  KYNewsViewController.swift
//  KYMart
//
//  Created by jun on 2017/9/5.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import MJRefresh
fileprivate let KYNewsListTVCellIdentifier = "kYNewsListTVCell"

class KYNewsListViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    fileprivate var dataArray: NSMutableArray = NSMutableArray()
    var type:String?{
        didSet{
            self.tableView.mj_header.beginRefreshing()
        }
    }
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
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.mj_header = header
        tableView.mj_footer = footer
        // Do any additional setup after loading the view.
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
        SJBRequestModel.pull_fetchSystemNoticeListData(type: type!, page: page) { (response, status) in
            self.tableView.mj_header.endRefreshing()
            if status == 1 {
                let models = response as! [KYNewsListModel]
                if self.page == 1{
                    self.dataArray.removeAllObjects()
                }
                else
                {
                    if models.count == 0{
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
                if models.count > 0{
                    //去重
                    for item in models {
                        let predicate = NSPredicate(format: "id = %@", String(item.id))
                        let result = self.dataArray.filtered(using: predicate)
                        if result.count <= 0{
                            self.dataArray.add(item)
                        }
                    }
                    
                }
                else
                {
                    self.dataArray.addObjects(from: models)
                }
                self.tableView.reloadData()
            }

        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = sender as! NSIndexPath
        let vc = segue.destination as! KYNewsDetailViewController
        let model = dataArray[indexPath.row] as! KYNewsListModel
        vc.type = type
        vc.id = model.id
    }
}
extension KYNewsListViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: KYNewsListTVCellIdentifier, for: indexPath) as! KYNewsListTVCell
        let model = dataArray[indexPath.row] as! KYNewsListModel
        cell.model = model
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "H_newsdetail_SegueID", sender: indexPath)
    }
}
