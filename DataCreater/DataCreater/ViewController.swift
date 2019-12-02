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
        
//        let tsPath = "/Users/m_quadra/Downloads/今世猛男.txt"
//        let tsPath = "/Users/m_quadra/Library/Mobile Documents/com~apple~CloudDocs/异化都市UTF8.txt"
        let tsPath = "/Users/m_quadra/Library/Mobile Documents/com~apple~CloudDocs/异化都市[bookben.net].txt"
        let txtPath = "/Users/m_quadra/Library/Mobile Documents/com~apple~CloudDocs/异化都市UTF8.txt"
        let optPath = "/Users/m_quadra/Desktop/optTs/DataSet.csv"
        
        let dsUint8 = DatasetUint8(
            txtPath: txtPath,
            csvPath: optPath,
            epochs: 10000
        )
//        dsUint8.create()
//        return
        
        let tsData = FileManager.default.contents(atPath: tsPath) ?? Data()
        let stTime = Date().timeIntervalSince1970
        print(Date().timeIntervalSince1970)
        if let tsStr = dsUint8.test(data: tsData) {
            print(Date().timeIntervalSince1970 - stTime)//3.2s
            print(tsStr.mq_substring(with: 0..<10))
        }
        
        return
        let dsUint8xUint8 = DatasetUint8xUint8(
            txtPath: txtPath,
            csvPath: optPath,
            epochs: 100
        )
        dsUint8xUint8.create()
    }

    
}

