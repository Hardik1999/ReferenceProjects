//
//  navigationmenuVC.swift
//  PracticalTest
//
//  Created by Hardik on 8/1/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class navigationmenuVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickProfile(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "idProfileVC")as! ProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onClickSapSIdi(_ sender: Any) {
        print("50 step")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
