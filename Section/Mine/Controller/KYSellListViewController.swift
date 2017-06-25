//
//  KYSellListViewController.swift
//  KYMart
//
//  Created by JUN on 2017/6/25.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
fileprivate let KYSellListTVCellIdentifier = "kYSellListTVCell"

class KYSellListViewController: UIViewController {
    /// 列表
    fileprivate lazy var tableView : UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "KYSellListTVCell", bundle: nil), forCellReuseIdentifier: KYSellListTVCellIdentifier)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    /// 数据源
    var dataArray:[KYSellListModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func setupUI() {
        view.addSubview(tableView)
    }
    func dataRequest(){
        SJBRequestModel.pull_fetchSellListData { (response, status) in
            if status == 1{
                self.dataArray = response as! [KYSellListModel]
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
        cell.model = model
        return cell
    }
}
