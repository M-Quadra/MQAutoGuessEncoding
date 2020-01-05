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
    
    let txtPathAry = [
        "/Users/m_quadra/Desktop/TestData/yhds-utf8.txt",
        "/Users/m_quadra/Desktop/TestData/jsmn-utf8.txt",
        "/Users/m_quadra/Desktop/TestData/wbw-utf8.txt",
        "/Users/m_quadra/Desktop/TestData/wbdl-utf8.txt",
        "/Users/m_quadra/Desktop/TestData/wbqd-utf8.txt",
        "/Users/m_quadra/Desktop/TestData/wbzw-utf8.txt",
        "/Users/m_quadra/Desktop/TestData/wbzh-utf8.txt",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let optPath = "/Users/m_quadra/Desktop/optTs/DataSet.csv"
        
        self.createDataset()
        return
        
        let dsHex = DatasetHex(
            txtPath: txtPathAry[0],
            csvPath: optPath,
            epochs: 10000
        )
//        dsHex.create()

        let dsUint8 = DatasetUint8(
            txtPath: txtPathAry[0],
            csvPath: optPath,
            epochs: 10000
        )
//        dsUint8.create()
//        return
        
        let dsUint8xUint8 = DatasetUint8xUint8(
            txtPath: txtPathAry[0],
            csvPath: optPath,
            epochs: 100
        )
//        dsUint8xUint8.create()
    }

    func createDataset() {
        var optAry = [String]()
        
        for i in 0..<txtPathAry.count {
            let txtPath = txtPathAry[i]
            let suboptPath = String(format: "/Users/m_quadra/Desktop/optTs/DataSet-%d.csv", i)
            
            let creator = DatasetUint8(
//            let creator = DatasetUint4xUint4(
                txtPath: txtPath,
                csvPath: suboptPath,
                epochs: 2000
            )
            creator.create()
            
            guard let subData = FileManager.default.contents(atPath: suboptPath) else {
                continue
            }
            guard let opt = String(data: subData, encoding: .utf8) else {
                continue
            }
            optAry.append(opt)
        }
        
        let optPath = "/Users/m_quadra/Desktop/optTs/DataSet.csv"
        let opt = DatasetUint8.markHeader + "\n" + optAry.joined(separator: "\n")
//        let opt = DatasetUint4xUint4.header + "\n" + optAry.joined(separator: "\n")
        try? opt.write(to: URL(fileURLWithPath: optPath), atomically: true, encoding: .utf8)
        print("output finish")
    }
    
}

