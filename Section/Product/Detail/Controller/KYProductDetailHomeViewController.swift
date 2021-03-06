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
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64 - 50), style: .plain)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "KYProductInfoTVCell", bundle: nil), forCellReuseIdentifier: KYProductInfoTVCellIdentifier)
        tableView.backgroundColor = UIColor.white
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        return tableView
    }()
    /// 遮罩
    fileprivate lazy var selectBgView : UIView = {
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        bgView.backgroundColor = UIColor.rgbColor(r: 0, g: 0, b: 0, a: 0.3)
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideView))
        tap.delegate = self
        bgView.addGestureRecognizer(tap)
        return bgView
    }()
    
    /// 属性选择页面
    fileprivate lazy var propertyView : KYProductPropertyView = {
        let propertyView = KYProductPropertyView(frame: CGRect(x: 0, y: SCREEN_HEIGHT*0.4, width: SCREEN_WIDTH, height: SCREEN_HEIGHT*0.6))
        return propertyView
    }()
    
    /// 商品ID
    var id:Int?{
        didSet {
            dataRequest()
        }
    }
    
    /// 商品详情对象
    var productInfoModel:KYGoodInfoModel?{
        didSet {
            setupProductBuyInfoModel()
            tableView.reloadData()
        }
    }
    
    /// 初始化购买对象
    func setupProductBuyInfoModel() {
        SingleManager.instance.productBuyInfoModel = KYProductBuyInfoModel()
        SingleManager.instance.productBuyInfoModel?.good_buy_id = productInfoModel?.goods.goods_id
        SingleManager.instance.productBuyInfoModel?.spec_goods_prices = productInfoModel?.spec_goods_price
        SingleManager.instance.productBuyInfoModel?.good_buy_price = productInfoModel?.goods.shop_price
        if let text = productInfoModel?.goods.store_count {
            SingleManager.instance.productBuyInfoModel?.good_buy_store_count = text
        }
        SingleManager.instance.productBuyInfoModel?.good_buy_propertys = []
        if let text =  productInfoModel?.goods.store_count{
            SingleManager.instance.productBuyInfoModel?.good_buy_store_count = text
        }
        if let array = productInfoModel?.goods_spec_list {
            for item in array {
                let good_Buy_Property = Good_Buy_Property()
                good_Buy_Property.good_buy_spec_name = item.spec_name
                if let array = item.spec_list {
                    if array.count > 0 {
                        good_Buy_Property.good_buy_spec_list = array[0]
                        SingleManager.instance.productBuyInfoModel?.good_buy_propertys.append(good_Buy_Property)
                    }
                }
            }
            
        }
        //刷新数据
        SingleManager.instance.productBuyInfoModel?.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - 数据处理
extension KYProductDetailHomeViewController{
    func dataRequest() {
        SJBRequestModel.pull_fetchProductInfoData(id: id!) { (response, status) in
            if status == 1 {
                self.productInfoModel = response as? KYGoodInfoModel
            }
            else
            {
               self.Toast(content: "请求数据失败！")
            }
        }
    }
}
// MARK: - 属性选择界面
extension KYProductDetailHomeViewController:UIGestureRecognizerDelegate{
    /// 隐藏属性选择界面
    func hideView() {
        selectBgView.removeFromSuperview()
    }
    /// 解决手势冲突
    ///
    /// - Parameters:
    ///   - gestureRecognizer: gestureRecognizer description
    ///   - touch: touch description
    /// - Returns: return value description
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isEqual(selectBgView))! {
            return true
        }
        return false
    }
}

// MARK: - 商品界面代理
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
        cell.replyColsure = {(index) in
            if index == 2 {
//                if (self.productInfoModel?.goods.goods_spec_list.isEmpty)! {
//                    return
//                }
                self.selectBgView.addSubview(self.propertyView)
                self.propertyView.model = self.productInfoModel
                UIApplication.shared.keyWindow?.addSubview(self.selectBgView)
                
            }
        }
        return cell
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 40
//    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
}
