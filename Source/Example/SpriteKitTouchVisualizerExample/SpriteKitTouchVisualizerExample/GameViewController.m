/*
    GameViewController.m
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

#import "GameViewController.h"
#import "GameScene.h"

#import "NFMVisibleTouchView.h"


// .............................................................................

@implementation SKScene (Unarchive)

+ (instancetype) unarchiveFromFile:(NSString*) file
{
    /* Retrieve scene file path from the application bundle */
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    
    return scene;
}

@end


@implementation GameViewController

// .............................................................................

#pragma mark - This Method Incorporates Touch Visual Feedback


- (void) loadView
{
    // Use custom subclass for view (displays sprites for each touch)
    
    NFMVisibleTouchView* view = [[NFMVisibleTouchView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = view;
    
    
    [view setTouchesVisible:YES];
    // Default is YES. Use for toggling visibility according to app context.
    // (e.g., on during tutorial, off during game). If you set it to NO, it
    // works exactly as a stock SKView.
    
    
    // Enable multiple touch support for this example:
    [view setMultipleTouchEnabled:YES];
}

// .............................................................................

#pragma mark - UIViewController


- (void) viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView*) self.view;
    
    //skView.showsFPS = YES;
    //skView.showsNodeCount = YES;
    
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    GameScene *scene = [[GameScene alloc] initWithSize:[[UIScreen mainScreen] bounds].size];
    //[GameScene unarchiveFromFile:@"GameScene"];
    
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}


- (BOOL)shouldAutorotate
{
    return YES;
}


- (UIInterfaceOrientationMask) supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}


- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


- (BOOL) prefersStatusBarHidden
{
    return YES;
}


@end
