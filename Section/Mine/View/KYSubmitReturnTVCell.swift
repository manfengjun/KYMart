//
//  KYSubmitReturnTVCell.swift
//  KYMart
//
//  Created by JUN on 2017/8/27.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

fileprivate let KYSubmitReturnCVCellIdentifier = "kYSubmitReturnCVCell"

class KYSubmitReturnTVCell: UITableViewCell {
    @IBOutlet weak var productIV: UIImageView!
    @IBOutlet weak var productInfoL: UILabel!
    @IBOutlet weak var productPropertyL: UILabel!
    @IBOutlet weak var moneyL: UILabel!
    @IBOutlet weak var countL: UILabel!
    @IBOutlet weak var descriT: UITextView!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    var imageArray : [UIImage] = []
    var addClosure: SelectClosure?     // 添加图片
    var submitClosure: SelectClosure?     // 提交

    var model : Order_Info_Goods_list?{
        didSet {
            if let text = model?.goods_name {
                productInfoL.text = text
            }
            if let text = model?.goods_id {
                let url = imageUrl(goods_id: text)
                productIV.sd_setImage(with: url, placeholderImage: nil)
            }
            if let text = model?.goods_price {
                moneyL.text = "¥\(text)"
            }
            if let text = model?.goods_num {
                countL.text = "X\(text)"
            }
            if let text = model?.spec_key_name {
                productPropertyL.text = text
            }
//            collectionView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        descriT.layer.masksToBounds = true
        descriT.layer.cornerRadius = 10
        descriT.layer.borderWidth = 0.5
        descriT.layer.borderColor = UIColor.hexStringColor(hex: "#DEDEDE").cgColor
        // Initialization code
    }

    @IBAction func submitAction(_ sender: UIButton) {
        submitClosure?()
    }
    func submitResult(_ finished: @escaping SelectClosure) {
        submitClosure = finished
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension KYSubmitReturnTVCell:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count + 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.01
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (SCREEN_WIDTH - 45)/4, height: (SCREEN_WIDTH - 45)/4)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KYSubmitReturnCVCellIdentifier, for: indexPath) as! KYSubmitReturnCVCell
        if indexPath.row == imageArray.count {
            cell.returnIV.image = UIImage(named: "product_add")
        }
        else{
            cell.returnIV.image = imageArray[indexPath.row]
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == imageArray.count {
            addClosure?()
        }
    }
    func addResult(_ finished: @escaping SelectClosure) {
        addClosure = finished
    }

}
