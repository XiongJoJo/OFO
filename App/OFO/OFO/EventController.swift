//
//  EventController.swift
//  OFO
//  热门活动
//  Created by iMac on 2017/6/1.
//  Copyright © 2017年 JoJo. All rights reserved.
//

import UIKit

import WebKit

class EventController: UIViewController {

    var webView: WKWebView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView(frame: self.view.frame)
        view.addSubview(webView)
        //设置网页标题
        self.title = "热门活动"
        let url = URL (string: "http://m.ofo.so/active.html")!
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
