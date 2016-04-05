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


// Sprite texture, created along the first instance and shared afterwards among
// all inistances.
static SKTexture* texture = nil;


// Keeps track of all active instances: increased by one on -init and decreased
// by one on -dealloc. When it reaches zero, the shared texture is deallocated.
static NSInteger instanceCount = 0;


// .............................................................................

@implementation NFMFingerSprite
{
    // Keeps track of which touch the finger is associated with, so that the
    // parent node can move this instance to match the touch position.
    UITouch*  __weak _touch;
}

// .............................................................................

- (instancetype) initWithTouch:(UITouch*) touch
{
    if (texture == nil) {
        texture = [SKTexture textureWithImage:[UIImage imageNamed:@"DefaultFinger"]];
    }
    
    if (self = [super initWithTexture:texture color:[SKColor whiteColor] size:texture.size]) {
        
        _touch = touch;
        
        [self setColorBlendFactor:1.0f];
        [self setColor:[SKColor blackColor]];
        [self setAlpha:0.0f];
        
        [self runAction:[self appearAction]];
        
        instanceCount++;
    }
    
    return self;
}


- (SKAction*) appearAction
{
    // 1. Fade in
    
    SKAction* fadeInAction = [SKAction fadeAlphaTo:0.25f
                                          duration:0.125f];
    
    
    // 2. Pulse (Grow -> Shrink):
    
    SKAction* growAction = [SKAction scaleTo:1.5f
                                    duration:0.0625];
    [growAction setTimingMode:SKActionTimingEaseOut];
    
    SKAction* shrinkAction = [SKAction scaleTo:1.0f
                                      duration:0.125];
    [shrinkAction setTimingMode:SKActionTimingEaseOut];
    
    SKAction* pulseAction = [SKAction sequence:@[growAction, shrinkAction]];
    
    
    // 3. Appear (Fade in // Pulse)
    
    SKAction* appearAction = [SKAction group:@[pulseAction, fadeInAction]];
    
    
    return appearAction;
}


- (void) dealloc
{
    instanceCount--;
    
    if (instanceCount < 1) {
        texture = nil;
    }
}


// .............................................................................

#pragma mark - Unavailable Superclass Initializers

// (Based on this answer: http://stackoverflow.com/a/31830471/433373 )


- (instancetype) initWithTexture:(SKTexture *)texture color:(UIColor *)color size:(CGSize)size
{
    @throw nil;
}


- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    @throw nil;
}


@end
