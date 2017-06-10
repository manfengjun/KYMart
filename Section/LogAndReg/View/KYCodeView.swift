//
//  KYCodeView.swift
//  KYMart
//
//  Created by jun on 2017/6/10.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYCodeView: UIView {
    var textColor:UIColor = UIColor.black
    
    var textSize:CGFloat = 0
    
    var changeString:String!
    
    var characters:[String]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        change()
    }
    init(frame:CGRect, characterArray:[String]) {
        super.init(frame: frame)
        backgroundColor = UIColor.randomColor(alpha: 0.2)
        characters = characterArray
    }
    func refresh() {
        changeCode()
    }
    func changeCode() {
        change()
        setNeedsDisplay()
    }
    func setup() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(refresh))
        addGestureRecognizer(tap)
    }
    func change() {
        if characters == nil || characters.isEmpty {
            characters = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
        }
        changeString = ""
        for _ in 0..<4 {
            let index = Int(arc4random())%(characters.count - 1)
            let resultStr = characters[index]
            changeString.append(resultStr)
        }
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        var color = UIColor.randomColor(alpha: 0.5)
        backgroundColor = color
        let text = NSString(string: changeString)
        let size = NSString(string: "S").size(attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: textSize>0 ? textSize : 20),NSForegroundColorAttributeName:textColor])
        let width = rect.size.width / (CGFloat(text.length) - size.width)
        let height = rect.size.height - size.height
        var point:CGPoint!
        var pX = 0
        var pY = 0
        for i in 0..<text.length {
            pX = Int(arc4random()) % Int(width) + Int(rect.size.width) / text.length*i
            pY = Int(arc4random()) % Int(height)
            point = CGPoint(x: pX, y: pY)
            let c = text.character(at: i)
            let textC = NSString(characters: [c], length: 1)
            textC.draw(at: point, withAttributes: [NSFontAttributeName:UIFont.systemFont(ofSize: textSize>0 ? textSize : 20),NSForegroundColorAttributeName:textColor])
        }
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(1.0)
        for _ in 0..<10 {
            color = UIColor.randomColor(alpha: 0.5)
            context?.setStrokeColor(color.cgColor)
            pX = Int(arc4random()) % Int(rect.size.width);
            pY = Int(arc4random()) % Int(rect.size.height);
            context?.move(to: CGPoint(x: pX, y: pY))
            pX = Int(arc4random()) % Int(rect.size.width);
            pY = Int(arc4random()) % Int(rect.size.height);
            context?.addLine(to: CGPoint(x: pX, y: pY))
            context?.strokePath()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
