/*
    NFMFingerSprite.h
    SpriteKitTouchVisualizer

    Created by Nicolás Miari on 9/11/14.
    Copyright (c) 2014 Nicolas Miari. All rights reserved.

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.
*/

#import <SpriteKit/SpriteKit.h>

/** 
 Displays on screen the position of the finger corresponding to one touch.
 */
@interface NFMFingerSprite : SKSpriteNode


/** 
 The touch object associated with the finger sprite.
 */
@property (nonatomic, readonly, nullable) UITouch* touch;


/** 
 Designated initializer.
 */
- (nullable instancetype) initWithTouch:(nullable UITouch*) touch NS_DESIGNATED_INITIALIZER;


/** 
 Forbid instantiation via this intializer (instances need a touch object to
 operate properly).
 */
- (nullable instancetype) initWithCoder:(nonnull NSCoder*) aDecoder NS_UNAVAILABLE;


/**
 Forbid instantiation via this intializer (instances need a touch object to
 operate properly).
 */
- (nonnull instancetype) initWithTexture:(nullable SKTexture *)texture
                                    color:(nullable UIColor *)color
                                     size:(CGSize)size NS_UNAVAILABLE;

@end
