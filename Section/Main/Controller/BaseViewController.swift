//
//  BaseViewController.swift
//  KYMart
//
//  Created by Jun on 2017/6/4.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    // 闭包回调传值
    var BackResultClosure: BackClosure?     // 闭包
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    /// 返回
    func goback() {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        }
        else
        {
            dismiss(animated: true, completion: nil)
        }
        BackResultClosure?()
    }

    /**
     返回回调
     */
    func backResult(_ finished: @escaping BackClosure) {
        BackResultClosure = finished
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
