//
//  HomeViewModel.h
//  MVVMTest
//
//  Created by grx on 2018/9/5.
//  Copyright © 2018年 李泽鲁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PublicModel.h"

@interface HomeViewModel : NSObject

typedef void (^succesReturnBlock)(NSArray *responseArray);
typedef void (^failureBlock)(NSError* error);

+ (HomeViewModel *)sharedInstance;

//获取围脖列表
- (void)fetchPublicWeiBoWithDic:(NSDictionary *)dic WithReturnBlock:(succesReturnBlock)succesReturnBlock WithFailBlock:(failureBlock)failureBlock;

//跳转到微博详情页
-(void) weiboDetailWithPublicModel: (PublicModel *) publicModel WithViewController: (UIViewController *)superController;

@end
