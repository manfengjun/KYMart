//
//  KYProductInfoTVCell.swift
//  KYMart
//
//  Created by jun on 2017/6/8.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
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
    @IBOutlet weak var selectL: UILabel!
    @IBOutlet weak var productTypeIV: UIImageView!
    
    
    //闭包类型
    var replyColsure:((Int)->())?

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
            if let text = SingleManager.instance.productBuyInfoModel?.good_buy_price {
                shopPriceL.text = "￥\(text)"
            }
            if let shopPricetext = model?.goods.shop_price {
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
            if let text = SingleManager.instance.productBuyInfoModel?.good_select_info {
                selectL.text = text
            }
            if let text = model?.goods.ky_type {
                switch text {
                case 0:
                    productTypeIV.image = UIImage(named: "product_type_0.png")
                    break
                case 1:
                    productTypeIV.image = UIImage(named: "product_type_1.png")
                    
                    break
                    
                case 3:
                    productTypeIV.image = UIImage(named: "product_type_3.png")
                    
                    break
                    
                default:
                    break
                }
            }

        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        selectView.isUserInteractionEnabled = true
        scrollCircleView.currentPageDotColor = BAR_TINTCOLOR
        scrollCircleView.pageDotColor = UIColor.hexStringColor(hex: "#666666")
//        let shareTap = UITapGestureRecognizer(target: self, action: #selector(tapAction(guesture:)))
//        shareView.addGestureRecognizer(shareTap)
        let selectTap = UITapGestureRecognizer(target: self, action: #selector(tapAction(guesture:)))
        selectView.addGestureRecognizer(selectTap)
        //接受通知监听
        NotificationCenter.default.addObserver(self, selector:#selector(selectProperty),name: SelectProductProperty, object: nil)
        
    }
    //通知处理函数
    func selectProperty(){
        if let text =  SingleManager.instance.productBuyInfoModel?.good_buy_price{
            shopPriceL.text = "¥\(text)"
        }
        if let text = SingleManager.instance.productBuyInfoModel?.good_select_info {
            selectL.text = text
        }
    }
    func tapAction(guesture:UITapGestureRecognizer) {
        if (guesture.view?.isEqual(shareView))! {
            if let colsure = replyColsure {
                colsure(1)
            }
        }
        else
        {
            if let colsure = replyColsure {
                colsure(2)
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
