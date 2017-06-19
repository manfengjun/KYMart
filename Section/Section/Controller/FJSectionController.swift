//
//  FJSectionController.swift
//  FJTools
//
//  Created by jun on 2017/6/5.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
fileprivate let LeftMenuTVCellIdentifier = "fJLeftMenuTVCell"
fileprivate let FJSectionTitleCVCellIdentifier = "fJSectionTitleCVCellCell"
fileprivate let FJSectionRowHeadViewIdentifier = "fJSectionRowHeadView"

class FJSectionController: UIViewController {

    
    /// 一级分类
    fileprivate lazy var tableView : UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH/4, height: SCREEN_HEIGHT - 113), style: .plain)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "FJLeftMenuTVCell", bundle: nil), forCellReuseIdentifier: LeftMenuTVCellIdentifier)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        return tableView
    }()
    
    /// 头部
    fileprivate lazy var headView : FJSectionHeadView = {
        let headView = FJSectionHeadView(frame: CGRect(x: SCREEN_WIDTH/4 + 5, y: 5, width: SCREEN_WIDTH*3/4 - 10, height: (SCREEN_WIDTH*3/4 - 10) * 0.4))
        return headView
    }()
    
    /// 二三级分类
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect(x: SCREEN_WIDTH/4, y: 5, width: SCREEN_WIDTH - SCREEN_WIDTH/4, height: SCREEN_HEIGHT - 113), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.hexStringColor(hex: "#F1F1F1")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib(nibName: "FJSectionTitleCVCellCell", bundle: nil), forCellWithReuseIdentifier: FJSectionTitleCVCellIdentifier)
        collectionView.register(FJSectionRowHeadView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: FJSectionRowHeadViewIdentifier)

        collectionView.delegate = self
    
        collectionView.dataSource = self
        return collectionView
    }()
    
    /// 一级分类数据
    fileprivate var leftDataArray:[FJSectionModel]?{
        didSet {
            tableView.reloadData()
            tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
            selectIndex = 0
        }
    }
    
    /// 二级分类数据
    fileprivate var rightDataArray:[FJSubSectionModel]?{
        didSet {
            collectionView.reloadData()
        }
    }
    
    fileprivate var selectIndex = 0{
        didSet {
            if let model = leftDataArray?[selectIndex]
            {
                dataSubSection(parent_id: model.id)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        dataSectionRequest()
        // Do any additional setup after loading the view.
    }
    func setupUI() {
        self.navigationItem.title = "分类"
        view.addSubview(tableView)
//        view.addSubview(headView)
        view.addSubview(collectionView)
        view.backgroundColor = UIColor.hexStringColor(hex: "#F1F1F1")
    }
    /// 一级分类
    func dataSectionRequest() {
        SJBRequestModel.pull_fetchSectionData { (response, status) in
            if status == 1 {
                self.leftDataArray = response as? [FJSectionModel]
                
            }
        }
    }
    
    /// 二级分类
    ///
    /// - Parameter parent_id: parent_id description
    func dataSubSection(parent_id:Int) {
        SJBRequestModel.pull_fetchSubSectionData(parent_id: parent_id) { (response, status) in
            if status == 1 {
                self.rightDataArray = response as? [FJSubSectionModel]
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: ------ 左侧一级分类列表
extension FJSectionController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = leftDataArray {
            return array.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: LeftMenuTVCellIdentifier, for: indexPath) as! FJLeftMenuTVCell
        if let array = leftDataArray {
            cell.model = array[indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectIndex = indexPath.row
    }
}
extension FJSectionController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let array = rightDataArray {
            return array.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let model = rightDataArray?[section] {
            if let array = model.sub_category {
                return array.count
            }
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FJSectionTitleCVCellIdentifier, for: indexPath) as! FJSectionTitleCVCellCell
        if let model = rightDataArray?[indexPath.section]{
            if let array = model.sub_category {
                cell.model = array[indexPath.row]
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (SCREEN_WIDTH*3/4 - 20)/3, height: 30)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 5, 5, 5)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var resableview = UICollectionReusableView()
        if kind == UICollectionElementKindSectionHeader {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: FJSectionRowHeadViewIdentifier, for: indexPath) as! FJSectionRowHeadView
            if let model = rightDataArray?[indexPath.row] {
                view.model = model
            }
            resableview = view
        }
        return resableview
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: 40)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let listVC = KYProductListViewController()
        let model = rightDataArray?[indexPath.section]
        let array = model?.sub_category
        let submodel = array?[indexPath.row]
        listVC.id = submodel?.id
        listVC.navTitle = submodel?.mobile_name
        listVC.backResult {
            self.tabBarController?.tabBar.isHidden = false
        }
        self.navigationController?.pushViewController(listVC, animated: true)

    }
    
}
