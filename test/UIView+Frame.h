//
//  UIView+Frame.h
//  test
//
//  Created by Apple on 2018/9/27.
//  Copyright © 2018年 LiveStar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
    @property (nonatomic) CGFloat nim_left;
    
    /**
     * Shortcut for frame.origin.y
     *
     * Sets frame.origin.y = top
     */
    @property (nonatomic) CGFloat nim_top;
    
    /**
     * Shortcut for frame.origin.x + frame.size.width
     *
     * Sets frame.origin.x = right - frame.size.width
     */
    @property (nonatomic) CGFloat nim_right;
    
    /**
     * Shortcut for frame.origin.y + frame.size.height
     *
     * Sets frame.origin.y = bottom - frame.size.height
     */
    @property (nonatomic) CGFloat nim_bottom;
    
    /**
     * Shortcut for frame.size.width
     *
     * Sets frame.size.width = width
     */
    @property (nonatomic) CGFloat nim_width;
    
    /**
     * Shortcut for frame.size.height
     *
     * Sets frame.size.height = height
     */
    @property (nonatomic) CGFloat nim_height;
    
    /**
     * Shortcut for center.x
     *
     * Sets center.x = centerX
     */
    @property (nonatomic) CGFloat nim_centerX;
    
    /**
     * Shortcut for center.y
     *
     * Sets center.y = centerY
     */
    @property (nonatomic) CGFloat nim_centerY;
    /**
     * Shortcut for frame.origin
     */
    @property (nonatomic) CGPoint nim_origin;
    
    /**
     * Shortcut for frame.size
     */
    @property (nonatomic) CGSize nim_size;
@end
