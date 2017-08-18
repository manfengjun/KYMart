//
//  KYHomeSallHeadView.swift
//  KYMart
//
//  Created by Jun on 2017/6/4.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYHomeSallHeadView: UICollectionReusableView {

    @IBOutlet var contentView: UICollectionReusableView!
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    var SelectResultClosure: SelectClosure?     // 闭包

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("KYHomeSallHeadView", owner: self, options: nil)?.first as! UICollectionReusableView
        contentView.frame = self.bounds
        addSubview(contentView)
        awakeFromNib()
    }
    @IBAction func moreAction(_ sender: UIButton) {
        self.SelectResultClosure?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /**
     属性选择闭包回调
     */
    func selectResult(_ finished: @escaping SelectClosure) {
        SelectResultClosure = finished
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
