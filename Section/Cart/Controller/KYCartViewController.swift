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
    
    /// 是否全选
    var isSelectAll = false
    /// 底部按钮
    fileprivate lazy var bottomView:KYCartFootView = {
        let bottomView = KYCartFootView(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 50 - 49, width: SCREEN_WIDTH, height: 50))
        bottomView.selectAllResult({
            self.isSelectAll = self.isSelectAll ? false : true
            bottomView.selectAllBtn.setImage(self.isSelectAll ? UIImage(named: "cart_select_yes") : UIImage(named: "cart_select_no"), for: .normal)
            let cart_form_datas = NSMutableArray()
            if let array = self.cartListModel?.storeList {
                for storeList in array {
                    for cartList in storeList.cartList {
                        let cart_form_data = KYCartFormModel()
                        cartList.selected = self.isSelectAll ? "1" : "0"
                        cart_form_data.cartID = cartList.id
                        cart_form_data.goodsNum = cartList.goods_num
                        cart_form_data.storeCount = cartList.store_count
                        cart_form_data.selected = cartList.selected
                        cart_form_datas.add(cart_form_data)
                    }
                    
                }
                self.dataRequest(cart_form_datas: cart_form_datas)
            }

        })
        bottomView.balanceSelectResult({
            /// 结算
            var isHaveSelect = false
            if let array = self.cartListModel?.storeList {
                for storeList in array {
                    for cartList in storeList.cartList {
                        if cartList.selected == "1"{
                            isHaveSelect = true
                            break
                        }
                    }
                }
            }
            if isHaveSelect {            
                self.performSegue(withIdentifier: "C_order_SegueID", sender: "")

            }
            else{
                Toast(content: "没有选择商品！")
            }
        })
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
            bottomView.cartListModel = cartListModel

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
        dataRequest(cart_form_datas: nil)
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
    func dataRequest(cart_form_datas:NSMutableArray?) {
        
        let user_id = SingleManager.instance.loginInfo?.user_id
        let unique_id = SingleManager.getUUID()
        let token = SingleManager.instance.loginInfo?.token
        var params:[String:String]?
        if cart_form_datas != nil && (cart_form_datas?.count)! > 0 {
            let jsonStr = cart_form_datas?.yy_modelToJSONString()
            params = [ "user_id":user_id!, "unique_id":unique_id, "token":token!,"cart_form_data":jsonStr!]

        }
        else
        {
            params = [ "user_id":user_id!, "unique_id":unique_id, "token":token!]

        }
        SJBRequestModel.push_fetchCartProductData(params: params! as [String : AnyObject]) { (response, status) in
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
                cell.cartChangeResult({ (response,index) in
                    if index == 2{
                        if let id = response{
                            let unique_id = SingleManager.getUUID()
                            let token = SingleManager.instance.loginInfo?.token
                            let params = ["ids":id,"token":token!,"unique_id":unique_id] as [String : AnyObject]
                            print(params)
                            SJBRequestModel.push_fetchCartDelData(params: params) { (response, status) in
                                if status == 1{
                                    self.Toast(content: "删除成功！")
                                    self.dataRequest(cart_form_datas: nil)
                                }
                                else {
                                    self.Toast(content:response as! String)
                                }
                            }                        }
                        
                    }
                    else
                    {
                        if response != nil{
                            if let temModel = response{
                                let cart_form_datas = NSMutableArray()
                                cart_form_datas.add(temModel)
                                self.dataRequest(cart_form_datas: cart_form_datas)
                            }
                        }
                        
                    }
                    
                })
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
