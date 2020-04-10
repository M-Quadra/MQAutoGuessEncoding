//
//  Data+MQAutoGuessEncoding.swift
//  MQAutoGuessEncoding
//
//  Created by M_Quadra on 2020/3/26.
//  Copyright © 2020 M_noAria. All rights reserved.
//

import Foundation

extension Data {
    
    public func mq_autoString() -> String? {
        var str: String? = nil
        if #available(iOS 11.0, *), count > 100 {
            str = self.mq_autoString_uint4xuint4()
        }
        if str == nil {
            print("[MQAutoGuessEncoding] fail... try utf8")
            str = String(data: self, encoding: .utf8)
        }
        if str == nil {
            print("[MQAutoGuessEncoding] fail... try GB_18030_2000")
            str = String(data: self, encoding: String.Encoding(rawValue: UInt(CFStringEncodings.GB_18030_2000.rawValue)))
        }
        
        return str
    }
}
