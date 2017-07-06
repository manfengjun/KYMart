//
//  KYOrderViewController.swift
//  KYMart
//
//  Created by JUN on 2017/7/5.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
fileprivate let KYOrderTVCellIdentifier = "kYOrderTVCell"

class KYOrderViewController: BaseViewController {

    @IBOutlet var headView: UIView!
    @IBOutlet var footView: UIView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    func setupUI() {
        setBackButtonInNav()
        headView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 80)
        footView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 315)
        tableView.tableHeaderView = headView
        tableView.tableFooterView = footView
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension KYOrderViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KYOrderTVCellIdentifier, for: indexPath) as! KYOrderTVCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 198
    }
}
