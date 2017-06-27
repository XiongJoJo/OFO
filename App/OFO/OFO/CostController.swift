//
//  CostController.swift
//  OFO
//  支付页面
//  Created by JoJo on 2017/6/12.
//  Copyright © 2017年 JoJo. All rights reserved.
//

import UIKit
import SwiftySound
import FTIndicator

class CostController: UIViewController {

    var moneyValue: Int = 0
    
    @IBOutlet weak var monValLab: UILabel!
    
    @IBAction func playTouch(_ sender: Any) {
        let hintTitle = "成功支付"
        let hintSubtile = "\(self.moneyValue)元"
        
   
        DispatchQueue.main.asyncAfter(deadline: .now()+1)  {
            FTIndicator.setIndicatorStyle(.dark)
            FTIndicator.showNotification(with: #imageLiteral(resourceName: "UnlockSucess"), title: hintTitle, message: hintSubtile)
            
            self.navigationController?.popToRootViewController(animated: true)
        }
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "行程消费"
        monValLab.text = "\(self.moneyValue)"
        Sound.play(file:"骑行结束_LH.m4a")//这里我们时间现实结束之后播放

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
