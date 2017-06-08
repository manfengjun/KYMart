//
//  KYProductInfoTVCell.swift
//  KYMart
//
//  Created by jun on 2017/6/8.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result
class KYProductInfoTVCell: UITableViewCell {

    @IBOutlet weak var scrollCircleView: SDCycleScrollView!
    @IBOutlet weak var productInfoL: UILabel!
    @IBOutlet weak var shopPriceL: UILabel!
    @IBOutlet weak var marketPriceL: UILabel!
    @IBOutlet weak var discountL: UILabel!
    @IBOutlet weak var commentL: UILabel!
    @IBOutlet weak var buyCount: UILabel!
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var selectView: UIView!
    var completionSignal:Signal<Int, NoError>?

    var model:KYGoodInfoModel?{
        didSet {
            if let array = model?.gallery {
                var images:[String] = []
                for item in array {
                    images.append(item.image_url)
                }
                scrollCircleView.imageURLStringsGroup = images
            }
            if let text = model?.goods.goods_name {
                productInfoL.text = text
            }
            if let shopPricetext = model?.goods.shop_price {
                shopPriceL.text = "￥\(shopPricetext)"
                if let marketPricetext = model?.goods.market_price {
                    marketPriceL.text = "价格：￥\(marketPricetext)"
                    let shopprice = NSString(string: shopPricetext).floatValue
                    let marketprice = NSString(string: marketPricetext).floatValue
                    discountL.text = String(format: "折扣：%.1f折", shopprice/marketprice*10)
                }
            }
            if let array = model?.comment {
                commentL.text = "\(array.count)人评价"
            }
            if let text = model?.goods.sales_sum {
                buyCount.text = "\(text)人已付款"
            }
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        shareView.isUserInteractionEnabled = true
        selectView.isUserInteractionEnabled = true
        let shareTap = UITapGestureRecognizer()
        shareView.addGestureRecognizer(shareTap)
        let shareSignal = shareTap.reactive.stateChanged.map { (guesture) -> Int in
            return 1
        }
        let selectTap = UITapGestureRecognizer()
        selectView.addGestureRecognizer(selectTap)
        let selectSignal = selectTap.reactive.stateChanged.map { (guesture) -> Int in
            return 2
        }
        completionSignal = Signal.merge([shareSignal,selectSignal])
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
