//
//  KYQrCodeViewController.swift
//  KYMart
//
//  Created by JUN on 2017/7/2.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYQrCodeViewController: BaseViewController {

    @IBOutlet weak var qrCodeIV: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButtonInNav()
        dataRequest()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.subviews[0].alpha = 0

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.subviews[0].alpha = 1
        
    }
    func dataRequest() {
        SJBRequestModel.pull_fetchQrCodeData { (response, status) in
            if status == 1{
                if let imageUrl = response["url"]{
                    let url = URL(string: imgPath + (imageUrl as! String))
                    self.qrCodeIV.sd_setImage(with: url, placeholderImage: nil, options: .retryFailed, completed: { (image, error, cacheType, url) in
                        
                    })
                    self.qrCodeIV.sd_setImage(with: url, placeholderImage: nil)
                }
                
            }
            else
            {
                self.Toast(content: "获取二维码失败")
            }
        }
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
