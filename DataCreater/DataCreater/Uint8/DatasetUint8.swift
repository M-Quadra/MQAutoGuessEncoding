//
//  DatasetUint8.swift
//  DataCreater
//
//  Created by M_Quadra on 2019/11/28.
//  Copyright © 2019 M_noAria. All rights reserved.
//

import Foundation
import MQKit

class DatasetUint8 { //base on uint8 count
    
    let markHeader: String = {
        let len = Int(UInt8.max) + 1
        var cntAry = Array.init(repeating: 0, count: len)
        for i in 0..<cntAry.count {
            cntAry[i] = i
        }
        
        let strAry = cntAry.map { String(format: "c%d", $0) }
        return strAry.joined(separator: ",") + ",coding"
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
                
                var cntAry = Array.init(repeating: 0, count: len)
                let byteAry = txtData.map { Int($0.byteSwapped) }
                for byte in byteAry {
                    cntAry[byte] += 1
                }
                
                let strAry = cntAry.map { String(format: "%d", $0) }
                let str = strAry.joined(separator: ",") + String(format: ",c%u", v)
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
    
    func autoStringTest(data: Data) -> String? {
        var cntAry = Array.init(repeating: 0.0, count: Int(UInt8.max) + 1)
        var cnt = 0
        
        for byte in data {
            if cnt > 500 {
                break
            }
            
            cnt += 1
            cntAry[Int(byte)] += 1
        }
        
        let model = MQAutoGuessEncoding_uint8()
        
        let result = try? model.prediction(
            c0: cntAry[0], c1: cntAry[1], c2: cntAry[2], c3: cntAry[3],
            c4: cntAry[4], c5: cntAry[5], c6: cntAry[6], c7: cntAry[7],
            c8: cntAry[8], c9: cntAry[9], c10: cntAry[10], c11: cntAry[11],
            c12: cntAry[12], c13: cntAry[13], c14: cntAry[14], c15: cntAry[15],
            c16: cntAry[16], c17: cntAry[17], c18: cntAry[18], c19: cntAry[19],
            c20: cntAry[20], c21: cntAry[21], c22: cntAry[22], c23: cntAry[23],
            c24: cntAry[24], c25: cntAry[25], c26: cntAry[26], c27: cntAry[27],
            c28: cntAry[28], c29: cntAry[29], c30: cntAry[30], c31: cntAry[31],
            c32: cntAry[32], c33: cntAry[33], c34: cntAry[34], c35: cntAry[35],
            c36: cntAry[36], c37: cntAry[37], c38: cntAry[38], c39: cntAry[39],
            c40: cntAry[40], c41: cntAry[41], c42: cntAry[42], c43: cntAry[43],
            c44: cntAry[44], c45: cntAry[45], c46: cntAry[46], c47: cntAry[47],
            c48: cntAry[48], c49: cntAry[49], c50: cntAry[50], c51: cntAry[51],
            c52: cntAry[52], c53: cntAry[53], c54: cntAry[54], c55: cntAry[55],
            c56: cntAry[56], c57: cntAry[57], c58: cntAry[58], c59: cntAry[59],
            c60: cntAry[60], c61: cntAry[61], c62: cntAry[62], c63: cntAry[63],
            c64: cntAry[64], c65: cntAry[65], c66: cntAry[66], c67: cntAry[67],
            c68: cntAry[68], c69: cntAry[69], c70: cntAry[70], c71: cntAry[71],
            c72: cntAry[72], c73: cntAry[73], c74: cntAry[74], c75: cntAry[75],
            c76: cntAry[76], c77: cntAry[77], c78: cntAry[78], c79: cntAry[79],
            c80: cntAry[80], c81: cntAry[81], c82: cntAry[82], c83: cntAry[83],
            c84: cntAry[84], c85: cntAry[85], c86: cntAry[86], c87: cntAry[87],
            c88: cntAry[88], c89: cntAry[89], c90: cntAry[90], c91: cntAry[91],
            c92: cntAry[92], c93: cntAry[93], c94: cntAry[94], c95: cntAry[95],
            c96: cntAry[96], c97: cntAry[97], c98: cntAry[98], c99: cntAry[99],
            c100: cntAry[100], c101: cntAry[101], c102: cntAry[102], c103: cntAry[103],
            c104: cntAry[104], c105: cntAry[105], c106: cntAry[106], c107: cntAry[107],
            c108: cntAry[108], c109: cntAry[109], c110: cntAry[110], c111: cntAry[111],
            c112: cntAry[112], c113: cntAry[113], c114: cntAry[114], c115: cntAry[115],
            c116: cntAry[116], c117: cntAry[117], c118: cntAry[118], c119: cntAry[119],
            c120: cntAry[120], c121: cntAry[121], c122: cntAry[122], c123: cntAry[123],
            c124: cntAry[124], c125: cntAry[125], c126: cntAry[126], c127: cntAry[127],
            c128: cntAry[128], c129: cntAry[129], c130: cntAry[130], c131: cntAry[131],
            c132: cntAry[132], c133: cntAry[133], c134: cntAry[134], c135: cntAry[135],
            c136: cntAry[136], c137: cntAry[137], c138: cntAry[138], c139: cntAry[139],
            c140: cntAry[140], c141: cntAry[141], c142: cntAry[142], c143: cntAry[143],
            c144: cntAry[144], c145: cntAry[145], c146: cntAry[146], c147: cntAry[147],
            c148: cntAry[148], c149: cntAry[149], c150: cntAry[150], c151: cntAry[151],
            c152: cntAry[152], c153: cntAry[153], c154: cntAry[154], c155: cntAry[155],
            c156: cntAry[156], c157: cntAry[157], c158: cntAry[158], c159: cntAry[159],
            c160: cntAry[160], c161: cntAry[161], c162: cntAry[162], c163: cntAry[163],
            c164: cntAry[164], c165: cntAry[165], c166: cntAry[166], c167: cntAry[167],
            c168: cntAry[168], c169: cntAry[169], c170: cntAry[170], c171: cntAry[171],
            c172: cntAry[172], c173: cntAry[173], c174: cntAry[174], c175: cntAry[175],
            c176: cntAry[176], c177: cntAry[177], c178: cntAry[178], c179: cntAry[179],
            c180: cntAry[180], c181: cntAry[181], c182: cntAry[182], c183: cntAry[183],
            c184: cntAry[184], c185: cntAry[185], c186: cntAry[186], c187: cntAry[187],
            c188: cntAry[188], c189: cntAry[189], c190: cntAry[190], c191: cntAry[191],
            c192: cntAry[192], c193: cntAry[193], c194: cntAry[194], c195: cntAry[195],
            c196: cntAry[196], c197: cntAry[197], c198: cntAry[198], c199: cntAry[199],
            c200: cntAry[200], c201: cntAry[201], c202: cntAry[202], c203: cntAry[203],
            c204: cntAry[204], c205: cntAry[205], c206: cntAry[206], c207: cntAry[207],
            c208: cntAry[208], c209: cntAry[209], c210: cntAry[210], c211: cntAry[211],
            c212: cntAry[212], c213: cntAry[213], c214: cntAry[214], c215: cntAry[215],
            c216: cntAry[216], c217: cntAry[217], c218: cntAry[218], c219: cntAry[219],
            c220: cntAry[220], c221: cntAry[221], c222: cntAry[222], c223: cntAry[223],
            c224: cntAry[224], c225: cntAry[225], c226: cntAry[226], c227: cntAry[227],
            c228: cntAry[228], c229: cntAry[229], c230: cntAry[230], c231: cntAry[231],
            c232: cntAry[232], c233: cntAry[233], c234: cntAry[234], c235: cntAry[235],
            c236: cntAry[236], c237: cntAry[237], c238: cntAry[238], c239: cntAry[239],
            c240: cntAry[240], c241: cntAry[241], c242: cntAry[242], c243: cntAry[243],
            c244: cntAry[244], c245: cntAry[245], c246: cntAry[246], c247: cntAry[247],
            c248: cntAry[248], c249: cntAry[249], c250: cntAry[250], c251: cntAry[251],
            c252: cntAry[252], c253: cntAry[253], c254: cntAry[254], c255: cntAry[255]
        )
        
        guard let rst = result else {
            return nil
        }
        print(Date().timeIntervalSince1970)
        let codingStr = rst.coding.replacingOccurrences(of: "c", with: "")
        guard let coding = UInt(codingStr) else {
            return nil
        }
        
        return String(data: data, encoding: .init(rawValue: coding))
    }
}

