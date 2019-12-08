//
//  NSData+MQAutoGuessEncoding.h
//  MQAutoGuessEncodingOC
//
//  Created by M_Quadra on 2019/12/7.
//  Copyright © 2019 M_noAria. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

API_AVAILABLE(macos(10.13), ios(11.0), watchos(4.0), tvos(11.0)) __attribute__((visibility("hidden")))
@interface NSData (MQAutoGuessEncoding)

- (nullable NSString *)mq_autoString;

@end

NS_ASSUME_NONNULL_END
