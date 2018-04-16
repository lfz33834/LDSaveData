//
//  ViewController.m
//  LDSaveData
//
//  Created by lifuzhou on 2018/4/16.
//  Copyright © 2018年 lifuzhou. All rights reserved.
//

#import "ViewController.h"
#import <EGOCache.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    EGOCache *egocache = [[EGOCache globalCache]initWithCacheDirectory:[self createCacheDirection]];
    //清除缓存
//    [egocache clearCache];
    //设置缓存时间 默认时间一天  一天的时间表示：24*60*60
    egocache.defaultTimeoutInterval = 60;
    //缓存文字
    NSString *cacheString = @"111111111111";
    [egocache setString:cacheString forKey:@"string"];
    //是否有这个缓存
    BOOL ishaveCacheFile = [egocache hasCacheForKey:@"string"];
    if (ishaveCacheFile) {
        //读取文字
        NSString *currentCacheString = [egocache stringForKey:@"string"];
        NSLog(@"缓存的文字：%@",currentCacheString);
    }
    
}

/**
 *  创建缓存目录
 *
 *  @return 缓存目录
 */
-(NSString *)createCacheDirection
{
    //沙盒目录
    NSLog(@"-----%@",NSHomeDirectory());
    //Document 文件夹目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *pathDocuments = [paths objectAtIndex:0];
    //创建缓存目录
    NSString *createPath = [NSString stringWithFormat:@"%@/MessageCache", pathDocuments];
    // 判断文件夹是否存在，如果不存在，则创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        BOOL result = [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
        if (result) {
            return createPath;
        }else
        {
            return nil;
        }
    } else {
        NSLog(@"FileDir is exists.");
        return createPath;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
