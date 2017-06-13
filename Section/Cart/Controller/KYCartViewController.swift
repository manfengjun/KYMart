//
//  KYCartViewController.swift
//  KYMart
//
//  Created by Jun on 2017/6/10.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
fileprivate let CartTVCellIdentifier = "cartTVCell"

class KYCartViewController: UIViewController {
    var CountResultClosure: ResultClosure?     // 闭包

    /// 底部按钮
    fileprivate lazy var bottomView:KYCartFootView = {
        let bottomView = KYCartFootView(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 50 - 49, width: SCREEN_WIDTH, height: 50))
        return bottomView
    }()
    /// 列表
    fileprivate lazy var tableView : UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 113), style: .plain)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "CartTVCell", bundle: nil), forCellReuseIdentifier: CartTVCellIdentifier)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    /// post更改参数
    var cartForm:[KYCartFormModel] = []
    /// 列表数据
    var cartListModel:KYCartListModel?{
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.keyWindow?.addSubview(bottomView)
        dataRequest()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        bottomView.removeFromSuperview()
    }
    func setupUI() {
        self.navigationItem.title = "购物车"
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
extension KYCartViewController{
    func dataRequest() {
        let params = [ "user_id":SingleManager.instance.loginInfo?.user_id!, "unique_id":SingleManager.getUUID(), "token":SingleManager.instance.loginInfo?.token]

        SJBRequestModel.push_fetchCartProductData(params: params as [String : AnyObject]) { (response, status) in
            if status == 1{
                self.cartListModel = response as? KYCartListModel
            }
        }
    }
}
extension KYCartViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if let storelist = cartListModel?.storeList {
            return storelist.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let storelist = cartListModel?.storeList {
            if let array = storelist[section].cartList {
                return array.count
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTVCellIdentifier, for: indexPath) as! CartTVCell
        if let storelist = cartListModel?.storeList {
            if let array = storelist[indexPath.section].cartList {
                cell.model = array[indexPath.row]
                cell.cartChangeResult({ (model) in
                    
                })
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
