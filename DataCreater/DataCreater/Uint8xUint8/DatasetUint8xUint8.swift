//
//  DatasetUint8xUint8.swift
//  DataCreater
//
//  Created by M_Quadra on 2019/11/28.
//  Copyright © 2019 M_noAria. All rights reserved.
//

import Foundation

class DatasetUint8xUint8 { //base on uint8[last][next] count
    
    let markHeaderUint8xUint8: String = {
        let len = Int(UInt8.max) + 1
        var strAry = [String]()
        
        for u in 0..<len {
            for v in 0..<len {
                strAry.append(String(format: "c%dx%d", u, v))
            }
        }
        return strAry.joined(separator: ",") + ",coding"
    }()
    
    let dstRawValueAryUTF8: [UInt] = [ //some of encodings may crash, WTF
        1,
        2,
        3,
        4,
        5,
        7,
        8,
        10,
        21,
        2147483649,
        2147483650,
        2147483651,
        2147483673,
        2147484705,
        2147484706,
        2147484707,
        2147485234,
//        2147485729,
        2147485730,
//        2147485744,
//        2147485745,
        2147485760,
        2147486000,
        2147486001,
        2147486016,
        2147486209,
        2147486211,
        2147486213,
        2147486214,
//        2147486224,
//        2214592768,
        2348810496,
        2415919360,
        2483028224,
        2550137088,
        2617245952,
    ]
    
    let txtPath: String
    let csvPath: String
    let epochs: Int
    
    init(txtPath: String, csvPath: String, epochs: Int) {
        self.txtPath = txtPath
        self.csvPath = csvPath
        self.epochs = max(1, epochs)
    }
 
    func markData(txt: String) -> String {
        let len = Int(UInt8.max) + 1
        var optAry = [String]()
        
        for v in self.dstRawValueAryUTF8 {
            autoreleasepool {
                let coding = String.Encoding.init(rawValue: v)
                guard let txtData = txt.data(using: coding) else {
                    return
                }
                
                let tsTxt = String(data: txtData, encoding: coding) ?? ""
                if tsTxt != txt {
                    return
                }
                
                var cntAry = Array.init(repeating: Array.init(repeating: 0, count: len), count: len)
                let byteAry = txtData.map { Int($0.byteSwapped) }
                var lastByte = 0
                for byte in byteAry {
                    cntAry[lastByte][byte] += 1
                    lastByte = byte
                }
                
                let str = cntAry.map {
                    $0.map { String(format: "%d", $0) }.joined(separator: ",")
                }.joined(separator: ",") + String(format: ",%u", v)
                optAry.append(str)
            }
        }
        
        return optAry.joined(separator: "\n")
    }
    
    func create() {
        guard let txtData = FileManager.default.contents(atPath: self.txtPath) else {
            return
        }
        guard let txt = String(data: txtData, encoding: .utf8) else {
            return
        }
        
        var trainAry = [String]()
        let gQue = OperationQueue()
        let sQue = OperationQueue.mq_single
        
        for _ in 0..<epochs {
            autoreleasepool {
                gQue.addOperation {
                    let st = Int(arc4random())%(txt.mq_count-1100)
                    var ed = Int(arc4random())%1000
                    ed += st
                    
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
        
        let trainStr = self.markHeaderUint8xUint8 + "\n" + trainAry.joined(separator: "\n")
        try? trainStr.write(to: URL(fileURLWithPath: self.csvPath), atomically: true, encoding: .utf8)
    }
}
