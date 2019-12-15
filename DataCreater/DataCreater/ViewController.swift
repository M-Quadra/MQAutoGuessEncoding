//
//  ViewController.swift
//  DataCreater
//
//  Created by M_Quadra on 2019/11/27.
//  Copyright © 2019 M_noAria. All rights reserved.
//

import UIKit
import MQKit

class ViewController: UIViewController {

    let codingRawValueAry: [UInt] = {
        let cfAry = CFStringEncodings.mq_AllValues.map { $0.mq_StringEncoding.rawValue }
        let stAry = String.Encoding.mq_allValues.map { $0.rawValue }
        
        var uniSet = Set(cfAry + stAry)
//        print(uniSet.count)//141
        
        var ary = Array(uniSet)
        ary.sort()
        return ary
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let txtPath = "/Users/xxxx.txt"
        let optPath = "/Users/xxxx/DataSet.csv"
        
        let dsUint4xUint4 = DatasetUint4xUint4(
            txtPath: txtPath,
            csvPath: optPath,
            epochs: 3000
        )
//        dsUint4xUint4.create()
//        return
        
        let dsHex = DatasetHex(
            txtPath: txtPath,
            csvPath: optPath,
            epochs: 10000
        )
//        dsHex.create()

        let dsUint8 = DatasetUint8(
            txtPath: txtPath,
            csvPath: optPath,
            epochs: 10000
        )
//        dsUint8.create()
//        return
        
        let dsUint8xUint8 = DatasetUint8xUint8(
            txtPath: txtPath,
            csvPath: optPath,
            epochs: 100
        )
//        dsUint8xUint8.create()
    }

    
}

