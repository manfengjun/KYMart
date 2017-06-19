//
//  KYHomeHeadView.swift
//  KYMart
//
//  Created by Jun on 2017/6/4.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYHomeHeadView: UICollectionReusableView {

    @IBOutlet weak var searchView: UIView!
    @IBOutlet var contentView: UICollectionReusableView!
    
    var images:[Ad]?{
        didSet {
            var urls:[String] = []
            for model in images! {
                if let url = model.ad_code {
                    urls.append(url)
                }
            }
            sdcircleView.imageURLStringsGroup = urls
        }
    }
    fileprivate lazy var sdcircleView : SDCycleScrollView = {
        let sdcircleView = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH*20/49), delegate: self, placeholderImage: UIImage(named: ""))
        return sdcircleView!
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("KYHomeHeadView", owner: self, options: nil)?.first as! UICollectionReusableView
        contentView.frame = self.bounds
        addSubview(contentView)
        awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    func setupUI() {
        sdcircleView.backgroundColor = UIColor.white
        searchView.layer.masksToBounds = true
        searchView.layer.cornerRadius = 5.0
        searchView.layer.borderColor = UIColor.hexStringColor(hex: "#CCCCCC").cgColor
        searchView.layer.borderWidth = 0.5
        addSubview(sdcircleView)
    }
    
    
}
extension KYHomeHeadView:SDCycleScrollViewDelegate{

}
