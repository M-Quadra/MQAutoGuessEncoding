//
//  Data+MQAutoGuessEncodingTest.swift
//  MQAutoGuessEncoding
//
//  Created by M_Quadra on 2020/3/27.
//  Copyright © 2020 M_noAria. All rights reserved.
//

import Foundation

@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
extension Data {
    
    public func mq_autoStringTest_uint4xuint4() -> String? {
        return self.mq_autoString_uint4xuint4()
    }
}
