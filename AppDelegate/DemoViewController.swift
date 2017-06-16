//
//  DemoViewController.swift
//  KYMart
//
//  Created by jun on 2017/6/10.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
class DemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(chooseview)
        // Do any additional setup after loading the view.
    }
    fileprivate lazy var chooseview : ChooseAddressView = {
        let chooseview = ChooseAddressView(frame: CGRect(x: 0, y: SCREEN_HEIGHT-SCREEN_WIDTH*0.6-81, width: SCREEN_WIDTH, height: SCREEN_WIDTH*0.6+81))
        return chooseview
    }()
    
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
