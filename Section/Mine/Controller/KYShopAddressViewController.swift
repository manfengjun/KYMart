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
    fileprivate lazy var addBtn : UIButton = {
        let addBtn = UIButton(type: .custom)
        addBtn.frame = CGRect(x: 0, y: SCREEN_HEIGHT - 40, width: SCREEN_WIDTH, height: 40)
        addBtn.addTarget(self, action: #selector(addAddress), for: .touchUpInside)
        addBtn.setTitle("添加新地址", for: .normal)
        addBtn.setTitleColor(UIColor.white, for: .normal)
        addBtn.backgroundColor = BAR_TINTCOLOR
        return addBtn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        UIApplication.shared.keyWindow?.addSubview(addBtn)

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        addBtn.removeFromSuperview()
    }
    func setupUI() {
        setBackButtonInNav()
        navigationItem.title = "地址管理"
        view.addSubview(tableView)
    }
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
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KYShopAddressTVCellIdentifier, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
