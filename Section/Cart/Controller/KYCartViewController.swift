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
    fileprivate lazy var bottomView:KYCartFootView = {
        let bottomView = KYCartFootView(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 50 - 49, width: SCREEN_WIDTH, height: 50))
        return bottomView
    }()
    /// 一级分类
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
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.keyWindow?.addSubview(bottomView)
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
extension KYCartViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTVCellIdentifier, for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
