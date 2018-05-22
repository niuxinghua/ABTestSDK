//
//  ABTestManager.m
//  GrayFeatureSDK
//
//  Created by niuxinghua on 2018/5/22.
//  Copyright © 2018年 com.haier. All rights reserved.
//

#import "ABTestManager.h"
#import "NXHAFNetworking.h"
static NSString *kGrayFeatuerUrl = @"http://47.98.179.35:8080/allrediskeyandvalue";
static dispatch_semaphore_t semaphore;
@interface ABTestManager()

@property(readwrite,strong)NSMutableDictionary *grayFeatureDic;

@end
@implementation ABTestManager
static ABTestManager *manager = nil;
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
    return manager;
}
- (void)initFeature
{
     self.grayFeatureDic = [[NSMutableDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"grayFeatureKey"]];
    if (!self.grayFeatureDic) {
    self.grayFeatureDic = [[NSMutableDictionary alloc]init];
    }
    [[NSNotificationCenter defaultCenter] addObserver:manager selector:@selector(syncFeature) name:UIApplicationDidBecomeActiveNotification object:nil];
   // [self syncFeature];
    
}
- (void)syncFeature
{
    __weak ABTestManager *weakSelf = self;
  //  semaphore = dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[NXHAFHTTPSessionManager manager]GET:kGrayFeatuerUrl parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if([[responseObject objectForKey:@"code"] intValue]==200)
            {
                [weakSelf convertListToMutableDic:[responseObject objectForKey:@"data"]];
            }
        //    dispatch_semaphore_signal(semaphore);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
         //    dispatch_semaphore_signal(semaphore);
        }];
       
    });
  //  dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
 //   NSLog(@"22222");
   
  
    
    
    
}
- (NSMutableDictionary *)convertListToMutableDic:(NSArray *)list
{
    [self.grayFeatureDic removeAllObjects];
    for (NSDictionary *dic in list) {
        [self.grayFeatureDic addEntriesFromDictionary:dic];
    }
    //NSLog(@"%@",self.grayFeatureDic);
    [[NSUserDefaults standardUserDefaults] setObject:self.grayFeatureDic forKey:@"grayFeatureKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return self.grayFeatureDic;
}
- (BOOL)isFeatuerEnable:(NSString *)featureKey
{
    if (!featureKey.length) {
        return NO;
    }
    return [self.grayFeatureDic.allKeys containsObject:featureKey] && [[self.grayFeatureDic objectForKey:featureKey] isEqualToString:@"enable"];
}

@end
