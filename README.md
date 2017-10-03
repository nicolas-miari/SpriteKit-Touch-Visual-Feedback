# SpriteKit Touch Visual Feedback


Custom objective-c classes for visualizing the on screen position of each input touch (finger) in SpriteKit apps. 

Useful for:

1. When you are building a binary to be used especially for screen-capturing an app preview movie to be displayed in the iTunes AppStore (as described here:  https://developer.apple.com/app-store/app-previews/), 

2. Game tutorials or other in-app guidance, to theach the user how to use your app. 

See the bundled sample project (located at: Source/Example/) to see how to use the classes in your own game. In short, you should modify your view controller code so that instead of loading a view of type 'SKView' (the default behaviour), it loads a view of the type `TouchVisualizerView` (custom subclass of `SKView`). This is achieved by implementing (overriding) the `UIViewController` instance method `-loadView`.
