//
//  UIViewHelper.swift
//  OFO
//
//  Created by JoJo on 2017/6/8.
//  Copyright © 2017年 JoJo. All rights reserved.
//

import Foundation

extension UIView {
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0
        }
    }
    
}


@IBDesignable class MyPreviewLabel: UILabel {
    
}

@IBDesignable class MyPreviewButton: UIButton {
    
}


import AVFoundation

func turnTorch()  {
    guard let device  = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo) else { return }
    
    if device.hasTorch && device.isTorchAvailable {
        try? device.lockForConfiguration()
        
        if device.torchMode == .off {
            device.torchMode = .on
        } else {
            device.torchMode = .off
        }
        
        device.unlockForConfiguration()
    }
    
}

func voiceBtnStatus(voiceBtn: UIButton)  {  //设定状态
    let defaults = UserDefaults.standard
    
    if defaults.bool(forKey: "isVoiceOn") {
        voiceBtn.setImage(#imageLiteral(resourceName: "voiceopen"), for: .normal)
        
    } else {
        
        voiceBtn.setImage(#imageLiteral(resourceName: "voiceclose"), for: .normal)
    }
}






