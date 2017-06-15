//
//  KYAddAddressViewController.swift
//  KYMart
//
//  Created by Jun on 2017/6/15.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYAddAddressViewController: BaseViewController {

    @IBOutlet weak var setBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButtonInNav()
        navigationItem.title = "添加地址"
        setBtn.layer.masksToBounds = true
        setBtn.layer.cornerRadius = 5
        saveBtn.layer.masksToBounds = true
        saveBtn.layer.cornerRadius = 5
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
