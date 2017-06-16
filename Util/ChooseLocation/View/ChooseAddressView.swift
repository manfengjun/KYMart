//
//  ChooseAddressView.swift
//  KYMart
//
//  Created by jun on 2017/6/16.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class ChooseAddressView: UIView {

    @IBOutlet var contentView: UIView!
    var address:String?
    
    var areaCode:String?
    
    fileprivate lazy var titleLabel : UILabel = {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 40))
        titleLabel.text = "所在地区"
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.hexStringColor(hex: "#333333")
        return titleLabel
    }()
    
    fileprivate lazy var choiceScrollView : UIScrollView = {
        let choiceScrollView = UIScrollView(frame: CGRect(x: 0, y: 40, width: SCREEN_WIDTH, height: 40))
        choiceScrollView.backgroundColor = UIColor.red
        choiceScrollView.bounces = false
        choiceScrollView.contentSize = CGSize(width: SCREEN_WIDTH, height: 50)
        return choiceScrollView
    }()
    
    fileprivate lazy var dataScrollView : UIScrollView = {
        let dataScrollView = UIScrollView(frame: CGRect(x: 0, y: 81, width: SCREEN_WIDTH, height: 0.6*SCREEN_WIDTH))
        dataScrollView.backgroundColor = UIColor.blue
        dataScrollView.bounces = false
        dataScrollView.isPagingEnabled = true
        dataScrollView.contentSize = CGSize(width: SCREEN_WIDTH*5, height: 50)
        return dataScrollView
    }()
    
    func setupLineView(y:CGFloat) -> UIView {
        let frame = CGRect(x: 0, y: y, width: SCREEN_WIDTH, height: 0.5)
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor.hexStringColor(hex: "#DEDEDE", alpha: 0.6)
        return view
    }
    func setuptItem(title:String,level:Int) -> UILabel {
        let item = UILabel()
        let width = title.widthForsize(size:CGSize(width: 10000, height: 40))
        item.frame = CGRect(x: 0, y: 0, width: width, height: 40)
        item.tag = level
        item.text = title
        item.backgroundColor = UIColor.green
        return item
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    func setupUI() {
        backgroundColor = UIColor.orange
        addSubview(titleLabel)
        addSubview(setupLineView(y: 40))
        addSubview(choiceScrollView)
        addSubview(setupLineView(y: 80.5))
        addSubview(dataScrollView)
        setuptItem(title: "撒地方", level: 1)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
