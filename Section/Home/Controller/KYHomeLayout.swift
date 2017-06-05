//
//  HomeLayout.swift
//  KYMart
//
//  Created by Jun on 2017/6/4.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYHomeLayout: UICollectionViewLayout {
    var startY:CGFloat = 0
    lazy var attrsArray:[UICollectionViewLayoutAttributes]? = {
        let array = [UICollectionViewLayoutAttributes]()
        return array
    }()
    override var collectionViewContentSize: CGSize {
//        let attrs = self.attrsArray?.last
        return CGSize(width: CGFloat(0), height: startY)
    }
    /**
     * 当collectionView的显示范围发生改变的时候，是否需要重新刷新布局
     * 一旦重新刷新布局，就会重新调用下面的方法：
     1.prepareLayout
     2.layoutAttributesForElementsInRect:方法
     */
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    override func prepare() {
        super.prepare()
        attrsArray?.removeAll()
        
        setupMenuSection(section: 0)
        for i in 1..<4 {
            setupSalesPromotionSection(section: i)
        }
        setupProductListSection(section: 4)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.attrsArray
    }

}
extension KYHomeLayout{
    
    ///菜单按钮分区
    func setupMenuSection(section:Int) {
        /// 第一分区
        /// 头部
        let supplementaryViewIndexPath = IndexPath(row: 0, section: section)
        let headattr = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, with: supplementaryViewIndexPath)
        let headH = SCREEN_WIDTH*20/49 + 50
        headattr.frame = CGRect(x: 0, y: 0, width: (self.collectionView?.frame.size.width)!, height: headH)
        self.attrsArray?.append(headattr)
        /// cell
        let count = self.collectionView?.numberOfItems(inSection: section)
        let result = SCREEN_WIDTH.truncatingRemainder(dividingBy: 4)
        for i in 0..<count! {
            let indexPath = NSIndexPath(item: i, section: section)
            let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
            var width:CGFloat = (SCREEN_WIDTH - result)/4
            let height:CGFloat = SCREEN_WIDTH/4 - 20 + 30
            let x = i > 3 ? width * CGFloat(i - 4) : width * CGFloat(i)
            let y = i > 3 ? headH + height : headH
            if i == 3 || i == 7 {
                width = width + result
            }
            attrs.frame = CGRect(x: x, y: y, width: width, height: height)
            self.attrsArray?.append(attrs)
        }
        startY = headH + 2*(SCREEN_WIDTH/4 - 20 + 30)
        setupFootView(section: 0)
    }
    
    /// 商品滚动列表
    func setupSalesPromotionSection(section:Int) {
        let supplementaryViewIndexPath = IndexPath(row: 0, section: section)
        let headattr = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, with: supplementaryViewIndexPath)
        let headH:CGFloat = 60
        headattr.frame = CGRect(x: 0, y: startY, width: (self.collectionView?.frame.size.width)!, height: headH)
        self.attrsArray?.append(headattr)
        let indexPath = NSIndexPath(item: 0, section: section)
        let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
        let width:CGFloat = SCREEN_WIDTH
        let height:CGFloat = SCREEN_WIDTH/3 + 100
        let x:CGFloat = 0.0
        let y:CGFloat = startY + headH
        attrs.frame = CGRect(x: x, y: y, width: width, height: height)
        self.attrsArray?.append(attrs)
        startY = startY + headH + SCREEN_WIDTH/3 + 100
        setupFootView(section: section)

    }
    
    /// 底部
    ///
    /// - Parameter section: <#section description#>
    func setupFootView(section:Int) {
        let supplementaryViewIndexPath = IndexPath(row: 0, section: section)
        let headattr = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, with: supplementaryViewIndexPath)
        let headH:CGFloat = 11
        headattr.frame = CGRect(x: 0, y: startY, width: (self.collectionView?.frame.size.width)!, height: headH)
        startY = startY + headH
        self.attrsArray?.append(headattr)
    }
    /// 商品滚动列表
    func setupProductListSection(section:Int) {
        let supplementaryViewIndexPath = IndexPath(row: 0, section: section)
        let headattr = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, with: supplementaryViewIndexPath)
        let headH:CGFloat = 40
        headattr.frame = CGRect(x: 0, y: startY, width: (self.collectionView?.frame.size.width)!, height: headH)
        self.attrsArray?.append(headattr)
        startY = startY + headH
        
        let count = self.collectionView?.numberOfItems(inSection: section)
        for i in 0..<count! {
            let indexPath = NSIndexPath(item: i, section: section)
            let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
            let width = (SCREEN_WIDTH - 10) / 2
            let height:CGFloat = (SCREEN_WIDTH - 10)/2 + 80
            let x = (i%2 == 0) ? 0 : width + 10
            let y = startY
            attrs.frame = CGRect(x: x, y: y, width: width, height: height)
            self.attrsArray?.append(attrs)
            startY = (i%2 == 0) ? startY : startY + height + 10
        }
        
    }
}
