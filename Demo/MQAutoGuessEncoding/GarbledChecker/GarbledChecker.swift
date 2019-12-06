//
//  GarbledChecker.swift
//  Demo
//
//  Created by M_Quadra on 2019/12/6.
//  Copyright © 2019 M_noAria. All rights reserved.
//

import Foundation
import CoreML


@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
extension Data {

    struct MQEncodingResult {
        var encoding: String.Encoding? = nil
        var cacheText: String? = nil
    }

    fileprivate func model_GarbledChecker() -> MQGarbledChecker? {
        let bundle = Bundle(for: MQGarbledChecker.self)
        if bundle.url(forResource: "MQGarbledChecker", withExtension:"mlmodelc") != nil {
            return MQGarbledChecker()
        }

        guard let modelPath = bundle.path(forResource: "MQGarbledChecker", ofType: "mlmodel") else {
            return nil
        }

        let modelURL = URL(fileURLWithPath: modelPath)
        guard let mlmodelcURL = try? MLModel.compileModel(at: modelURL) else {
            return nil
        }
        guard let model = try? MQGarbledChecker.init(contentsOf: mlmodelcURL) else {
            return nil
        }

        return model
    }

    fileprivate func isNormal(_ text: String, model: MQGarbledChecker, usePrivateUseArea: Bool = true) -> Bool {
        // 私用区(都用私用区了, 还猜啥编码？)
        // 文本有小概率混入私用区字符, 最终检查取2/3概率
        let privateUseAreaRange = 0xE000...0xF8FF

        var subTxt = text.replacingOccurrences(of: "\r", with: "")
        subTxt = subTxt.replacingOccurrences(of: "\n", with: "")
        subTxt = subTxt.replacingOccurrences(of: " ", with: "")

        let strCnt = Double(subTxt.mq_count)
        let utf16Cnt = Double(subTxt.utf16.count)
        let info = subTxt.mq_wordInfo_old
        var privateUseAreaCnt = 0
        var asciiCnt = 0

        for code in subTxt.utf16 {
            if code <= 127 {
                asciiCnt += 1
            }

            if usePrivateUseArea {
                if privateUseAreaRange.contains(Int(code)) {
                    privateUseAreaCnt += 1
                } else if code == 0x00A0 {// 无中断空格(拉丁文补充1)
                    privateUseAreaCnt += 1
                }
            }
        }

        if asciiCnt == subTxt.utf16.count {
            return true
        }

        let checkerOpt = try? model.prediction(strCnt: strCnt,
                                               utf16Cnt: utf16Cnt,
                                               wordSetCnt: Double(info.wordSet.count),
                                               maxWordStrCnt: Double(info.maxWordStringCount),
                                               minWordStrCnt: Double(info.minWordStringCount),
                                               privateUseAreaCnt: Double(privateUseAreaCnt))

        guard checkerOpt?.isNormal == 1 else {
            return false
        }

        return true
    }

    fileprivate func mq_autoGuessEncoding_GarbledChecker() -> MQEncodingResult? {
        guard let model = model_GarbledChecker() else {
            return nil
        }

        var stData = self
        let flagSet: Set<UInt8> = [10, 13, 32]

        if self.count > 300 {
            for i in 290..<self.count {
                if !flagSet.contains(self[i]) {
                    continue
                }

                stData = self[0...i]
                break
            }
        }

        let cfEncodingsAry = CFStringEncodings.mq_AllValues.map { $0.mq_StringEncoding }
        let encodingAry = String.Encoding.mq_allValues + cfEncodingsAry

        // local encoding check
        // 局部编码检查
        let setterQue = OperationQueue.mq_single

        var localEncodingAry: [String.Encoding] = []
        DispatchQueue.concurrentPerform(iterations: encodingAry.count) { (i) in
            let encoding = encodingAry[i]
            guard let tsStr = String(data: stData, encoding: encoding) else {
                return
            }
            guard self.isNormal(tsStr, model: model) else {
                return
            }

            setterQue.addOperation {
                localEncodingAry.append(encoding)
            }
        }
        setterQue.waitUntilAllOperationsAreFinished()

        #if DEBUG
        print("[MQKit] mq_autoEncoding first check over. encoding count:", localEncodingAry.count)
        #endif

        var opt = MQEncodingResult()
        if localEncodingAry.count == 1, let encoding = localEncodingAry.first {
            opt.encoding = encoding
            return opt
        }
        if localEncodingAry.count <= 0 {
            return opt
        }

        let opQue = OperationQueue.mq_max
        for encoding in localEncodingAry {
            opQue.addOperation {
                guard let txt = String(data: self, encoding: encoding) else {
                    return
                }

                let len = 100
                var normalCnt = 0

                DispatchQueue.concurrentPerform(iterations: 3) { (_) in
                    let st = Int(arc4random())%Swift.max(txt.mq_count - len, 1)
                    let ed = st + (Int(arc4random())%len)
                    let subTxt = txt.mq_substring(with: st..<ed)

                    guard self.isNormal(subTxt, model: model) else {
                        return
                    }

                    setterQue.addOperation {
                        normalCnt += 1
                        guard normalCnt == 2 else {
                            return
                        }

                        opQue.cancelAllOperations()
                        opt.encoding = encoding
                        opt.cacheText = txt
                    }
                }
            }
        }

        opQue.waitUntilAllOperationsAreFinished()
        setterQue.waitUntilAllOperationsAreFinished()

        return opt
    }

    public func mq_autoString_GarbledChecker() -> String? {
        guard let result = self.mq_autoGuessEncoding_GarbledChecker() else {
            return nil
        }
        guard let encoding = result.encoding else {
            return nil
        }
        
        if let cacheText = result.cacheText {
            return cacheText
        }
        return String(data: self, encoding: encoding)
    }
}
