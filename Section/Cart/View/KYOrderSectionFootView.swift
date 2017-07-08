//
//  KYOrderSectionFootView.swift
//  KYMart
//
//  Created by JUN on 2017/7/8.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result
class KYOrderSectionFootView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var SellerT: UITextField!
    /// 闭包回调传值
    var NoteClosure: ResultValueClosure?     // 闭包

    var model:OrderStoreList?{
        didSet {
            
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("KYOrderSectionFootView", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        addSubview(contentView)
        awakeFromNib()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        SellerT.reactive.continuousTextValues.observeValues { (text) in
            self.NoteClosure?(text as AnyObject)
        }
    }
    /**
     属性选择闭包回调
     */
    func noteResult(_ finished: @escaping ResultValueClosure) {
        NoteClosure = finished
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
