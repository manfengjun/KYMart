//
//  KYMineViewController.swift
//  KYMart
//
//  Created by jun on 2017/6/14.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class KYMineViewController: UIViewController {

    @IBOutlet var headView: UIView!
    @IBOutlet var tableView: UITableView!
    fileprivate let var titleArray =
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension KYMineViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KYMineTVCell", for: indexPath)
        return cell
    }
}
