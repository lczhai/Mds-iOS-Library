//
//  MDSWebViewRouterModel.h
//  Pods
//
//  Created by jony on 2018/7/19.
//
//

#import <Foundation/Foundation.h>

@interface MDSWebViewRouterModel : NSObject

@property (nonatomic, copy) NSString *url;              /**< url */
@property (nonatomic, copy) NSString *title;            /**< 页面标题 */
@property (nonatomic, assign) BOOL navShow;             /**< 是否隐藏导航栏 */

@end
