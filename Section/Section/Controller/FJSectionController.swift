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
class FJSectionController: UIViewController {

    fileprivate lazy var tableView : UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH/4, height: SCREEN_HEIGHT), style: .plain)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "FJLeftMenuTVCell", bundle: nil), forCellReuseIdentifier: LeftMenuTVCellIdentifier)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    fileprivate lazy var headView : FJSectionHeadView = {
        let headView = FJSectionHeadView(frame: CGRect(x: SCREEN_WIDTH/4 + 5, y: 64 + 5, width: SCREEN_WIDTH*3/4 - 10, height: (SCREEN_WIDTH*3/4 - 10) * 0.4))
        return headView
    }()
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect(x: SCREEN_WIDTH/4, y: 64 + (SCREEN_WIDTH*3/4 - 10) * 0.4, width: SCREEN_WIDTH - SCREEN_WIDTH/4, height: SCREEN_HEIGHT), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.hexStringColor(hex: "#F1F1F1")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib(nibName: "FJSectionTitleCVCellCell", bundle: nil), forCellWithReuseIdentifier: FJSectionTitleCVCellIdentifier)
        collectionView.delegate = self
    
        collectionView.dataSource = self
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(headView)
        view.addSubview(collectionView)
        view.backgroundColor = UIColor.hexStringColor(hex: "#F1F1F1")
        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
        // Do any additional setup after loading the view.
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
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: LeftMenuTVCellIdentifier, for: indexPath)
        return cell
    }
}
extension FJSectionController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FJSectionTitleCVCellIdentifier, for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (SCREEN_WIDTH*3/4 - 20)/3, height: 30)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 0, 5)
    }
}
