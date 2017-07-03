//
//  KYQrCodeViewController.swift
//  KYMart
//
//  Created by JUN on 2017/7/2.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYQrCodeViewController: BaseViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var imageUrl:URL?{
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "二维码"
        setBackButtonInNav()
        dataRequest()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    func dataRequest() {
        SJBRequestModel.pull_fetchQrCodeData { (response, status) in
            if status == 1{
                if let text = response["url"]{
                    self.imageUrl = URL(string: imgPath + (text as! String))
//                    let url = URL(string: imgPath + (text as! String))
//                    self.qrCodeIV.sd_setImage(with: url, placeholderImage: nil, options: .retryFailed, completed: { (image, error, cacheType, url) in
//                        
//                    })
//                    self.qrCodeIV.sd_setImage(with: url, placeholderImage: nil)
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
extension KYQrCodeViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kYQrCodeTVCell", for: indexPath) as! KYQrCodeTVCell
        cell.qrCodeIV.sd_setImage(with: self.imageUrl, placeholderImage: nil)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCREEN_WIDTH*105/59
    }
}
