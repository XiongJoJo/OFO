//
//  PasscodeController.swift
//  OFO
//
//  Created by JoJo on 2017/6/8.
//  Copyright © 2017年 JoJo. All rights reserved.
//

import UIKit
import SwiftyTimer
import SwiftySound

class PasscodeController: UIViewController {
    
    @IBOutlet weak var label1st: MyPreviewLabel!
    @IBOutlet weak var label2nd: MyPreviewLabel!
    @IBOutlet weak var label3rd: MyPreviewLabel!
    @IBOutlet weak var label4th: MyPreviewLabel!
    
    @IBOutlet weak var showInfo: UILabel!
    
    //[8,4,5,6]
    var passArray : [String] = []
    var bikeID = ""
    let defaults = UserDefaults.standard
    
    
    
    
    @IBOutlet weak var countDownLabel: UILabel!
    
//    var remindSeconds = 121
    var remindSeconds = 21
    
    var isTorchOn = false
    var isVoiceOn = true
    
    
    @IBOutlet weak var voiceBtn: UIButton!
    
    @IBAction func voiceBtnTap(_ sender: UIButton) {
        if isVoiceOn {
            voiceBtn.setImage(#imageLiteral(resourceName: "voiceclose"), for: .normal)
        } else {
            voiceBtn.setImage(#imageLiteral(resourceName: "voiceopen"), for: .normal)
        }
        
        isVoiceOn = !isVoiceOn
    }
    
    @IBAction func torchBtnTap(_ sender: UIButton) {
        turnTorch()
        
        if isTorchOn {
            torchBtn.setImage(#imageLiteral(resourceName: "lightopen"), for: .normal)
            defaults.set(true, forKey: "isVoiceOn")
            
        } else {
            torchBtn.setImage(#imageLiteral(resourceName: "lightclose"), for: .normal)
            defaults.set(false, forKey: "isVoiceOn")
            
        }
        
        isTorchOn = !isTorchOn
    }
    
    @IBOutlet weak var torchBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "车辆解锁"
        self.navigationItem.hidesBackButton = true //隐藏返回按钮
        Sound.play(file: "您的解锁码为_D.m4a")
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1)  {
            Sound.play(file: "\(self.passArray[0])_D.m4a")
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+2)  {
            Sound.play(file: "\(self.passArray[1])_D.m4a")
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+3)  {
            Sound.play(file: "\(self.passArray[2])_D.m4a")
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+4)  {
            Sound.play(file: "\(self.passArray[3])_D.m4a")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            Sound.play(file: "上车前_LH.m4a")
        }
        


        Timer.every(1) { (timer: Timer) in
            self.remindSeconds -= 1
            self.countDownLabel.text = self.remindSeconds.description + "秒"
            
            if self.remindSeconds == 0 {
                timer.invalidate()
                
                //时间结束跳转计时页面
                self.performSegue(withIdentifier: "toTimePage", sender: self)

//                Sound.play(file:"骑行结束_LH.m4a")//这里我们时间现实结束之后播放
                
            }
        }
        
        voiceBtnStatus(voiceBtn: voiceBtn)
        
        self.label1st.text = passArray[0]
        self.label2nd.text = passArray[1]
        self.label3rd.text = passArray[2]
        self.label4th.text = passArray[3]


//        let bikeID = passArray.joined(separator: "")//数组转字符串


        
        showInfo.text = "车牌号" + bikeID + "的解锁码"
        
    }
    
    
    @IBAction func reportBtnTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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

