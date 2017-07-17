//
//  KYSearchView.swift
//  KYMart
//
//  Created by JUN on 2017/7/17.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYSearchView: UIView {
    @IBOutlet var contentView: UIView!
    var ResultNoClosure: NoParamsClosure?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed("KYSearchView", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        addSubview(contentView)
        awakeFromNib()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.masksToBounds = true
        layer.cornerRadius = self.frame.height/2
    }
    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        ResultNoClosure?()
    }
    func callBackNo(_ finished: @escaping NoParamsClosure) {
        ResultNoClosure = finished
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
