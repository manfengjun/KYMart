//
//  KYShopAddressTVCell.swift
//  KYMart
//
//  Created by Jun on 2017/6/14.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYShopAddressTVCell: UITableViewCell {

    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var addressL: UILabel!
    @IBOutlet weak var phoneL: UILabel!
    @IBOutlet weak var isDefaultBtn: UIButton!
    var model:KYAddressModel?{
        didSet {
            if let text = model?.consignee {
               nameL.text = text
            }
            if let text = model?.mobile {
                phoneL.text = "电话:\(text)"
            }
            var addressStr = ""
            if let provice = model?.province {
                addressStr += getAddressName(id: provice)
                if let city = model?.city{
                    addressStr += getAddressName(id: city)
                    if let district = model?.district {
                        addressStr += getAddressName(id: district)
                        if let twon = model?.twon {
                            addressStr += getAddressName(id: twon)
                            if let address = model?.address {
                                addressStr += "\(address)"
                                addressL.text = addressStr
                            }
                        }
                    }
                }
            }
            
            if let isDefault = model?.is_default {
                isDefaultBtn.setImage(isDefault == 1 ? UIImage(named:"cart_select_yes.png") : UIImage(named:"cart_select_no.png"), for: .normal)
            }
        }
    }
    func getAddressName(id:Int) -> String {
        if let array = CitiesDataTool.sharedManager().queryData(with: id) {
            if array.count > 0 {
                return array[0] as! String + " "
            }
        }
        return " "
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
