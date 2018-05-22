//
//  ABTestManager.h
//  GrayFeatureSDK
//
//  Created by niuxinghua on 2018/5/22.
//  Copyright © 2018年 com.haier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABTestManager : NSObject

+ (instancetype)sharedInstance;
- (BOOL)isFeatuerEnable:(NSString *)featureKey;
- (void)initFeature;
@property(readonly,strong)NSMutableDictionary *grayFeatureDic;

@end
