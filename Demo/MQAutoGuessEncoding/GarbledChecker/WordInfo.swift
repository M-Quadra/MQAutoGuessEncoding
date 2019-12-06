//
//  WordInfo.swift
//  Demo
//
//  Created by M_Quadra on 2019/12/6.
//  Copyright © 2019 M_noAria. All rights reserved.
//

import Foundation
import MQKit

extension String {
    
    struct MQWordInfo_old {
        var wordSet: Set<String> = []
        var maxWordStringCount = 0
        var minWordStringCount = Int.max
    }
    
    /// Don' t call it in a large text
    var mq_wordInfo_old: MQWordInfo_old {
        let tokenizer = CFStringTokenizerCreate(nil, self as CFString, CFRangeMake(0, self.mq_count), kCFStringTokenizerUnitWord, nil)
        var info = MQWordInfo_old()
        
        while true {
            CFStringTokenizerAdvanceToNextToken(tokenizer)
            let range = CFStringTokenizerGetCurrentTokenRange(tokenizer)
            guard range.length > 0 else {
                break
            }
            
            let word = self.mq_substring(with: range)
            let cnt = word.count
            
            info.wordSet.insert(word)
            info.maxWordStringCount = max(info.maxWordStringCount, cnt)
            info.minWordStringCount = min(info.minWordStringCount, cnt)
        }
        
        return info
    }
}
