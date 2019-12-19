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
            "",
            "",
            "",
            "",
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
            0.30077314376831055,
            0.30179905891418457,
            0.3020181655883789,
            0.30063796043395996,
            0.30736732482910156,
        ]
        let uint8His = [
            0.30143213272094727,
            0.3006319999694824,
            0.3004429340362549,
            0.30138587951660156,
        ]
        let garbledCheckerHis = [
            2.1697919368743896,
            2.0125160217285156,
            2.186439037322998,
            2.106135845184326,
        ]
        
        let uint4xuint4HisOC = [
            0.33805418014526367,
            0.34148073196411133,
            0.33992815017700195,
            0.3395211696624756,
        ]
        
        print("uint4xuint4", "\t", uint4xuint4His.reduce(0.0) { $0 + $1 } / Double(uint4xuint4His.count))
        print("uint8", "\t\t\t", uint8His.reduce(0.0) { $0 + $1 } / Double(uint8His.count))
        print("garbledChecker", "\t", garbledCheckerHis.reduce(0.0) { $0 + $1 } / Double(garbledCheckerHis.count))
        print()
        print("uint4xuint4 OC", "\t", uint4xuint4HisOC.reduce(0.0) { $0 + $1 } / Double(uint4xuint4HisOC.count))
        
        if #available(iOS 11.0, *) {
            let stTime = Date().timeIntervalSince1970
            
//            for txtData in tsNSDataAry {
            for txtData in tsDataAry {
//                let txt = txtData.mq_autoString_uint4xuint4()
//                let txt = txtData.mq_autoString_uint8()
                let txt = txtData.mq_autoString_GarbledChecker()

//                let txt = txtData.mq_autoString()
                
                guard txt != nil else {
                    continue
                }
                
//                print("test text:", txt!.mq_substring(with: 0..<50))
            }
            
            print("end:\n\t", Date().timeIntervalSince1970 - stTime)
        }
    }
}

