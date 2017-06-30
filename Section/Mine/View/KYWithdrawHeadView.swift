//
//  KYWithdrawHeadView.swift
//  KYMart
//
//  Created by JUN on 2017/6/29.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYWithdrawHeadView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var balanceBtn: UIImageView!
    @IBOutlet weak var bonusBtn: UIImageView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var moneyT: UITextField!
    @IBOutlet weak var bankNameT: UITextField!
    @IBOutlet weak var bankCardT: UITextField!
    @IBOutlet weak var realNameT: UITextField!
    
    var info:Info? {
        didSet {
            if let text = info?.bank_name {
                bankNameT.text = text
            }
            if let text = info?.bank_card {
                bankCardT.text = text
            }
            if let text = info?.realname {
                realNameT.text = text
            }

        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("KYWithdrawHeadView", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        addSubview(contentView)
        awakeFromNib()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        saveBtn.layer.masksToBounds = true
        saveBtn.layer.cornerRadius = 5.0
    }
    @IBAction func selectAction(_ sender: UITapGestureRecognizer) {
        balanceBtn.image = sender.view?.tag == 1 ? UIImage(named: "cart_select_yes.png") : UIImage(named: "cart_select_no.png")
        bonusBtn.image = sender.view?.tag == 2 ? UIImage(named: "cart_select_yes.png") : UIImage(named: "cart_select_no.png")

    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
