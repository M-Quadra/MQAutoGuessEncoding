//
//  ViewController.swift
//  Demo
//
//  Created by M_Quadra on 2019/12/5.
//  Copyright © 2019 M_noAria. All rights reserved.
//

import UIKit
import MQAutoGuessEncoding
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
        
        print(uint4xuint4His.reduce(0.0) { $0 + $1 } / Double(uint4xuint4His.count))
        print(uint8His.reduce(0.0) { $0 + $1 } / Double(uint8His.count))
        print(garbledCheckerHis.reduce(0.0) { $0 + $1 } / Double(garbledCheckerHis.count))
        
        if #available(iOS 11.0, *) {
            let stTime = Date().timeIntervalSince1970
            for txtData in tsDataAry {
//                let txt = txtData.mq_autoString_uint4xuint4()
//                let txt = txtData.mq_autoString_uint8()
                let txt = txtData.mq_autoString_GarbledChecker()
                
                guard txt != nil else {
                    continue
                }
                
//                print("test text:", txt!.mq_substring(with: 0..<50))
            }
            print("end:\n\t", Date().timeIntervalSince1970 - stTime)
        }
    }
}

