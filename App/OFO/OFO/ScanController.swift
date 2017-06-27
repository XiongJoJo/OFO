//
//  ScanController.swift
//  OFO
//  扫码界面
//  Created by iMac on 2017/6/5.
//  Copyright © 2017年 JoJo. All rights reserved.
//

import UIKit
import swiftScan
import FTIndicator

class ScanController: LBXScanViewController {


    
    var isFlashOn = false
    
    @IBOutlet weak var flashBtn: UIButton!
    @IBAction func flashBtnTap(_ sender: UIButton) {
        isFlashOn = !isFlashOn
        
        scanObj?.changeTorch()
        
        if isFlashOn{
            flashBtn.setImage(#imageLiteral(resourceName: "btn_enableTorch_w"), for: .normal)
        }else{
            flashBtn.setImage(#imageLiteral(resourceName: "btn_unenableTorch_w"), for: .normal)
        }
    
    }
    
    
    @IBOutlet weak var panelView: UIView!
    
    override func handleCodeResult(arrayResult: [LBXScanResult]) {
        if let result = arrayResult.first {
            let msg = result.strScanned
            
            FTIndicator.setIndicatorStyle(.dark)
            FTIndicator.showToastMessage(msg)
            print("扫码:",msg!)
            
            DispatchQueue.main.asyncAfter(deadline: .now()+1)  {  //添加这个可以解决重复扫码的bug
                if msg != nil {
                    self.checkPass(code: msg!)
                }else{
                    
                }
            }
           
        }
    }
    
    var passArray: [String] = []
    
    func checkPass(code: String)  {
        
        //showPasscode  动画转场
            
            NetworkHelper.getPass(code: code, completion: { (pass) in
                if let pass = pass {
                    
                    self.passArray = pass.characters.map{
                        return $0.description
                    }
                    
                    
                    self.performSegue(withIdentifier: "showPasscode2", sender: self)
                } else {
                    print("没获取到！")
                    self.performSegue(withIdentifier: "showErrorView2", sender: self)
                }
            })
            
}
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "扫码用车"
        
        //黑色半透明效果
        navigationController?.navigationBar.barStyle = .blackTranslucent
        navigationController?.navigationBar.tintColor = UIColor.white
        
        var style = LBXScanViewStyle()
        style.anmiationStyle = .NetGrid
        style.animationImage = UIImage(named: "CodeScan.bundle/qrcode_scan_part_net")
        
        scanStyle = style
        // Do any additional setup after loading the view.
    }
    
    //视图加载完再设置才有效
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.bringSubview(toFront: panelView)
    }
    
    
    //视图返回
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //转场动画
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPasscode2" {
            let destVC = segue.destination as! PasscodeController
            
            destVC.passArray = self.passArray
            
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
