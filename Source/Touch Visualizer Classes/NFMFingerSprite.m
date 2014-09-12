/*
    NFMFingerSprite.m
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

#import "NFMFingerSprite.h"


// .............................................................................

static SKTexture* texture = nil;

static NSInteger instanceCount = 0;


// .............................................................................

@implementation NFMFingerSprite
{
    // (Need to keep track with which touch this finger is associated)
    UITouch*  __weak _touch;
}

// .............................................................................

- (instancetype) initWithTouch:(UITouch*) touch
{
    if (texture == nil) {
        texture = [SKTexture textureWithImage:[UIImage imageNamed:@"DefaultFinger"]];
    }
    
    if (self = [super initWithTexture:texture]) {
        
        _touch = touch;
        
        [self setColorBlendFactor:1.0f];
        [self setColor:[SKColor blackColor]];
        //[self setBlendMode:SKBlendModeMultiply];
        
        [self setAlpha:0.0f];
        
        SKAction* fadeIn = [SKAction fadeAlphaTo:0.25f duration:0.125f];
        
        SKAction* grow = [SKAction scaleTo:1.5f duration:0.0625];
        [grow setTimingMode:SKActionTimingEaseOut];
        
        SKAction* shrink = [SKAction scaleTo:1.0f duration:0.125];
        [shrink setTimingMode:SKActionTimingEaseOut];
        
        SKAction* pulse = [SKAction sequence:@[grow, shrink]];
        
        SKAction* appear = [SKAction group:@[pulse, fadeIn]];
        
        [self runAction:appear];
        
        instanceCount++;
    }
    
    return self;
}

// .............................................................................

- (void) dealloc
{
    instanceCount--;
    
    if (instanceCount < 1) {
        texture = nil;
    }
}

@end
