//
//  SpitslotController.swift
//  OFO
//  吐槽页面
//  Created by JoJo on 2017/6/11.
//  Copyright © 2017年 JoJo. All rights reserved.
//

import UIKit
import WebKit

class SpitslotController: UIViewController {

    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView(frame: self.view.frame)
        view.addSubview(webView)
        //设置网页标题
       
        if (self.isKind(of:ViewController.self)) {
            self.title = "吐槽"
        }else{
        self.title = "报修"
        }

        
//        if (SpitslotController.isKind(of: ViewController()) {
//             self.title = "吐槽"
//        }else{
//            self.title = "报修"
//        }

        let url = URL (string: "https://common.ofo.so/newdist/?Prosecute&time=1494868261998")!
        let request = URLRequest(url: url)
        
        
        //注意:请求加载需要添加明文http权限 plist文件里面 App Transport Security Settings->Allow Arbitrary Loads->YES
        
        webView.load(request)
        
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
