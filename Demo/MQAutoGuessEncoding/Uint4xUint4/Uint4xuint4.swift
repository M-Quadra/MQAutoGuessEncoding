//
//  Uint4xuint4.swift
//  MQAutoGuessEncoding
//
//  Created by M_Quadra on 2019/12/5.
//  Copyright © 2019 M_noAria. All rights reserved.
//

import Foundation
import CoreML

@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
extension Data {
    
    fileprivate func model_uint4xuint4() -> MQAutoGuessEncoding_uint4xuint4? {
        let bundle = Bundle(for: MQAutoGuessEncoding_uint4xuint4.self)
        if bundle.url(forResource: "MQAutoGuessEncoding_uint4xuint4", withExtension:"mlmodelc") != nil {
            return MQAutoGuessEncoding_uint4xuint4()
        }
        
        guard let modelPath = bundle.path(forResource: "MQAutoGuessEncoding_uint4xuint4", ofType: "mlmodel") else {
            return nil
        }
        
        let modelURL = URL(fileURLWithPath: modelPath)
        guard let mlmodelcURL = try? MLModel.compileModel(at: modelURL) else {
            return nil
        }
        guard let model = try? MQAutoGuessEncoding_uint4xuint4.init(contentsOf: mlmodelcURL) else {
            return nil
        }
        
        return model
    }
    
    fileprivate func cntAry_uint4xuint4() -> [[Double]] {
        let len = 16
        var cntAry = Array.init(repeating: Array.init(repeating: 0.0, count: len), count: len)
        
        var lastByte = 0
        var cnt = 0
        for byte in self {
            if cnt > 500 {
                break
            }
            
            cnt += 1
            var byteInt = Int(byte.byteSwapped)
            cntAry[lastByte][byteInt & 0xF] += 1
            lastByte = byteInt & 0xF
            byteInt >>= 4
            cntAry[lastByte][byteInt] += 1
            lastByte = byteInt
        }
        
        return cntAry
    }
    
