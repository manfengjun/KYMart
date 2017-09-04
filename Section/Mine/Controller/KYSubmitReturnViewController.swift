//
//  KYSubmitReturnViewController.swift
//  KYMart
//
//  Created by JUN on 2017/8/27.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit
import TZImagePickerController

fileprivate let KYSubmitReturnTVCellIdentifier = "kYSubmitReturnTVCell"

class KYSubmitReturnViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var model : Order_Info_Goods_list?
    fileprivate lazy var imageArray : [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func setupUI() {
        setBackButtonInNav()
        navigationItem.title = "申请退货"
    }
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension KYSubmitReturnViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KYSubmitReturnTVCellIdentifier, for: indexPath) as! KYSubmitReturnTVCell
        cell.model = model
        cell.imageArray = imageArray
        cell.addResult {
            //添加图片
            let imagePicker = TZImagePickerController(maxImagesCount: 1, delegate: self)
            imagePicker?.maxImagesCount = 9
            imagePicker?.naviBgColor = BAR_TINTCOLOR
            imagePicker?.title = "选择图片"
            imagePicker?.allowPickingOriginalPhoto = false
            imagePicker?.didFinishPickingPhotosHandle = {(photos,assets,isSelectOriginalPhoto) -> Void in
                if isSelectOriginalPhoto {
                    //原图
                    // 你可以通过一个asset获得原图，通过这个方法：[[TZImageManager manager] getOriginalPhotoWithAsset:completion:]
//                    if let array = assets {
//                        TZImageManager.default().getOriginalPhoto(withAsset: array[0], completion: { (image, info) in
//                            if let temImage = image{
////                                self.uploadImage(image: temImage)
//                                
//                            }
//                        })
//                    }
                }
                else{
                    //非原图
                    if let array = photos{
                        self.imageArray += array
                        self.tableView.reloadData()
                    }
                }
            }
            self.present(imagePicker!, animated: true, completion: nil)
            
        }
        cell.submitResult {
            self.model?.reason = cell.descriT.text
            SJBRequest.UpLoadImages(url: SJBRequestUrl.returnReturnUrl(), model: self.model!, images: self.imageArray) { (response, status) in
                if status == 1{
                    
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCREEN_HEIGHT - 64
    }
}
extension KYSubmitReturnViewController:TZImagePickerControllerDelegate{

}
