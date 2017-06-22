//
//  NoneViewController.swift
//  KYMart
//
//  Created by jun on 2017/6/19.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class NoneViewController: BaseViewController {

    var navTitle:String?{
        
        didSet {
            self.navigationItem.title = navTitle
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButtonInNav()
        view.backgroundColor = UIColor.white
        SJBRequestModel.pull_fetchRecordList(type: 1) { (response, status) in
            
        }
        // Do any additional setup after loading the view.
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
