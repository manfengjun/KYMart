//
//  MainTabBarViewController.swift
//  KYMart
//
//  Created by Jun on 2017/6/4.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
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
extension MainTabBarViewController:UITabBarControllerDelegate{
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.tabBarItem.title == "购物车" || viewController.tabBarItem.title == "我的" {
            if SingleManager.instance.isLogin {
                return true
            }
            else{
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let loginNav = storyboard.instantiateViewController(withIdentifier: "loginNav") as! BaseNavViewController
                let loginVC = loginNav.viewControllers[0] as! SJBLoginViewController
                loginVC.loginResult({ (isLogin) in
                    if isLogin {
                        if viewController.tabBarItem.title == "购物车"{
                           self.selectedIndex = 2
                        }
                        else
                        {
                            self.selectedIndex = 3
                        }
                        
                    }
                })
                loginVC.hidesBottomBarWhenPushed = true
                self.present(loginNav, animated: true, completion: nil)
//                nav.pushViewController(loginVC, animated: true)
                return false
            }
        }
        else{
            return true
        }
    }
}
