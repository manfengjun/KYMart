//
//  KYMineViewController.swift
//  KYMart
//
//  Created by jun on 2017/6/14.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import PopupDialog
import TZImagePickerController
class KYMineViewController: BaseViewController {

    @IBOutlet var headView: UIView!
    @IBOutlet weak var portraitBgV: UIView!
    @IBOutlet weak var portraitIV: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var recommendL: UILabel!
    @IBOutlet weak var usermoneyL: UILabel!
    @IBOutlet weak var bonusL: UILabel!
    @IBOutlet weak var userTypeL: UILabel!
    @IBOutlet weak var pendingLabel: UILabel!
    
    var userInfoModel:KYUserInfoModel?{
        didSet {
            dataMenu()
        }
    }
    var dataDic:NSMutableDictionary?{
        didSet {
            tableView.reloadData()
            if let text = userInfoModel?.nickname {
                nameL.text = text
            }
            if let imgUrl = userInfoModel?.head_pic {
                portraitIV.sd_setImage(with: URL(string: baseHref + imgUrl), placeholderImage: nil)
            }
            if let text = userInfoModel?.bonus {
                bonusL.text = "¥\(text)"
            }
            if let text = userInfoModel?.user_money {
                usermoneyL.text = "¥\(text)"
            }
            if let text = userInfoModel?.total_sell {
                if let text2 = userInfoModel?.total_bonus1 {
                    pendingLabel.text = "¥\(Float(text)! - Float(text2)!)"
                }
            }
            
            if let text = userInfoModel?.user_id {
                if let operatorStatus = userInfoModel?.operator_status{
                    if operatorStatus == 0 {
                        recommendL.text = "会员ID:\(text)"
                    }
                    else
                    {
                        recommendL.text = "会员ID:\(text)（运营商）"

                    }
                }
                else
                {
                    recommendL.text = "会员ID:\(text)"
                }
            }
            if let text = userInfoModel?.sell_status {
                userTypeL.text = (text == 0 ? "预备会员" : "开心果")
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.subviews[0].alpha = 0
        setupUI()

        dataRequest()


    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.subviews[0].alpha = 1


    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    func setupUI() {
        portraitBgV.layer.masksToBounds = true
        portraitBgV.layer.cornerRadius = SCREEN_WIDTH/12
        portraitIV.layer.masksToBounds = true
        portraitIV.layer.cornerRadius = (SCREEN_WIDTH*1/6 - 6)/2
        headView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH*3/5)
        tableView.tableHeaderView = headView
        navigationController?.navigationBar.isTranslucent = true
        tableView.backgroundColor = UIColor.hexStringColor(hex: "#F2F2F2")
//        setRightButtonInNav(title: SingleManager.instance.isLogin ? "退出登录" : "登录", action: #selector(isLoginAction(sender:)), size:CGSize(width: 80, height: 24))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "M_setting_SegueID" {
            let vc = segue.destination as! KYUserInfoViewController
            vc.backResult {
                self.tabBarController?.tabBar.isHidden = false
            }
        }
        if segue.identifier == "M_bonusToMoney_SegudID" {
            let vc = segue.destination as! KYBonusToMoneyViewController
            vc.bonus = userInfoModel?.bonus

        }
        if segue.identifier == "M_recharge_SegudID" {
            let vc = segue.destination as! KYRechargeViewController
            vc.userMoney = userInfoModel?.user_money
        }

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
}

// MARK: - 业务逻辑
extension KYMineViewController:TZImagePickerControllerDelegate {
    
    /// 获取菜单列表
    func dataMenu() {
        let filePath = Bundle.main.path(forResource: "data", ofType: "plist")
        let dic = NSMutableDictionary(contentsOfFile: filePath!)
        let jsonData = (dic?["mine"] as! String).data(using: String.Encoding.utf8)
        do {
            let resultDic = try JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableDictionary
            dataDic = resultDic
        } catch{
            
        }
    }
    /// 数据请求
    func dataRequest() {
        if SingleManager.instance.isLogin {
            SJBRequestModel.pull_fetchUserInfoData { (response, status) in
                if status == 1{
                    SingleManager.instance.userInfo = response as? KYUserInfoModel
                    self.userInfoModel = SingleManager.instance.userInfo
                }
            }

        }
        else{
            Toast(content: "未登录")
        }
    }
    
    /// 个人资料
    ///
    /// - Parameter sender: sender description
    @IBAction func setUserInfoAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "M_setting_SegueID", sender: "")

    }
    /// 跳转到充值界面
    ///
    /// - Parameter sender: sender description
    @IBAction func userMoneyAction(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "M_recharge_SegudID", sender: sender)
    }
    /// 修改头像
    ///
    /// - Parameter sender: sender description
    @IBAction func changePortrait(_ sender: UITapGestureRecognizer) {
        let imagePicker = TZImagePickerController(maxImagesCount: 1, delegate: self)
        imagePicker?.naviBgColor = BAR_TINTCOLOR
        imagePicker?.allowCrop = true
        imagePicker?.needCircleCrop = true
        imagePicker?.title = "选择图片"
        imagePicker?.allowPickingOriginalPhoto = true
        imagePicker?.cropRect = CGRect(x: SCREEN_WIDTH/2 - 100, y: SCREEN_HEIGHT/2 - 100, width: 200, height: 200)
        imagePicker?.didFinishPickingPhotosHandle = {(photos,assets,isSelectOriginalPhoto) -> Void in
            if isSelectOriginalPhoto {
                //原图
                // 你可以通过一个asset获得原图，通过这个方法：[[TZImageManager manager] getOriginalPhotoWithAsset:completion:]
                if let array = assets {
                    TZImageManager.default().getOriginalPhoto(withAsset: array[0], completion: { (image, info) in
                        if let temImage = image{
                            self.uploadImage(image: temImage)

                        }
                    })
                }
            }
            else{
                //非原图
                if let array = photos{
                    self.uploadImage(image: array[0])
                }
            }
        }
        self.present(imagePicker!, animated: true, completion: nil)
    }
    func uploadImage(image:UIImage) {
        SJBRequestModel.push_fetchChangePortraitData(image: image) { (response, status) in
            if status == 1 {
                self.Toast(content: "上传成功！")
                self.portraitIV.image = image
            }
        }
    }
}
extension KYMineViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if let dic = dataDic {
            return dic.allKeys.count + 1
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dic = dataDic {
            if section == dic.allKeys.count {
                return 1
            }
            else {
                if let array = dic["\(section)"]{
                    return (array as! [NSDictionary]).count
                }
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == dataDic?.allKeys.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "kYMineOtherTVCell", for: indexPath) as! KYMineOtherTVCell
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "kYMineTVCell", for: indexPath) as! KYMineTVCell
            if let array = dataDic?["\(indexPath.section)"]{
                let dic = (array as! [NSDictionary])[indexPath.row]
                if let text = dic["image"] {
                    cell.cellIV.image = UIImage(named:text as! String)
                }
                if let text = dic["title"] {
                    cell.titleL.text = text as? String
                }
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == dataDic?.allKeys.count {
            return 20
        }
        return 10
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.hexStringColor(hex: "#F2F2F2")
        return view
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            self.performSegue(withIdentifier: "M_orderList_SegudID", sender: nil)
        
        }
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                let sellListVC = KYSellListViewController()
                sellListVC.navTitle = "我的钱包"
                sellListVC.bonusMoney = userInfoModel?.user_money
                self.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(sellListVC, animated: true)
                self.hidesBottomBarWhenPushed = false

