//
//  DatasetHex.swift
//  DataCreater
//
//  Created by M_Quadra on 2019/12/2.
//  Copyright © 2019 M_noAria. All rights reserved.
//

import Foundation

class DatasetHex {
    
    let markHeader: String = "hex,coding"
    
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
                
                let byteAry = txtData.map { String(format: "%X", $0.byteSwapped) }
                let str = byteAry.joined(separator: "") + String(format: ",c%u", v)
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
                let st = Int(arc4random())%(txt.mq_count-1100)
                var ed = Int(arc4random())%1000
                ed += st
                
                gQue.addOperation {
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
        try? trainStr.write(to: URL(fileURLWithPath: self.csvPath), atomically: true, encoding: .utf8)
    }
    
}
