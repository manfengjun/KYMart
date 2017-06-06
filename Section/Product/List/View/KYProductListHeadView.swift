//
//  KYProductListHeadView.swift
//  KYMart
//
//  Created by Jun on 2017/6/6.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result
class KYProductListHeadView: UIView {
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var ceshiL: UILabel!
//    @IBOutlet weak var newView: UIView!
//    @IBOutlet weak var newL: UILabel!
//    @IBOutlet weak var ceshiL: UILabel!
//    @IBOutlet weak var saleView: UIView!
//    @IBOutlet weak var commentView: UIView!
//    @IBOutlet weak var priceView: UIView!
//    @IBOutlet weak var indicatorView: UIView!
//    @IBOutlet weak var upPriceView: UIView!
//    @IBOutlet weak var downPriceView: UIView!
//    var completionSignal:Signal<Int, NoError>?

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("KYProductListHeadView", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        addSubview(contentView)
        awakeFromNib()

    }
    override func awakeFromNib() {
        super.awakeFromNib()
//        let y = indicatorView.frame.origin.y
//        let width = indicatorView.frame.size.width
//        let height = indicatorView.frame.size.height
//        
//        newView.isUserInteractionEnabled = true
        ceshiL.isUserInteractionEnabled = true
        self.isUserInteractionEnabled = true
        let newTap = UITapGestureRecognizer()
        ceshiL.addGestureRecognizer(newTap)
        let newSignal = newTap.reactive.stateChanged.map { (guesture) -> Int in
            print("sdfsdf")
//            UIView.animate(withDuration: 0.1, animations: {
//                self.indicatorView.frame = CGRect(x: 0, y: y, width: width, height: height)
//            })
            return 1
        }
//        let saleTap = UITapGestureRecognizer()
//        saleView.addGestureRecognizer(saleTap)
//        let saleSignal = saleTap.reactive.stateChanged.map { (guesture) -> Int in
//            UIView.animate(withDuration: 0.1, animations: {
//                self.indicatorView.frame = CGRect(x: SCREEN_WIDTH/4, y: y, width: width, height: height)
//                
//            })
//            return 2
//        }
        
//        let commentTap = UITapGestureRecognizer()
//        commentView.addGestureRecognizer(commentTap)
//        var commentSignal = commentTap.reactive.stateChanged.map { (guesture) -> Int in
//            UIView.animate(withDuration: 0.1, animations: {
//                self.indicatorView.frame = CGRect(x: SCREEN_WIDTH/2, y: y, width: width, height: height)
//                
//            })
//            return 3
//        }
//        
//        let priceTap = UITapGestureRecognizer()
//        priceView.addGestureRecognizer(priceTap)
//        let priceSignal = priceTap.reactive.stateChanged.map { (guesture) -> Int in
//            UIView.animate(withDuration: 0.1, animations: {
//                self.indicatorView.frame = CGRect(x: SCREEN_WIDTH*3/4, y: y, width: width, height: height)
//                
//            })
//            return 4
//        }
//        
//        let upPriceTap = UITapGestureRecognizer()
//        upPriceView.addGestureRecognizer(upPriceTap)
//        let upPriceSignal = upPriceTap.reactive.stateChanged.map { (guesture) -> Int in
//            UIView.animate(withDuration: 0.1, animations: {
//                self.indicatorView.frame = CGRect(x: SCREEN_WIDTH*3/4, y: y, width: width, height: height)
//                
//            })
//            return 5
//        }
//        
//        let downPriceTap = UITapGestureRecognizer()
//        downPriceView.addGestureRecognizer(downPriceTap)
//        let downPriceSignal = downPriceTap.reactive.stateChanged.map { (guesture) -> Int in
//            UIView.animate(withDuration: 0.1, animations: {
//                self.indicatorView.frame = CGRect(x: SCREEN_WIDTH*3/4, y: y, width: width, height: height)
//                
//            })
//            return 6
//        }
        
        
//        commentSignal = Signal.merge([newSignal,saleSignal,commentSignal,priceSignal,upPriceSignal,downPriceSignal])
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
