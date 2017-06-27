//
//  NetworkHelper.swift
//  OFO
//
//  Created by JoJo on 2017/6/8.
//  Copyright © 2017年 JoJo. All rights reserved.
//

import Foundation
import AVOSCloud

struct NetworkHelper {
    
}

extension NetworkHelper {
    static func getPass(code: String,  completion: @escaping (String?) -> Void )  {
        let query = AVQuery(className: "Code")
        
        query.whereKey("code", equalTo: code)
        
        query.getFirstObjectInBackground { (code, e) in
            if let e = e {
                print("出错", e.localizedDescription)
                completion(nil)
            }
            
            if let code = code, let pass = code["pass"] as? String {
                completion(pass)
            }
        }
        
        
    }
    
}
