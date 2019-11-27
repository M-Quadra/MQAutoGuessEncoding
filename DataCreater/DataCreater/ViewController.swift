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
    
    let markHeader: String = {
        let len = Int(UInt8.max) + 1
        var cntAry = Array.init(repeating: 0, count: len)
        for i in 0..<cntAry.count {
            cntAry[i] = i
        }
        
        let strAry = cntAry.map { String(format: "c%d", $0) }
        return strAry.joined(separator: ",") + ",coding"
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filePath = "/Users/m_quadra/Library/Mobile Documents/com~apple~CloudDocs/异化都市UTF8.txt"
        let txtData = FileManager.default.contents(atPath: filePath) ?? Data()
        let txt = String(data: txtData, encoding: .utf8) ?? ""
        
        var trainAry = [String]()
        let gQue = OperationQueue()
        let sQue = OperationQueue.mq_single
        
        for _ in 0..<100 {
            autoreleasepool {
                gQue.addOperation {
                    var st = Int(arc4random())%txt.mq_count
                    var ed = Int(arc4random())%txt.mq_count
                    if st > ed {
                        swap(&st, &ed)
                    }
                    
                    let subStr = txt.mq_substring(with: st...ed)
                    let train = self.markData(txt: subStr)
                    
                    sQue.addOperation {
                        trainAry.append(train)
                    }
                }
            }
        }
        
        gQue.waitUntilAllOperationsAreFinished()
        sQue.waitUntilAllOperationsAreFinished()
        let trainStr = self.markHeader + "\n" + trainAry.joined(separator: "\n")
        
        try? trainStr.write(to: URL(fileURLWithPath: "/Users/m_quadra/Desktop/optTs/DataSet.csv"), atomically: true, encoding: .utf8)
    }
    
    func markData(txt: String) -> String {
        var optAry = [String]()
        
        let len = Int(UInt8.max) + 1//256
        for v in self.codingRawValueAry {
            autoreleasepool {
                let coding = String.Encoding.init(rawValue: v)
                guard let txtData = txt.data(using: coding) else {
//                    continue
                    return
                }
                
                var cntAry = Array.init(repeating: 0, count: len)
                let byteAry = txtData.map { Int($0.byteSwapped) }
                for byte in byteAry {
                    cntAry[byte] += 1
                }
                
                let strAry = cntAry.map { String(format: "%d", $0) }
                let str = strAry.joined(separator: ",") + String(format: ",%u", v)
                optAry.append(str)
            }
        }
        
        return optAry.joined(separator: "\n")
    }

}

