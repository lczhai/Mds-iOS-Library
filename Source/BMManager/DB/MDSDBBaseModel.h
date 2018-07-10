//
//  MDSDBBaseModel.h
//  RealmDome
//
//  Created by jony on 2018/3/31.
//  Copyright © 2017年 本木医疗. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface MDSDBBaseModel : RLMObject

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *data;    // json string

@end
