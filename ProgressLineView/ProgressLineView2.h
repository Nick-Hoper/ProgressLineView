//
//  ProgressLineView2.h
//  ProgressLineView
//  3、有标签的进度条
//  Created by Nick-Hoper on 2018/2/4.
//  Copyright © 2018年 Nick-Hoper. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProgressLineView2 : UIView

@property (nonatomic, retain)NSArray * _Nonnull titles;

@property (nonatomic, assign)int stepIndex;

- (instancetype _Nonnull )initWithFrame:(CGRect)frame Titles:(nonnull NSArray *)titles;

- (void)setStepIndex:(int)stepIndex Animation:(BOOL)animation;

@end

