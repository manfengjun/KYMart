//
//  KYSellListViewController.swift
//  KYMart
//
//  Created by JUN on 2017/6/25.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
fileprivate let KYSellListTVCellIdentifier = "kYSellListTVCell"

class KYBonusListViewController: BaseViewController {
    var userMoney:String?{
        didSet {
            headView.moneyL.text = userMoney
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
    /// 数据源
    var dataArray:[KYBonusListModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    func setupUI() {
        view.addSubview(tableView)
        setBackButtonInNav()
        view.backgroundColor = UIColor.white
        dataRequest()
    }
    func dataRequest(){
        SJBRequestModel.pull_fetchBonusListData { (response, status) in
            if status == 1{
                self.dataArray = response as! [KYBonusListModel]
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
extension KYBonusListViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KYSellListTVCellIdentifier, for: indexPath) as! KYSellListTVCell
        let model = dataArray[indexPath.row]
        cell.bonusModel = model
        if indexPath.row == 0 {
            cell.circleView.backgroundColor = BAR_TINTCOLOR
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