    fileprivate func mq_autoGuessEncoding_uint4xuint4() -> String.Encoding? {
        var tsModel: MQAutoGuessEncoding_uint4xuint4?
        var tsCntAry: [[Double]]?
        DispatchQueue.concurrentPerform(iterations: 2) { (i) in
            if i == 0 {
                tsModel = self.model_uint4xuint4()
                return
            }
            
            tsCntAry = self.cntAry_uint4xuint4()
        }
        guard let model = tsModel else {
            return nil
        }
        guard let cntAry = tsCntAry else {
            return nil
        }
        
        let result = try? model.prediction(
            c0x0: cntAry[0][0],c0x1: cntAry[0][1],c0x2: cntAry[0][2],c0x3: cntAry[0][3],c0x4: cntAry[0][4],c0x5: cntAry[0][5],c0x6: cntAry[0][6],c0x7: cntAry[0][7],c0x8: cntAry[0][8],c0x9: cntAry[0][9],c0x10: cntAry[0][10],c0x11: cntAry[0][11],c0x12: cntAry[0][12],c0x13: cntAry[0][13],c0x14: cntAry[0][14],c0x15: cntAry[0][15],
            c1x0: cntAry[1][0],c1x1: cntAry[1][1],c1x2: cntAry[1][2],c1x3: cntAry[1][3],c1x4: cntAry[1][4],c1x5: cntAry[1][5],c1x6: cntAry[1][6],c1x7: cntAry[1][7],c1x8: cntAry[1][8],c1x9: cntAry[1][9],c1x10: cntAry[1][10],c1x11: cntAry[1][11],c1x12: cntAry[1][12],c1x13: cntAry[1][13],c1x14: cntAry[1][14],c1x15: cntAry[1][15],
            c2x0: cntAry[2][0],c2x1: cntAry[2][1],c2x2: cntAry[2][2],c2x3: cntAry[2][3],c2x4: cntAry[2][4],c2x5: cntAry[2][5],c2x6: cntAry[2][6],c2x7: cntAry[2][7],c2x8: cntAry[2][8],c2x9: cntAry[2][9],c2x10: cntAry[2][10],c2x11: cntAry[2][11],c2x12: cntAry[2][12],c2x13: cntAry[2][13],c2x14: cntAry[2][14],c2x15: cntAry[2][15],
            c3x0: cntAry[3][0],c3x1: cntAry[3][1],c3x2: cntAry[3][2],c3x3: cntAry[3][3],c3x4: cntAry[3][4],c3x5: cntAry[3][5],c3x6: cntAry[3][6],c3x7: cntAry[3][7],c3x8: cntAry[3][8],c3x9: cntAry[3][9],c3x10: cntAry[3][10],c3x11: cntAry[3][11],c3x12: cntAry[3][12],c3x13: cntAry[3][13],c3x14: cntAry[3][14],c3x15: cntAry[3][15],
            c4x0: cntAry[4][0],c4x1: cntAry[4][1],c4x2: cntAry[4][2],c4x3: cntAry[4][3],c4x4: cntAry[4][4],c4x5: cntAry[4][5],c4x6: cntAry[4][6],c4x7: cntAry[4][7],c4x8: cntAry[4][8],c4x9: cntAry[4][9],c4x10: cntAry[4][10],c4x11: cntAry[4][11],c4x12: cntAry[4][12],c4x13: cntAry[4][13],c4x14: cntAry[4][14],c4x15: cntAry[4][15],
            c5x0: cntAry[5][0],c5x1: cntAry[5][1],c5x2: cntAry[5][2],c5x3: cntAry[5][3],c5x4: cntAry[5][4],c5x5: cntAry[5][5],c5x6: cntAry[5][6],c5x7: cntAry[5][7],c5x8: cntAry[5][8],c5x9: cntAry[5][9],c5x10: cntAry[5][10],c5x11: cntAry[5][11],c5x12: cntAry[5][12],c5x13: cntAry[5][13],c5x14: cntAry[5][14],c5x15: cntAry[5][15],
            c6x0: cntAry[6][0],c6x1: cntAry[6][1],c6x2: cntAry[6][2],c6x3: cntAry[6][3],c6x4: cntAry[6][4],c6x5: cntAry[6][5],c6x6: cntAry[6][6],c6x7: cntAry[6][7],c6x8: cntAry[6][8],c6x9: cntAry[6][9],c6x10: cntAry[6][10],c6x11: cntAry[6][11],c6x12: cntAry[6][12],c6x13: cntAry[6][13],c6x14: cntAry[6][14],c6x15: cntAry[6][15],
            c7x0: cntAry[7][0],c7x1: cntAry[7][1],c7x2: cntAry[7][2],c7x3: cntAry[7][3],c7x4: cntAry[7][4],c7x5: cntAry[7][5],c7x6: cntAry[7][6],c7x7: cntAry[7][7],c7x8: cntAry[7][8],c7x9: cntAry[7][9],c7x10: cntAry[7][10],c7x11: cntAry[7][11],c7x12: cntAry[7][12],c7x13: cntAry[7][13],c7x14: cntAry[7][14],c7x15: cntAry[7][15],
            c8x0: cntAry[8][0],c8x1: cntAry[8][1],c8x2: cntAry[8][2],c8x3: cntAry[8][3],c8x4: cntAry[8][4],c8x5: cntAry[8][5],c8x6: cntAry[8][6],c8x7: cntAry[8][7],c8x8: cntAry[8][8],c8x9: cntAry[8][9],c8x10: cntAry[8][10],c8x11: cntAry[8][11],c8x12: cntAry[8][12],c8x13: cntAry[8][13],c8x14: cntAry[8][14],c8x15: cntAry[8][15],
            c9x0: cntAry[9][0],c9x1: cntAry[9][1],c9x2: cntAry[9][2],c9x3: cntAry[9][3],c9x4: cntAry[9][4],c9x5: cntAry[9][5],c9x6: cntAry[9][6],c9x7: cntAry[9][7],c9x8: cntAry[9][8],c9x9: cntAry[9][9],c9x10: cntAry[9][10],c9x11: cntAry[9][11],c9x12: cntAry[9][12],c9x13: cntAry[9][13],c9x14: cntAry[9][14],c9x15: cntAry[9][15],
            c10x0: cntAry[10][0],c10x1: cntAry[10][1],c10x2: cntAry[10][2],c10x3: cntAry[10][3],c10x4: cntAry[10][4],c10x5: cntAry[10][5],c10x6: cntAry[10][6],c10x7: cntAry[10][7],c10x8: cntAry[10][8],c10x9: cntAry[10][9],c10x10: cntAry[10][10],c10x11: cntAry[10][11],c10x12: cntAry[10][12],c10x13: cntAry[10][13],c10x14: cntAry[10][14],c10x15: cntAry[10][15],
            c11x0: cntAry[11][0],c11x1: cntAry[11][1],c11x2: cntAry[11][2],c11x3: cntAry[11][3],c11x4: cntAry[11][4],c11x5: cntAry[11][5],c11x6: cntAry[11][6],c11x7: cntAry[11][7],c11x8: cntAry[11][8],c11x9: cntAry[11][9],c11x10: cntAry[11][10],c11x11: cntAry[11][11],c11x12: cntAry[11][12],c11x13: cntAry[11][13],c11x14: cntAry[11][14],c11x15: cntAry[11][15],
            c12x0: cntAry[12][0],c12x1: cntAry[12][1],c12x2: cntAry[12][2],c12x3: cntAry[12][3],c12x4: cntAry[12][4],c12x5: cntAry[12][5],c12x6: cntAry[12][6],c12x7: cntAry[12][7],c12x8: cntAry[12][8],c12x9: cntAry[12][9],c12x10: cntAry[12][10],c12x11: cntAry[12][11],c12x12: cntAry[12][12],c12x13: cntAry[12][13],c12x14: cntAry[12][14],c12x15: cntAry[12][15],
            c13x0: cntAry[13][0],c13x1: cntAry[13][1],c13x2: cntAry[13][2],c13x3: cntAry[13][3],c13x4: cntAry[13][4],c13x5: cntAry[13][5],c13x6: cntAry[13][6],c13x7: cntAry[13][7],c13x8: cntAry[13][8],c13x9: cntAry[13][9],c13x10: cntAry[13][10],c13x11: cntAry[13][11],c13x12: cntAry[13][12],c13x13: cntAry[13][13],c13x14: cntAry[13][14],c13x15: cntAry[13][15],
            c14x0: cntAry[14][0],c14x1: cntAry[14][1],c14x2: cntAry[14][2],c14x3: cntAry[14][3],c14x4: cntAry[14][4],c14x5: cntAry[14][5],c14x6: cntAry[14][6],c14x7: cntAry[14][7],c14x8: cntAry[14][8],c14x9: cntAry[14][9],c14x10: cntAry[14][10],c14x11: cntAry[14][11],c14x12: cntAry[14][12],c14x13: cntAry[14][13],c14x14: cntAry[14][14],c14x15: cntAry[14][15],
            c15x0: cntAry[15][0],c15x1: cntAry[15][1],c15x2: cntAry[15][2],c15x3: cntAry[15][3],c15x4: cntAry[15][4],c15x5: cntAry[15][5],c15x6: cntAry[15][6],c15x7: cntAry[15][7],c15x8: cntAry[15][8],c15x9: cntAry[15][9],c15x10: cntAry[15][10],c15x11: cntAry[15][11],c15x12: cntAry[15][12],c15x13: cntAry[15][13],c15x14: cntAry[15][14],c15x15: cntAry[15][15]
        )
        
        guard let rst = result else {
            return nil
        }
        
        let codingStr = rst.coding.replacingOccurrences(of: "c", with: "")
        guard let coding = UInt(codingStr) else {
            return nil
        }
        
        return .init(rawValue: coding)
    }
    
    public func mq_autoString_uint4xuint4() -> String? {
        guard let encoding = self.mq_autoGuessEncoding_uint4xuint4() else {
            return nil
        }
        
        return String(data: self, encoding: encoding)
    }
}
