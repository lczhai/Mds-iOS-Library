//
//  QRShaowView.h
//  MDSBaseLibrary
//
//  Created by jony on 2018/10/11.
//

#import <UIKit/UIKit.h>

@interface QRShaowView : UIView

@property (nonatomic,assign) CGSize showSize; /**< 有效范围 */

- (void)showAnimation;
- (void)stopAnimation;

@end
