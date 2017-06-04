//
//  KYProductScrollCVCell.swift
//  KYMart
//
//  Created by Jun on 2017/6/4.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
private let KYHomeSecKillIdentifier = "kYHomeSecKillCVCell"

class KYProductScrollCVCell: UICollectionViewCell {

    @IBOutlet weak var pageControl: UIPageControl!
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = HorizontalPageFlowlayout(rowCount: 1, itemCountPerRow: 3)
        layout?.setColumnSpacing(0, rowSpacing: 0, edgeInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        layout?.minimumLineSpacing = 0
        layout?.minimumInteritemSpacing = 0
        layout?.scrollDirection = UICollectionViewScrollDirection.horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH/3 + 70), collectionViewLayout: layout!)
        collectionView.register(UINib(nibName:"KYHomeSecKillCVCell", bundle:Bundle.main), forCellWithReuseIdentifier: KYHomeSecKillIdentifier)
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
        // Initialization code
    }

}
extension KYProductScrollCVCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KYHomeSecKillIdentifier, for: indexPath)
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = collectionView.contentOffset.x/SCREEN_WIDTH
        pageControl.currentPage = Int(index)
    }
}

