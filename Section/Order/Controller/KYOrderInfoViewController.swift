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
    var order_id:String?{
        didSet {
            dataRequest()
        }
    }
    var buttonArray:[KYOrderButton] = []
    fileprivate lazy var menuView : UIView = {
        let menuView = UIView(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 50, width: SCREEN_WIDTH, height: 50))
        menuView.backgroundColor = UIColor.hexStringColor(hex: "#DEDEDE", alpha: 1)
        return menuView
    }()
    /// 数据源
    fileprivate var orderInfoModel:KYOrderInfoModel?{
        didSet {
            tableViewHeadView.model = orderInfoModel
            tableViewFootView.model = orderInfoModel
            if let text = orderInfoModel?.pay_btn {
                if text == 1 {
                    let button = KYOrderButton(frame: CGRect(x: 0, y: 0, width: 80, height: 25))
                    button.title = "立即付款"
                    button.bgColor = BAR_TINTCOLOR
                    button.borderColor = BAR_TINTCOLOR
                    button.textColor = UIColor.white
                    buttonArray.append(button)
                }
            }
            if let text = orderInfoModel?.cancel_btn {
                if text == 1 {
                    let button = KYOrderButton(frame: CGRect(x: 0, y: 0, width: 80, height: 25))
                    button.title = "取消订单"
                    buttonArray.append(button)
                    
                }
            }
            if let text = orderInfoModel?.receive_btn {
                if text == 1 {
                    let button = KYOrderButton(frame: CGRect(x: 0, y: 0, width: 80, height: 25))
                    button.title = "确认收货"
                    buttonArray.append(button)
                    
                }
            }
            if let text = orderInfoModel?.shipping_btn {
                if text == 1 {
                    let button = KYOrderButton(frame: CGRect(x: 0, y: 0, width: 80, height: 25))
                    button.title = "查看物流"
                    buttonArray.append(button)
                    
                }
            }
            if let text = orderInfoModel?.return_btn {
                if text == 1 {
                    let button = KYOrderButton(frame: CGRect(x: 0, y: 0, width: 80, height: 25))
                    button.title = "退货"
                    buttonArray.append(button)
                    
                }
            }
            for (index,item) in buttonArray.enumerated() {
                item.frame = CGRect(x: SCREEN_WIDTH - 15 - CGFloat(80*(index + 1)) - CGFloat(10*index), y: 12.5, width: 80, height: 25)
                menuView.addSubview(item)
            }
            tableView.reloadData()
        }
    }
    
    /// 头视图
    fileprivate lazy var tableViewHeadView : KYOrderInfoHeadView = {
        let tableViewHeadView = KYOrderInfoHeadView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 372))
        tableViewHeadView.showShipResult({
            let shipVC = KYOrderShipViewController()
            shipVC.order_id = self.orderInfoModel?.order_id
            self.navigationController?.pushViewController(shipVC, animated: true)

        })
        return tableViewHeadView
    }()
    
    /// 尾部视图
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
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
        return tableView
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.keyWindow?.addSubview(menuView)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        menuView.removeFromSuperview()
    }
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
    
    func dataRequest() {
        if let text = SingleManager.instance.loginInfo?.user_id {
            SJBRequestModel.pull_fetchOrderInfoData(id: order_id!, user_id: text, completion: { (response, status) in
                if status == 1 {
                    self.orderInfoModel = response as? KYOrderInfoModel
                }
            })
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
extension KYOrderInfoViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = orderInfoModel?.goods_list{
            return array.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KYOrderInfoTVCellIdentifier, for: indexPath) as! KYOrderInfoTVCell
        if let array = orderInfoModel?.goods_list {
            cell.model = array[indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = KYOrderInfoSectionHeadView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 41))
        view.model = orderInfoModel
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
