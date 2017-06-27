//
//  TimeController.swift
//  OFO
//
//  Created by JoJo on 2017/6/11.
//  Copyright © 2017年 JoJo. All rights reserved.
//

import UIKit

class TimeController: UIViewController {

    @IBOutlet weak var timeLab: UILabel!
    @IBOutlet weak var moneyLab: UILabel!
    fileprivate var remindTimerNumber: Int = 0
    fileprivate var costTip: Int = 0
    var userTime = 0
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "骑行中"
        
        self.navigationItem.hidesBackButton = true //隐藏返回按钮
//        self.removeGlobalPanGes()
//        self.navigationController.removeGlobalPanGes()
        
        Timer.every(1) { (timer: Timer) in
            self.userTime += 1
            self.timeLab.text = TimeHelper.getFormatTimeWithTimeInterval(timeInterval: Double(self.userTime))
            switch self.remindTimerNumber/3600 {
            case 0:
                self.costTip = 1
            case 1:
                self.costTip = 2
            case 2:
                self.costTip = 3
            case 3:
                self.costTip = 4
            case 4:
                self.costTip = 5
            case 5:
                self.costTip = 6
            default:
                self.costTip =  (self.costTip > 6) ? 6 : 0
                break
            }
            self.moneyLab.text = "当前费用\(self.costTip)元"
            
//
//            if self.remindSeconds == 0 {
//                timer.invalidate()
//                
//                //时间结束跳转计时页面
//                self.performSegue(withIdentifier: "toTimePage", sender: self)
//                
//                //                Sound.play(file:"骑行结束_LH.m4a")//这里我们时间现实结束之后播放
//                
//            }
        }

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 移除全局手势
    func removeGlobalPanGes() {
        //        for ges in self.view.gestureRecognizers! where ges is UIPanGestureRecognizer {
        //            print(ges)
        //            self.view.gestureRecognizers?.remove(at: 1)
        //        }
        for case let ges as UIPanGestureRecognizer in self.view.gestureRecognizers! {
            let i = self.view.gestureRecognizers?.index(of: ges)
            self.view.gestureRecognizers?.remove(at: i!)
            print(ges)
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

      //由于此页面有两个跳转,所以需要指定
            if segue.identifier == "toCostPage" {
                let destVC = segue.destination as! CostController
                destVC.moneyValue = self.costTip //传价格值
        }

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
