//
//  HXTagCustomeCell.swift
//  KYMart
//
//  Created by jun on 2017/6/9.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
fileprivate let HXRreuseIdentifier = "HXTagCollectionViewCellId"

class HXTagCustomeCell: UITableViewCell {

    /// 选中的属性
    var selectedTags:[Spec_list] = []
    
    /// 商品属性组中的顺序
    var sectionIndex:Int?
    
    /// 布局
    var layout:HXTagCollectionViewFlowLayout = HXTagCollectionViewFlowLayout()
    
    /// 样式
    var tagAttribute:HXTagAttribute = HXTagAttribute()
    /// 闭包回调传值
    var PropertyResultClosure: PropertyClosure?     // 闭包

    
    /// 数据源
    var goods_spec_list:Goods_spec_list?{
        didSet {
            if let array = goods_spec_list?.spec_list {
                //移除所有已选中
                selectedTags.removeAll()
                //默认选中
                selectedTags.append(array[0])
                //刷新
                collectionView.reloadData()
            }
        }
    }
    /// 属性标签列表
    fileprivate lazy var collectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 362), collectionViewLayout: self.layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(HXTagCollectionViewCell.classForCoder(), forCellWithReuseIdentifier:HXRreuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        if self.layout.scrollDirection ==  UICollectionViewScrollDirection.vertical {
            collectionView.showsVerticalScrollIndicator = true
            collectionView.showsHorizontalScrollIndicator = false
        }else {
            collectionView.showsHorizontalScrollIndicator = true
            collectionView.showsVerticalScrollIndicator = false
        }
        collectionView.frame = self.bounds
        return collectionView
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        awakeFromNib()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = self.bounds
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    /// UI初始化
    func setupUI() {
        addSubview(collectionView)
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let ref:CGContext = UIGraphicsGetCurrentContext()!;
        let h = 0.5 as CGFloat
        let w = self.contentView.bounds.size.width
        let rectTop = CGRect(x: 0, y: h - 0.5, width: w, height: h)
        ref.addRect(rectTop)
        UIColor.hexStringColor(hex: "#DEDEDE", alpha: 0.6).setFill()
        ref.fill(rectTop)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

// MARK: - 业务逻辑
extension HXTagCustomeCell{
    
    /// 计算高度
    ///
    /// - Parameters:
    ///   - tags: tags description
    ///   - layout: layout description
    ///   - width: width description
    /// - Returns: return value description
    class func getCellHeight(tags:[Spec_list],layout:HXTagCollectionViewFlowLayout,width:CGFloat) -> CGFloat {
        var contentHeight:CGFloat = 0
        contentHeight = layout.sectionInset.top + layout.itemSize.height
        var originX = layout.sectionInset.left
        var originY = layout.sectionInset.top
        let itemCount = tags.count
        for i in 0..<itemCount {
            let spec_list = tags[i]
            let maxsize = CGSize(width: width - layout.sectionInset.left - layout.sectionInset.right, height: layout.itemSize.height)
            let frame = NSString(string: spec_list.item).boundingRect(with: maxsize, options: [.usesFontLeading,.usesLineFragmentOrigin], attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 14)], context: nil)
            let itemSize = CGSize(width:frame.size.width, height: layout.itemSize.height)
            if layout.scrollDirection == UICollectionViewScrollDirection.vertical {
                //垂直滚动
                if originX + itemSize.width + layout.sectionInset.right > width {
                    originX = layout.sectionInset.left
                    originY += itemSize.height + layout.minimumLineSpacing
                    contentHeight += itemSize.height + layout.minimumLineSpacing
                }
            }
            originX += itemSize.width + layout.minimumInteritemSpacing
        }
        contentHeight += layout.sectionInset.bottom
        return contentHeight
    }
}

// MARK: - 属性列表代理
extension HXTagCustomeCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (goods_spec_list?.spec_list.count)!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HXRreuseIdentifier, for: indexPath) as! HXTagCollectionViewCell
        cell.backgroundColor = tagAttribute.normalBackgroundColor
        cell.layer.borderColor = tagAttribute.borderColor.cgColor
        cell.layer.borderWidth = tagAttribute.borderWidth
        cell.layer.cornerRadius = tagAttribute.cornerRadius
        cell.titleLabel.textColor = tagAttribute.textColor
        cell.titleLabel.font = UIFont.systemFont(ofSize: tagAttribute.titleSize)
        let spec_list = goods_spec_list?.spec_list[indexPath.row]
        cell.titleLabel.text = spec_list?.item
        if selectedTags.contains(spec_list!) {
            
            cell.backgroundColor = tagAttribute.selectedBackgroundColor
            cell.titleLabel.textColor = tagAttribute.selectedTextColor
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionView.collectionViewLayout as! HXTagCollectionViewFlowLayout
        let maxsize = CGSize(width: collectionView.frame.size.width - layout.sectionInset.left - layout.sectionInset.right, height: layout.itemSize.height)
        let spec_list = goods_spec_list?.spec_list[indexPath.item]
        let frame = NSString(string: (spec_list?.item)!).boundingRect(with: maxsize, options: [.usesFontLeading,.usesLineFragmentOrigin], attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: tagAttribute.titleSize)], context: nil)
        return CGSize(width: frame.size.width + tagAttribute.tagSpace, height: layout.itemSize.height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let spec_list = goods_spec_list?.spec_list[indexPath.row]
        if !selectedTags.contains(spec_list!) {
            selectedTags.removeAll()
            selectedTags.append(spec_list!)
            collectionView.reloadData()
        }
        self.PropertyResultClosure?(selectedTags,sectionIndex!)

    }
    /**
     加减按钮的响应闭包回调
     */
    func propertyResult(_ finished: @escaping PropertyClosure) {
        PropertyResultClosure = finished
    }
}
