//
//  InputController..swift
//  OFO
//
//  Created by JoJo on 2017/6/8.
//  Copyright © 2017年 JoJo. All rights reserved.
//

import UIKit
import APNumberPad

class InputController: UIViewController,APNumberPadDelegate,UITextFieldDelegate {
    var isFlashOn = false
    var isVoiceOn = true
    let defaults = UserDefaults.standard
    
    var code = ""
    
    
    
    @IBAction func flashBtnTap(_ sender: UIButton) {
//        isFlashOn = !isFlashOn
//        
//        if isFlashOn {
//            flashBtn.setImage(#imageLiteral(resourceName: "btn_enableTorch"), for: .normal)
//        } else {
//            flashBtn.setImage(#imageLiteral(resourceName: "btn_unenableTorch"), for: .normal)
//        }
        turnTorch()
        
        if isFlashOn {
            flashBtn.setImage(#imageLiteral(resourceName: "lightclose"), for: .normal)
            defaults.set(true, forKey: "isFlashOn")
            
        } else {
            flashBtn.setImage(#imageLiteral(resourceName: "lightopen"), for: .normal)
            defaults.set(false, forKey: "isFlashOn")
            
        }
        
        isFlashOn = !isFlashOn
    }
    
    @IBAction func voiceBtnTap(_ sender: UIButton) {
        isVoiceOn = !isVoiceOn
        
        if isVoiceOn {
            voiceBtn.setImage(#imageLiteral(resourceName: "voiceopen"), for: .normal)
            
            
            defaults.set(true, forKey: "isVoiceOn")
            
        } else {
            voiceBtn.setImage(#imageLiteral(resourceName: "voiceclose"), for: .normal)
            
            defaults.set(false, forKey: "isVoiceOn")
        }
        
        
    }
    
    
    @IBOutlet weak var voiceBtn: UIButton!
    @IBOutlet weak var flashBtn: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBOutlet weak var goBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "车辆解锁"
        
        //sb自动设置
//        inputTextField.layer.borderWidth = 2
//        inputTextField.layer.borderColor = UIColor.ofo.cgColor
//        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "扫码用车", style: .plain, target: self, action: #selector(backToScan))
        
        let numberPad = APNumberPad(delegate: self)
        numberPad.leftFunctionButton.setTitle("确定", for: .normal)
        inputTextField.inputView = numberPad
        inputTextField.delegate = self
        
        goBtn.isEnabled = false  //最开始没有输入车牌号不能点击
        
        voiceBtnStatus(voiceBtn: voiceBtn)  //独立出去的UIViewHelper
    }
    
    func numberPad(_ numberPad: APNumberPad, functionButtonAction functionButton: UIButton, textInput: UIResponder) {
        checkPass()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return true
        }
        
        let newLength = text.characters.count + string.characters.count - range.length
        
        if newLength > 0 {
            goBtn.setImage(#imageLiteral(resourceName: "nextArrow_enable"), for: .normal)
            goBtn.backgroundColor = UIColor.ofo
            goBtn.isEnabled = true
            
        } else {
            goBtn.setImage(#imageLiteral(resourceName: "nextArrow_unenable"), for: .normal)
            goBtn.backgroundColor = UIColor.groupTableViewBackground
            goBtn.isEnabled = false
        }
        
        
        return newLength <= 8
        
    }
    
    
    func backToScan()  {
        navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBtnTap(_ sender: UIButton) {
        checkPass()
    }
    
    var passArray: [String] = []
    
    
    func checkPass()  {
        
        //showPasscode  动画转场
        
        if !inputTextField.text!.isEmpty {//不为空
//            let code = inputTextField.text!
            code = inputTextField.text!
            
            NetworkHelper.getPass(code: code, completion: { (pass) in
                if let pass = pass {
                    
                    self.passArray = pass.characters.map{
                        return $0.description
                    }
                    
                    
                    self.performSegue(withIdentifier: "showPasscode", sender: self)
                } else {
                    print("没获取到！")
                    self.performSegue(withIdentifier: "showErrorView", sender: self)
                }
            })
            
            
        }
    }
    

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPasscode" {
            let destVC = segue.destination as! PasscodeController
            
            destVC.passArray = self.passArray
            destVC.bikeID = self.code
            
        }
    }
    
    
    //视图返回
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        navigationController?.navigationBar.barStyle = .default
//        navigationController?.navigationBar.tintColor = UIColor.black
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:([self.navigationController.viewControllers count] -2)] animated:YES];
        
////     self.navigationController?.popToRootViewController(animated: true)
//        let firstView = ViewController()
//        //方式二：返回至指定的ViewController
//        self.navigationController?.popToViewController(firstView , animated: true)
        
    }
    
    
}
