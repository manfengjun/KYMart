//
//  SJBDetailBottomView.swift
//  HNLYSJB
//
//  Created by jun on 2017/5/27.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result
class KYProductMenuView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var commentV: UIView!
    @IBOutlet weak var favoriteV: UIView!
    @IBOutlet weak var shareV: UIView!
    @IBOutlet weak var ceshiV: UIView!
    var completionSignal:Signal<Int, NoError>?

    @IBOutlet weak var ceshiL: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("KYProductMenuView", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        addSubview(contentView)
        awakeFromNib()
    }
    @IBOutlet var tap: UITapGestureRecognizer!
    override func awakeFromNib() {
        super.awakeFromNib()
//        textView.layer.masksToBounds = true
//        textView.layer.cornerRadius = 15
//        textView.layer.borderColor = UIColor.hexStringColor(hex: "#DEDEDE").cgColor
//        textView.layer.borderWidth = 0.5
        
        //设置手势
//        let commentTap = UITapGestureRecognizer()
//        ceshiV.addGestureRecognizer(commentTap)
        let commentSignal = tap.reactive.stateChanged.map { (gesture) -> Int in
            return 1
        }
//        let favoriteTap = UITapGestureRecognizer()
//        favoriteV.addGestureRecognizer(favoriteTap)
//        let favoriteSignal = favoriteTap.reactive.stateChanged.map { (gesture) -> Int in
//            return 2
//        }
//        let shareTap = UITapGestureRecognizer()
//        shareV.addGestureRecognizer(shareTap)
//        let shareSignal = shareTap.reactive.stateChanged.map { (gesture) -> Int in
//            return 3
//        }
//        
//        completionSignal = Signal.merge([commentSignal,favoriteSignal,shareSignal])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
