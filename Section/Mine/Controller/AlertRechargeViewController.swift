//
//  AlertRechargeViewController.swift
//  KYMart
//
//  Created by JUN on 2017/8/17.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class AlertRechargeViewController: UIViewController {
    var currentSelect:Int = 1;
    @IBOutlet weak var moneyT: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func selectAction(_ sender: UITapGestureRecognizer) {
        currentSelect = (sender.view?.tag)!
        let wechatBtn = view.viewWithTag(1)?.viewWithTag(11) as! UIButton
        let alipayBtn = view.viewWithTag(2)?.viewWithTag(11) as! UIButton
        let kuaiqianBtn = view.viewWithTag(3)?.viewWithTag(11) as! UIButton
        
        wechatBtn.setImage(sender.view?.tag == 1 ? UIImage(named:"cart_select_yes.png") : UIImage(named:"cart_select_no.png"), for: .normal)
        alipayBtn.setImage(sender.view?.tag == 2 ? UIImage(named:"cart_select_yes.png") : UIImage(named:"cart_select_no.png"), for: .normal)
        kuaiqianBtn.setImage(sender.view?.tag == 3 ? UIImage(named:"cart_select_yes.png") : UIImage(named:"cart_select_no.png"), for: .normal)
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