                break
            case 1:
                let bonusListVC = KYBonusListViewController()
                bonusListVC.navTitle = "优惠卷明细"
                bonusListVC.userMoney = userInfoModel?.bonus
                self.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(bonusListVC, animated: true)
                self.hidesBottomBarWhenPushed = false
                
                break
            case 2:
                let withdrawListVC = KYWithdrawListViewController()
                self.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(withdrawListVC, animated: true)
                self.hidesBottomBarWhenPushed = false
                
                break
            case 3:
                self.performSegue(withIdentifier: "M_bonusToMoney_SegudID", sender: "")
                break
            default:
                break
            }
        }
        else if indexPath.section == 2 {
            if indexPath.row == 0 {
                let shopAddressVC = KYShopAddressViewController()
                navigationController?.pushViewController(shopAddressVC, animated: true)
                shopAddressVC.backResult({ 
                    self.tabBarController?.tabBar.isHidden = false
                })
            }
            if indexPath.row == 1 {
                self.performSegue(withIdentifier: "M_member_SegueID", sender: "")
            }
            if indexPath.row == 2 {
                self.performSegue(withIdentifier: "M_shareQrCode_SegudID", sender: "")
            }
            if indexPath.row == 3 {
                self.performSegue(withIdentifier: "M_setting_SegueID", sender: "")
            }

        }
        else if indexPath.section == dataDic?.allKeys.count
        {
            // Prepare the popup
            let title = "提  示"
            let message = "确认退出登录"
            
            // Create the dialog
            let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, gestureDismissal: true) {
                print("Completed")
            }
            
            // Create first button
            let buttonOne = CancelButton(title: "取消") {
            }
            
            // Create second button
            let buttonTwo = DefaultButton(title: "确定") {
                //退出登录
                SingleManager.instance.isLogin = false
                SingleManager.instance.loginInfo = nil
                self.tabBarController?.selectedIndex = 0
            }
            
            // Add buttons to dialog
            popup.addButtons([buttonOne, buttonTwo])
            
            // Present dialog
            self.present(popup, animated: true, completion: nil)

            
        }
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let sectionHeaderHeight:CGFloat = 10;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}
