//
//  KYOrderInfoViewController.swift
//  KYMart
//
//  Created by JUN on 2017/7/10.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
fileprivate let KYOrderInfoTVCellIdentifier = "kYOrderInfoTVCell"

class KYOrderInfoViewController: BaseViewController {
    /// 数据源
    fileprivate lazy var dataArray:NSMutableArray = {
        let dataArray = NSMutableArray()
        return dataArray
    }()
    fileprivate lazy var tableViewHeadView : KYOrderInfoHeadView = {
        let tableViewHeadView = KYOrderInfoHeadView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 372))
        return tableViewHeadView
    }()
    fileprivate lazy var tableViewFootView : KYOrderInfoFootView = {
        let tableViewFootView = KYOrderInfoFootView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 155))
        return tableViewFootView
    }()
    /// 列表
    fileprivate lazy var tableView : UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64), style: .grouped)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "KYOrderInfoTVCell", bundle: nil), forCellReuseIdentifier: KYOrderInfoTVCellIdentifier)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = true
        tableView.tableHeaderView = self.tableViewHeadView
        tableView.tableFooterView = self.tableViewFootView

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    func setupUI() {
        view.backgroundColor = UIColor.white
        setBackButtonInNav()
        view.addSubview(tableView)
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
extension KYOrderInfoViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KYOrderInfoTVCellIdentifier, for: indexPath) as! KYOrderInfoTVCell
        
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = KYOrderInfoSectionHeadView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 41))
        return view
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 41
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.hexStringColor(hex: "#DEDEDE", alpha: 0.6)
        return view
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
}
