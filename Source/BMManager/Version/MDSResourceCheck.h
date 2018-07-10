//
//  MDSResourceCheck.h
//  MDS-Chia
//
//  Created by 窦静轩 on 2017/3/13.
//  Copyright © 2017年 XHY. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^mdsResourceCheckResult)(BOOL check,NSDictionary* info);


@interface MDSResourceCheck : NSObject


+(void)checkLocalResourceByZipPath:(NSString*)zipPath result:(mdsResourceCheckResult)result;

@end
