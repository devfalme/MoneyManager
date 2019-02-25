//
//  UIView+MM_Manager.m
//  Manager
//
//  Created by devfalme on 2018/12/17.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import "UIView+MM_Manager.h"

@implementation UIView (MM_Manager)
#pragma mark 阴影色
- (UIColor *)shadowColor {
    return [UIColor colorWithCGColor:[self.layer shadowColor]];
}
- (void)setShadowColor:(UIColor *)shadowColor {
    [self.layer setShadowColor:shadowColor.CGColor];
}

#pragma mark 阴影透明度
- (CGFloat)shadowOpacity {
    return [self.layer shadowOpacity];
}
- (void)setShadowOpacity:(CGFloat)shadowOpacity {
    [self.layer setShadowOpacity:shadowOpacity];
}
#pragma mark 阴影偏移量
- (CGSize)shadowOffset {
    return [self.layer shadowOffset];
}
- (void)setShadowOffset:(CGSize)shadowOffset {
    [self.layer setShadowOffset:shadowOffset];
}
#pragma mark 阴影半径
- (CGFloat)shadowRadius {
    return [self.layer shadowRadius];
}
- (void)setShadowRadius:(CGFloat)shadowRadius {
    [self.layer setShadowRadius:shadowRadius];
}
#pragma mark 边框宽度
- (NSInteger)borderWidth {
    return [self.layer borderWidth];
}
- (void)setBorderWidth:(NSInteger)borderWidth {
    [self.layer setBorderWidth:borderWidth];
}
#pragma mark 边框颜色
- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
- (void)setBorderColor:(UIColor *)borderColor {
    [self.layer setBorderColor:borderColor.CGColor];
}
#pragma mark 圆角
- (NSInteger)cornerRadius{
    return self.layer.cornerRadius;
}
- (void)setCornerRadius:(NSInteger)cornerRadius {
    [self.layer setCornerRadius:cornerRadius];
}
#pragma mark mask切边
- (BOOL)masksToBounds{
    return [self.layer masksToBounds];
}
- (void)setMasksToBounds:(BOOL)masksToBounds {
    [self.layer setMasksToBounds:masksToBounds];
}


+ (UIView *)loadFromNib {
    NSString *nibNameOrNil = NSStringFromClass(self);
    return [[[NSBundle mainBundle] loadNibNamed:nibNameOrNil owner:nil options:nil] firstObject];
}
@end
