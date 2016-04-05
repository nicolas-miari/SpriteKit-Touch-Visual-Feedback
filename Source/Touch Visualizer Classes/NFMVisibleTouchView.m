/*
    VisibleTouchView.m
    SpriteKitTouchVisualizer

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

#import "NFMVisibleTouchView.h"         // Own header

#import "NFMFingerSprite.h"             // Child object


// .............................................................................

@implementation NFMVisibleTouchView
{
    // Holds sprites for each touch
    NSMutableArray* _fingers;
    
    BOOL            _touchesAreVisible;
}

@synthesize touchesVisible = _touchesAreVisible;


// .............................................................................

#pragma mark - Initialization


- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
    }
    
    return self;
}


- (instancetype) initWithCoder:(NSCoder*) aDecoder
{
    if(self = [super initWithCoder:aDecoder]){
        
        [self setup];
    }
    
    return self;
}


// .............................................................................

#pragma mark - UIResponder

- (void) touchesBegan:(NSSet*) touches withEvent:(UIEvent*) event
{
    [super touchesBegan:touches withEvent:event];
    
    
    if(!_touchesAreVisible){
        return;
    }
    
    
    // 2. Place a 'finger' sprite at each touch location
    
    for (UITouch* touch in touches) {
        
        NFMFingerSprite* finger = [[NFMFingerSprite alloc] initWithTouch:touch];
        
        [_fingers addObject:finger];
        [[self scene] addChild:finger];
        
        [finger setPosition:[[finger touch] locationInNode:[self scene]]];
    }
}


- (void) touchesMoved:(NSSet*) touches withEvent:(UIEvent*) event
{
    /*
     touches only contains the touches that moved. In contrast, 
     [event allTouches] contains all the touches of the current sequence (even
     those for fingers that are still). 
     We need them all to update all finger sprites.
     */
    
    [super touchesMoved:touches withEvent:event];
    
    if(!_touchesAreVisible){
        return;
    }
    
    
    for (NFMFingerSprite* finger in _fingers) {
        
        UITouch* touch = [finger touch];
        
        if (touch) {
            
            [finger setPosition:[[finger touch] locationInNode:[self scene]]];
        }
        else{
            
            [finger runAction:[SKAction fadeAlphaTo:0.0f duration:0.125] completion:^(){
                [_fingers removeObject:finger];
                [finger removeFromParent];
            }];
        }
    }
}


- (void) touchesEnded:(NSSet*) touches withEvent:(UIEvent*) event
{
    [super touchesEnded:touches withEvent:event];
    
    [self removeFingersForTouches:touches];
}


- (void) touchesCancelled:(NSSet*) touches withEvent:(UIEvent*) event
{
    [super touchesCancelled:touches withEvent:event];
    
    [self removeFingersForTouches:touches];
}


// .............................................................................

#pragma mark - Internal Support


- (void) setup
{
    // Initialization code shared by both designated initializers
    // (grouped here to avoid duplication)
    
    _touchesAreVisible = YES;
    
    _fingers = [NSMutableArray new];
}


- (void) removeFingersForTouches:(NSSet*) touches
{
    // Cleanup code shared by both -touchedEnded:withEvent: and
    // -touchesCancelled:withEvent: (grouped here to avoid duplication)
    
    if(!_touchesAreVisible){
        return;
    }
    
    // Remove afected fingers from screen and array:
    
    for (NFMFingerSprite* finger in _fingers) {
        
        UITouch* touch = [finger touch];
        
        if (touch == nil){
            continue; // Should never happen, but...
        }
        
        if ([touches containsObject:touch]){
            
            [finger runAction:[SKAction fadeAlphaTo:0.0f duration:0.125] completion:^(){
                
                // Removal from array is deferred to 0.125 seconds later (i.e.,
                // long after the loop completes), so there is no consistency
                // problems (no need to iterate on a copy of the array):
                [_fingers removeObject:finger];
                
                [finger removeFromParent];
            }];
        }
    }
}

@end
