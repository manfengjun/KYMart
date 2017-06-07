//
//  KYProductDetailViewController.swift
//  KYMart
//
//  Created by jun on 2017/6/7.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import HMSegmentedControl

class KYProductDetailViewController: UIViewController {

    /// 新闻滚动菜单
    fileprivate lazy var segmentControl : HMSegmentedControl = {
        let segmentControl = HMSegmentedControl(frame: CGRect(x: 100, y: 20, width: SCREEN_WIDTH/2, height: 44))
        segmentControl.sectionTitles = ["测试1","测试2","测试3"]
        segmentControl.backgroundColor = UIColor.clear
        segmentControl.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.gray,NSFontAttributeName:UIFont.systemFont(ofSize: 12)]
        segmentControl.selectedTitleTextAttributes = [NSForegroundColorAttributeName:UIColor.hexStringColor(hex: "#F85959"),NSFontAttributeName:UIFont.systemFont(ofSize: 14)]
        segmentControl.selectionIndicatorColor = UIColor.hexStringColor(hex: "#F85959")
        segmentControl.selectionStyle = HMSegmentedControlSelectionStyle.fullWidthStripe
        segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocation.down
        segmentControl.selectionIndicatorHeight = 2
        segmentControl.indexChangeBlock = {(index) in
            
        }
        segmentControl.selectedSegmentIndex = 0
        return segmentControl
    }()
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64))
        scrollView.contentSize = CGSize(width: 3*SCREEN_WIDTH, height: SCREEN_HEIGHT - 64)
        scrollView.backgroundColor = UIColor.red
        return scrollView
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButtonInNav()
        view.backgroundColor = UIColor.white
        view.addSubview(scrollView)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.view.addSubview(segmentControl)

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        segmentControl.removeFromSuperview()
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
