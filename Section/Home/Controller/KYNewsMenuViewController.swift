//
//  KYNewsMenuViewController.swift
//  KYMart
//
//  Created by jun on 2017/9/5.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import HMSegmentedControl
class KYNewsMenuViewController: BaseViewController {
    
    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    /// 系统公告
    fileprivate lazy var systemNoticeVC:KYNewsListViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let systemNoticeVC = storyboard.instantiateViewController(withIdentifier: "kYNewsListVC") as!  KYNewsListViewController
        systemNoticeVC.view.frame = CGRect(x: 0, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
        systemNoticeVC.type = "1"
        return systemNoticeVC
    }()
    
    /// 订单消息
    fileprivate lazy var orderNoticeVC:KYNewsListViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let orderNoticeVC = storyboard.instantiateViewController(withIdentifier: "kYNewsListVC") as!  KYNewsListViewController
        orderNoticeVC.view.frame = CGRect(x: SCREEN_WIDTH, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
        orderNoticeVC.type = "2"
        return orderNoticeVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        setBackButtonInNav()
        scrollView.addSubview(systemNoticeVC.view)
        addChildViewController(systemNoticeVC)
        scrollView.addSubview(orderNoticeVC.view)
        addChildViewController(orderNoticeVC)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let segY:CGFloat = isIphoneX() ? 53 : 29
        segmentControl.frame = CGRect(x: SCREEN_WIDTH/2 - SCREEN_WIDTH/4, y: segY, width: SCREEN_WIDTH/2, height: 26)
        navigationController?.view.addSubview(segmentControl)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        segmentControl.removeFromSuperview()
    }


    @IBAction func valueChangeAction(_ sender: UISegmentedControl) {
        scrollView.contentOffset = CGPoint(x: SCREEN_WIDTH*CGFloat(sender.selectedSegmentIndex), y: 0)
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
extension KYNewsMenuViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x/SCREEN_WIDTH
        segmentControl.selectedSegmentIndex = Int(index)
    }
}
