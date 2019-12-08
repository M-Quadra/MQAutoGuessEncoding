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
            0.3109607696533203,
            0.3103048801422119,
            0.31209588050842285,
            0.3134729862213135,
        ]
        let uint8His = [
            0.3122749328613281,
            0.3117527961730957,
            0.31409692764282227,
            0.3134450912475586,
        ]
        let garbledCheckerHis = [
            2.178936004638672,
            2.098605155944824,
            1.9216411113739014,
            2.051802158355713,
        ]
        
        let uint4xuint4HisOC = [
            0.33609509468078613,
            0.33856916427612305,
            0.33765292167663574,
            0.3384971618652344,
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

