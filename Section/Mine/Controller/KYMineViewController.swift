//
//  KYMineViewController.swift
//  KYMart
//
//  Created by jun on 2017/6/14.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import TZImagePickerController
class KYMineViewController: UIViewController {

    @IBOutlet var headView: UIView!
    @IBOutlet weak var portraitBgV: UIView!
    @IBOutlet weak var portraitIV: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var recommendL: UILabel!
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
                portraitIV.sd_setImage(with: URL(string: imgUrl), placeholderImage: nil)
            }

        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.subviews[0].alpha = 0

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.subviews[0].alpha = 1

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        dataRequest()
        // Do any additional setup after loading the view.
    }
    func setupUI() {
        portraitBgV.layer.masksToBounds = true
        portraitBgV.layer.cornerRadius = SCREEN_WIDTH/12
        portraitIV.layer.masksToBounds = true
        portraitIV.layer.cornerRadius = (SCREEN_WIDTH*1/6 - 6)/2
        headView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH*3/5 )
        tableView.tableHeaderView = headView
        navigationController?.navigationBar.isTranslucent = true
        tableView.backgroundColor = UIColor.hexStringColor(hex: "#F2F2F2")

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
        SJBRequestModel.pull_fetchUserInfoData { (response, status) in
            if status == 1{
                self.userInfoModel = response as? KYUserInfoModel
            }
        }
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
        imagePicker?.cropRect = CGRect(x: SCREEN_WIDTH/2 - 100, y: SCREEN_HEIGHT/2 - 100, width: 200, height: 200)
        imagePicker?.didFinishPickingPhotosHandle = {(photos,assets,isSelectOriginalPhoto) -> Void in
            if isSelectOriginalPhoto {
                //原图
                // 你可以通过一个asset获得原图，通过这个方法：[[TZImageManager manager] getOriginalPhotoWithAsset:completion:]
                if let array = assets {
                    TZImageManager.default().getOriginalPhoto(withAsset: array[0], completion: { (image, info) in
                        self.portraitIV.image = image
                    })
                }
            }
            else{
                //非原图
                if let array = photos{
                    self.portraitIV.image = array[0]
                }
            }
        }
        self.present(imagePicker!, animated: true, completion: nil)
    }
}
extension KYMineViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if let dic = dataDic {
            return dic.allKeys.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dic = dataDic {
            if let array = dic["\(section)"]{
                return (array as! [NSDictionary]).count
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kYMineTVCell", for: indexPath) as! KYMineTVCell
//        cell.titleL.textColor = UIColor.hexStringColor(hex: "#333333")
//
//        if indexPath.section == 0 {
//            cell.titleL.textColor = BAR_TINTCOLOR
//        }
        if let dic = dataDic {
            if let array = dic["\(indexPath.section)"]{
                let dic = (array as! [NSDictionary])[indexPath.row]
                if let text = dic["image"] {
                    cell.cellIV.image = UIImage(named:text as! String)
                }
                if let text = dic["title"] {
                    cell.titleL.text = text as? String
                }
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.hexStringColor(hex: "#F2F2F2")
        return view
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            if indexPath.row == 0 {
                let shopAddressVC = KYShopAddressViewController()
                navigationController?.pushViewController(shopAddressVC, animated: true)
                shopAddressVC.backResult({ 
                    self.tabBarController?.tabBar.isHidden = false
                })
            }
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
