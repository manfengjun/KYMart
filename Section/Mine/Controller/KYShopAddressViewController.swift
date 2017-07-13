//
//  KYShopAddressViewController.swift
//  KYMart
//
//  Created by Jun on 2017/6/14.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
fileprivate let KYShopAddressTVCellIdentifier = "kYShopAddressTVCell"

class KYShopAddressViewController: BaseViewController {
    var SelectResultClosure: ResultValueClosure?     // 闭包
    var isSelectAddress:Bool = false //是否选择地址操作
    /// 地址列表
    fileprivate lazy var tableView : UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT ), style: .plain)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "KYShopAddressTVCell", bundle: nil), forCellReuseIdentifier: KYShopAddressTVCellIdentifier)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        return tableView
    }()
    /// 添加按钮
    fileprivate lazy var addBtn : UIButton = {
        let addBtn = UIButton(type: .custom)
        addBtn.frame = CGRect(x: 0, y: SCREEN_HEIGHT - 40, width: SCREEN_WIDTH, height: 40)
        addBtn.addTarget(self, action: #selector(addAddress), for: .touchUpInside)
        addBtn.setTitle("添加新地址", for: .normal)
        addBtn.setTitleColor(UIColor.white, for: .normal)
        addBtn.backgroundColor = BAR_TINTCOLOR
        return addBtn
    }()
    
    /// 数据源
    fileprivate var dataArray : [KYAddressModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        UIApplication.shared.keyWindow?.addSubview(addBtn)
        setupUI()
        dataRequest()

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        addBtn.removeFromSuperview()
    }
    
    /// 初始化UI
    func setupUI() {
        setBackButtonInNav()
        navigationItem.title = "地址管理"
        view.addSubview(tableView)
    }
    
    /// 数据请求
    func dataRequest() {
        SJBRequestModel.pull_fetchAddressListData { (response, status) in
            self.dataArray = response as! [KYAddressModel]
            self.tableView.reloadData()
        }
    }
    
    /// 添加地址
    func addAddress() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let addAddressVC = storyboard.instantiateViewController(withIdentifier: "addAddressVC")
        navigationController?.pushViewController(addAddressVC, animated: true)
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
extension KYShopAddressViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KYShopAddressTVCellIdentifier, for: indexPath) as! KYShopAddressTVCell
        let model = dataArray[indexPath.row]
        cell.model = model
        cell.selectResult { (index) in
            if index == 1 {
               //设置默认
                if let text = SingleManager.instance.loginInfo?.user_id{
                    let params = ["user_id":text,"address_id":String(model.address_id)]
                    SJBRequestModel.push_fetchDefaultressDelData(params: params as [String : AnyObject], completion: { (response, status) in
                        if status == 1{
                            self.Toast(content: "设置默认地址成功")
                            self.dataRequest()
                            self.SelectResultClosure?(model)
                            if self.isSelectAddress {
                                self.navigationController?.popViewController(animated: true)
                            }
                        }
                        else
                        {
                            self.Toast(content: response as! String)
                        }
                        
                    })
                    
                }else
                {
                    self.Toast(content: "请先登录！")
                }
            }
            else{
                //删除
                SJBRequestModel.push_fetchAddressDelData(params: ["id":String(model.address_id) as AnyObject]) { (response, status) in
                    if status == 1{
                        self.dataArray.remove(at: indexPath.row)
                        self.Toast(content: "删除地址成功")
                        tableView.reloadData()
                    }
                    else
                    {
                        self.Toast(content: response as! String)
                    }
                }
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let addAddressVC = storyboard.instantiateViewController(withIdentifier: "addAddressVC") as! KYAddAddressViewController
        self.navigationController?.pushViewController(addAddressVC, animated: true)
        addAddressVC.model = dataArray[indexPath.row]
        addAddressVC.isEdit = true
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func selectResult(_ finished: @escaping ResultValueClosure) {
        SelectResultClosure = finished
    }

}
