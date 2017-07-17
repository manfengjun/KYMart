//
//  BaseCollectionViewCell.swift
//  KYMart
//
//  Created by jun on 2017/7/17.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    var ResultNoClosure: NoParamsClosure?
    var ResultOneClosure: OneParamsClosure?

    func callBackNo(_ finished: @escaping NoParamsClosure) {
        ResultNoClosure = finished
    }
    func callBackOne(_ finished: @escaping OneParamsClosure) {
        ResultOneClosure = finished
    }
}
