//
//  DatasetUint4xUint4.swift
//  DataCreater
//
//  Created by M_Quadra on 2019/12/4.
//  Copyright © 2019 M_noAria. All rights reserved.
//

import Foundation

class DatasetUint4xUint4 {
    
    static let markHeader: String = {
        var optAry = [String]()
        for u in 0..<16 {
            for v in 0..<16 {
                optAry.append(String(format: "c%dx%d", u, v))
            }
        }
        
        return optAry.joined(separator: ",") + ",coding"
    }()
    
    let codingRawValueAry: [UInt] = {
                let cfAry = CFStringEncodings.mq_AllValues.map { $0.mq_StringEncoding.rawValue }
                let stAry = String.Encoding.mq_allValues.map { $0.rawValue }
                
                var uniSet = Set(cfAry + stAry)
                
                var ary = Array(uniSet)
                ary.sort()
                return ary
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
        var optAry = [String]()
        let len = 0xF + 1
        
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
                var lastByte = 0
                let byteAry = txtData.map { Int($0.byteSwapped) }
                for byte in byteAry {
                    var tmp = byte&0xF
                    cntAry[lastByte][tmp] += 1
                    lastByte = tmp
                    tmp = byte>>4
                    cntAry[lastByte][tmp] += 1
                    lastByte = tmp
                }
                
                let str = cntAry.map {
                    $0.map { String(format: "%d", $0) }.joined(separator: ",")
                }.joined(separator: ",") + String(format: ",c%u", v)
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
        
        for _ in 0..<self.epochs {
            autoreleasepool {
                gQue.addOperation {
                    var subStr = ""
                    for _ in 0..<10 {
                        let st = Int(arc4random())%(txt.mq_count-110)
                        var ed = Int(arc4random())%100
                        ed += st
                        
                        subStr += txt.mq_substring(with: st...ed)
                    }
                    let train = self.markData(txt: subStr)
                    
                    sQue.addOperation {
                        trainAry.append(train)
                    }
                }
            }
        }
        
        gQue.waitUntilAllOperationsAreFinished()
        sQue.waitUntilAllOperationsAreFinished()
        
        let trainStr = trainAry.joined(separator: "\n")
        try? trainStr.write(to: URL(fileURLWithPath: self.csvPath), atomically: true, encoding: .utf8)
    }
}
