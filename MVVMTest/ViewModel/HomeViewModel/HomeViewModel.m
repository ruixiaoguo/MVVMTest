//
//  HomeViewModel.m
//  MVVMTest
//
//  Created by grx on 2018/9/5.
//  Copyright © 2018年 李泽鲁. All rights reserved.
//

#import "HomeViewModel.h"
#import "PublicDetailViewController.h"

@implementation HomeViewModel

+ (HomeViewModel *)sharedInstance
{
    static HomeViewModel *_viewModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _viewModel = [[HomeViewModel alloc]init];
    });
    return _viewModel;
}

//获取围脖列表
- (void)fetchPublicWeiBoWithDic:(NSDictionary *)dic WithReturnBlock:(succesReturnBlock)succesReturnBlock WithFailBlock:(failureBlock)failureBlock
{
    [NetRequestClass NetRequestGETWithRequestURL:REQUESTPUBLICURL WithParameter:dic WithReturnValeuBlock:^(id returnValue) {
        DDLog(@"%@", returnValue);
        NSArray *returnArray = [[self fetchValueSuccessWithDic:returnValue] copy];
        succesReturnBlock(returnArray);
    } WithErrorCodeBlock:^(id errorCode) {
        DDLog(@"%@", errorCode);
        failureBlock(errorCode);
    } WithFailureBlock:^{
        DDLog(@"网络异常");
    }];
}

#pragma 获取到正确的数据，对正确的数据进行处理
-(NSMutableArray *)fetchValueSuccessWithDic: (NSDictionary *) returnValue
{
    //对从后台获取的数据进行处理，然后传给ViewController层进行显示
    
    NSArray *statuses = returnValue[STATUSES];
    NSMutableArray *publicModelArray = [[NSMutableArray alloc] initWithCapacity:statuses.count];
    
    for (int i = 0; i < statuses.count; i ++) {
        PublicModel *publicModel = [[PublicModel alloc] init];
        
        //设置时间
        NSDateFormatter *iosDateFormater=[[NSDateFormatter alloc]init];
        iosDateFormater.dateFormat=@"EEE MMM d HH:mm:ss Z yyyy";
        
        //必须设置，否则无法解析
        iosDateFormater.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
        NSDate *date=[iosDateFormater dateFromString:statuses[i][CREATETIME]];
        
        //目的格式
        NSDateFormatter *resultFormatter=[[NSDateFormatter alloc]init];
        [resultFormatter setDateFormat:@"MM月dd日 HH:mm"];
        
        publicModel.date = [resultFormatter stringFromDate:date];
        publicModel.userName = statuses[i][USER][USERNAME];
        publicModel.text = statuses[i][WEIBOTEXT];
        publicModel.imageUrl = [NSURL URLWithString:statuses[i][USER][HEADIMAGEURL]];
        publicModel.userId = statuses[i][USER][UID];
        publicModel.weiboId = statuses[i][WEIBOID];
        
        [publicModelArray addObject:publicModel];
        
    }
    return publicModelArray;
}

//跳转到微博详情页
-(void) weiboDetailWithPublicModel: (PublicModel *) publicModel WithViewController: (UIViewController *)superController
{
    DDLog(@"%@,%@,%@",publicModel.userId,publicModel.weiboId,publicModel.text);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    PublicDetailViewController *detailController = [storyboard instantiateViewControllerWithIdentifier:@"PublicDetailViewController"];
    detailController.publicModel = publicModel;
    [superController.navigationController pushViewController:detailController animated:YES];
}

@end
