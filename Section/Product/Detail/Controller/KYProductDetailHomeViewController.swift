//
//  KYProductDetailHomeViewController.swift
//  KYMart
//
//  Created by Jun on 2017/6/7.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
fileprivate let KYProductInfoTVCellIdentifier = "kYProductInfoTVCell"

class KYProductDetailHomeViewController: UIViewController {

    /// 详情
    fileprivate lazy var tableView : UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), style: .plain)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "KYProductInfoTVCell", bundle: nil), forCellReuseIdentifier: KYProductInfoTVCellIdentifier)
        tableView.backgroundColor = UIColor.white
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    /// 遮罩
    fileprivate lazy var selectBgView : UIView = {
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        bgView.backgroundColor = UIColor.rgbColor(r: 0, g: 0, b: 0, a: 0.3)
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideView))
        bgView.addGestureRecognizer(tap)
        return bgView
    }()
    fileprivate lazy var propertyView : KYProductPropertyView = {
        let propertyView = KYProductPropertyView(frame: CGRect(x: 0, y: SCREEN_HEIGHT*0.4, width: SCREEN_WIDTH, height: SCREEN_HEIGHT*0.6))
        return propertyView
    }()
    var id:Int?{
        didSet {
            dataRequest()
        }
    }
    var productInfoModel:KYGoodInfoModel?{
        didSet {
            tableView.reloadData()
        }
    }
    func hideView() {
        selectBgView.removeFromSuperview()
    }
    func dataRequest() {
        SJBRequestModel.pull_fetchProductInfoData(id: id!) { (response, status) in
            if status == 1 {
                self.productInfoModel = response as? KYGoodInfoModel
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.addSubview(propertyView)
        id = 1
        view.addSubview(tableView)
//        tableView.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension KYProductDetailHomeViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: KYProductInfoTVCellIdentifier, for: indexPath) as! KYProductInfoTVCell
        cell.model = productInfoModel
        cell.completionSignal?.observeValues({ (index) in
            self.selectBgView.addSubview(self.propertyView)
            UIApplication.shared.keyWindow?.addSubview(self.selectBgView)
        })
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCREEN_HEIGHT
    }
    
}
