//
//  ViewController.swift
//  Demo
//
//  Created by M_Quadra on 2019/12/5.
//  Copyright © 2019 M_noAria. All rights reserved.
//

import UIKit
import MQAutoGuessEncoding
import MQAutoGuessEncodingOC
import MQKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tsPathAry = [
            "/Users/m_quadra/Desktop/TestData/mdzs-utf8.txt",
            "/Users/m_quadra/Desktop/TestData/jsmn-gb2312.txt",
            "/Users/m_quadra/Desktop/TestData/jsmn-utf8.txt",
            "/Users/m_quadra/Desktop/TestData/yhds-gb2312.txt",
            "/Users/m_quadra/Desktop/TestData/yhds-utf8.txt",
            "/Users/m_quadra/Desktop/TestData/wbqd-utf8.txt",
            "/Users/m_quadra/Desktop/TestData/wbw-utf8.txt",
            "/Users/m_quadra/Desktop/TestData/wbdl-gb2312.txt",
            "/Users/m_quadra/Desktop/TestData/wbdl-utf8.txt",
            "/Users/m_quadra/Desktop/TestData/wbzw-gb2312.txt",
            "/Users/m_quadra/Desktop/TestData/wbzw-utf8.txt",
            "/Users/m_quadra/Desktop/TestData/wbzh-utf8.txt",
            "/Users/m_quadra/Desktop/TestData/wbyq-gb2312.txt",
            "/Users/m_quadra/Desktop/TestData/wbyq-utf8.txt",
            "/Users/m_quadra/Desktop/TestData/wbbx-gb2312.txt",
            "/Users/m_quadra/Desktop/TestData/wbbx-utf8.txt",
            "/Users/m_quadra/Desktop/TestData/wbym-gb2312.txt",
            "/Users/m_quadra/Desktop/TestData/wbym-utf8.txt",
        ]
        
        var tsDataAry = [Data]()
        for path in tsPathAry {
            guard let txtData = FileManager.default.contents(atPath: path) else {
                continue
            }
            
            tsDataAry.append(txtData)
        }
        let tsNSDataAry = tsDataAry.map { NSData(data: $0) }
        
        let uint4xuint4His = [
            0.0,
        ]
        let uint8His = [
            0.0,
        ]
        let garbledCheckerHis = [
            0.0,
        ]
        
        let uint4xuint4HisOC = [
            0.0,
        ]
        
        print("uint4xuint4", "\t", uint4xuint4His.reduce(0.0) { $0 + $1 } / Double(uint4xuint4His.count))
        print("uint8", "\t\t\t", uint8His.reduce(0.0) { $0 + $1 } / Double(uint8His.count))
        print("garbledChecker", "\t", garbledCheckerHis.reduce(0.0) { $0 + $1 } / Double(garbledCheckerHis.count))
        print()
        print("uint4xuint4 OC", "\t", uint4xuint4HisOC.reduce(0.0) { $0 + $1 } / Double(uint4xuint4HisOC.count))
        
        if #available(iOS 11.0, *) {
            let stTime = Date().timeIntervalSince1970
            
//            for txtData in tsNSDataAry {
            for i in 0..<tsDataAry.count {
                let txtData = tsDataAry[i]
                
                let txt = txtData.mq_autoStringTest_uint4xuint4()
//                let txt = txtData.mq_autoString_uint8()
//                let txt = txtData.mq_autoString_GarbledChecker()

//                let txt = txtData.mq_autoString()
                
                guard txt != nil else {
                    print("[AutoGuessEncoding] fail:", tsPathAry[i])
                    continue
                }
                
                print("test text:", txt!.mq_substring(with: 0..<50))
            }
            
            print("end:\n\t", Date().timeIntervalSince1970 - stTime)
        }
    }
}

