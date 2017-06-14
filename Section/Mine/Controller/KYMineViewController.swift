//
//  KYMineViewController.swift
//  KYMart
//
//  Created by jun on 2017/6/14.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYMineViewController: UIViewController {

    @IBOutlet var headView: UIView!
    @IBOutlet weak var portraitBgV: UIView!
    @IBOutlet weak var portraitIV: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var recommendL: UILabel!
    var userInfoModel:KYUserInfoModel?{
        didSet {
            tableView.reloadData()
        }
    }
    fileprivate var titleData:NSMutableDictionary = ["0":["余额","分享奖金"],"1":["全部订单","账户明细","奖金明细"],"2":["收货地址","设置"]]
    fileprivate var imageData:NSMutableDictionary = ["0":["mine_1.png","mine_2.png"],"1":["mine_3.png","mine_4.png","mine_5.png"],"2":["mine_6.png","mine_7.png"]]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        dataRequest()
        // Do any additional setup after loading the view.
    }
    func setupUI() {
        portraitBgV.layer.masksToBounds = true
        portraitBgV.layer.cornerRadius = SCREEN_WIDTH/10
        portraitIV.layer.masksToBounds = true
        portraitIV.layer.cornerRadius = (SCREEN_WIDTH*1/5 - 6)/2
        headView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH*3/5 )
        tableView.tableHeaderView = headView
        navigationController?.navigationBar.subviews[0].alpha = 0
        navigationController?.navigationBar.isTranslucent = true
        tableView.backgroundColor = UIColor.hexStringColor(hex: "#F2F2F2")

    }
    func dataRequest() {
        SJBRequestModel.pull_fetchUserInfoData { (response, status) in
            if status == 1{
                self.userInfoModel = response as? KYUserInfoModel
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension KYMineViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleData.allKeys.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let str = titleData.allKeys[section]
        let array = titleData[str] as! [String]
        return array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kYMineTVCell", for: indexPath) as! KYMineTVCell
//        cell.titleL.textColor = UIColor.hexStringColor(hex: "#333333")
//
//        if indexPath.section == 0 {
//            cell.titleL.textColor = BAR_TINTCOLOR
//        }
        let str = titleData.allKeys[indexPath.section]
        let array = titleData[str]as! [String]
        let url = imageData.allKeys[indexPath.section]
        let imageArray = imageData[url]as! [String]
        cell.cellIV.image = UIImage(named:imageArray[indexPath.row])
        cell.titleL.text = array[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.hexStringColor(hex: "#F2F2F2")
        return view
    }
}
