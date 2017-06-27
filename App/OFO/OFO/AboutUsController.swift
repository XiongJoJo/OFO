//
//  AboutUsController.swift
//  OFO
//
//  Created by iMac on 2017/6/1.
//  Copyright © 2017年 JoJo. All rights reserved.
//

import UIKit
import SWRevealViewController

class AboutUsController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //视图
        //最开始启动容器
        
        if let revealVC = revealViewController() {
            
            revealVC.rearViewRevealWidth = 280 //如果侧边栏显示不完全就需要设置宽度
            
            navigationItem.leftBarButtonItem?.target = revealVC
            navigationItem.leftBarButtonItem?.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
        
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
