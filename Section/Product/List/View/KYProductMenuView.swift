//
//  KYProductMenuView.swift
//  KYMart
//
//  Created by jun on 2017/6/7.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result
class KYProductMenuView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet var newTap: UITapGestureRecognizer!
    @IBOutlet var saleTap: UITapGestureRecognizer!
    @IBOutlet var commentTap: UITapGestureRecognizer!
    @IBOutlet var priceTap: UITapGestureRecognizer!
    @IBOutlet var upPriceTap: UITapGestureRecognizer!
    @IBOutlet var downPriceTap: UITapGestureRecognizer!
    var completionSignal:Signal<Int, NoError>?
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("KYProductMenuView", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        addSubview(contentView)
        awakeFromNib()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        let y:CGFloat = 38
        let width = SCREEN_WIDTH/4
        let height:CGFloat = 2

        let newSignal = newTap.reactive.stateChanged.map { (guesture) -> Int in
            UIView.animate(withDuration: 0.1, animations: { 
                self.indicatorView.frame = CGRect(x: 0, y: y, width: width, height: height)
            })
            return 1
        }
        let saleSignal = saleTap.reactive.stateChanged.map { (guesture) -> Int in
            UIView.animate(withDuration: 0.1, animations: {
                self.indicatorView.frame = CGRect(x: SCREEN_WIDTH/4, y: y, width: width, height: height)

            })
            return 2
        }
        let commentSignal = commentTap.reactive.stateChanged.map { (guesture) -> Int in
            UIView.animate(withDuration: 0.1, animations: {
                self.indicatorView.frame = CGRect(x: SCREEN_WIDTH/2, y: y, width: width, height: height)

            })
            return 3
        }
        let priceSignal = priceTap.reactive.stateChanged.map { (guesture) -> Int in
            UIView.animate(withDuration: 0.1, animations: {
                self.indicatorView.frame = CGRect(x: SCREEN_WIDTH*3/4, y: y, width: width, height: height)

            })
            return 4
        }
        let upPriceSignal = upPriceTap.reactive.stateChanged.map { (guesture) -> Int in
            UIView.animate(withDuration: 0.1, animations: {
                self.indicatorView.frame = CGRect(x: SCREEN_WIDTH*3/4, y: y, width: width, height: height)

            })
            return 5
        }
        let downPriceSignal = downPriceTap.reactive.stateChanged.map { (guesture) -> Int in
            UIView.animate(withDuration: 0.1, animations: {
                self.indicatorView.frame = CGRect(x: SCREEN_WIDTH*3/4, y: y, width: width, height: height)

            })
            return 6
        }
        completionSignal = Signal.merge([newSignal,saleSignal,commentSignal,priceSignal,upPriceSignal,downPriceSignal])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
