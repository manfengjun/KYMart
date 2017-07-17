//
//  KYHomeMenuPageCVCell.swift
//  KYMart
//
//  Created by jun on 2017/7/17.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
private let KYHomeMenuCVCellIdentifier = "kYHomeMenuCVCell"
private let KYHomeMenuIdentifier = "kYHomeMenuCVCell"

class KYHomeMenuPageCVCell: BaseCollectionViewCell {

    @IBOutlet weak var pageControl: UIPageControl!
    var menuTitles:[String] = []
    var menuIDs:[String] = []
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = HorizontalPageFlowlayout(rowCount: 2, itemCountPerRow: 4)
        layout?.setColumnSpacing(0, rowSpacing: 0, edgeInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        layout?.minimumLineSpacing = 0
        layout?.minimumInteritemSpacing = 0
        layout?.scrollDirection = UICollectionViewScrollDirection.horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: (SCREEN_WIDTH/4 - 20 + 30)*2), collectionViewLayout: layout!)
        collectionView.register(UINib(nibName:"KYHomeMenuCVCell", bundle:Bundle.main), forCellWithReuseIdentifier: KYHomeMenuIdentifier)
        collectionView.backgroundColor = UIColor.white
        collectionView.bounces = true;
        collectionView.isPagingEnabled = true;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(collectionView)
        pageControl.numberOfPages = 2
        // Initialization code
    }

}
extension KYHomeMenuPageCVCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuTitles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KYHomeMenuIdentifier, for: indexPath) as! KYHomeMenuCVCell
        cell.menutitleL.text = menuTitles[indexPath.row]
        cell.menuIV.image = UIImage(named: "home_menu_\(indexPath.row + 1)")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ResultOneClosure?(indexPath.row as AnyObject)
       
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = collectionView.contentOffset.x/SCREEN_WIDTH
        pageControl.currentPage = Int(index)
    }
}
