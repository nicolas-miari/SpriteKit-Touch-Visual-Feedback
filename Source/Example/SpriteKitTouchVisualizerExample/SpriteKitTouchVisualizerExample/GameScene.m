/*
    GameScene.m
    SpriteKitTouchVisualizerExample

    Created by Nicolás Miari on 9/12/14.
    Copyright (c) 2014 Nicolás Miari. All rights reserved.

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

#import "GameScene.h"

@implementation GameScene
{
    
}


// .............................................................................

- (instancetype) initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        
        [self setAnchorPoint:CGPointMake(0.5f, 0.5f)];
        [self setBackgroundColor:[SKColor whiteColor]];
    }
    
    return self;
}

// .............................................................................

-(void) didMoveToView:(SKView*) view
{
    // Setup your scene here
    UIFont* font = [UIFont systemFontOfSize:14];
    
    SKLabelNode* label = [SKLabelNode labelNodeWithFontNamed:[font fontName]];
    
    [label setFontColor:[SKColor darkGrayColor]];
    
    label.text = @"(Touch/drag anywhere)";
    label.fontSize = 22;
    label.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    [self addChild:label];
}

@end
