//
//  MonoClockView.m
//  MonoClock
//
//  Created by Hakan Demir on 28.04.2025.
//


// MonoClockView.m
// Main implementation file for your screensaver
#import "MonoClockView.h"
#import <SwiftUI/SwiftUI.h>
#import "MonoClock-Swift.h"
// after importing SwiftUI
// <-- This will import Swift classes automatically (important!)

@implementation MonoClockView {
    HostingViewBridge *bridgeView; // <-- SwiftUI view container
}

// Constructor method, called when the screensaver starts
- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/30.0];
        
        bridgeView = [[HostingViewBridge alloc] initWithFrame:self.bounds];
        bridgeView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
        
        [self addSubview:bridgeView];
    }
    return self;
}

// Called when animation should start
- (void)startAnimation
{
    [super startAnimation];
}

// Called when animation should stop
- (void)stopAnimation
{
    [super stopAnimation];
}

// This function would be used if you manually drew graphics; not needed when using SwiftUI
- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

// Called every frame if you need to animate; with SwiftUI we don't need this
- (void)animateOneFrame
{
    return;
}

// Whether a configure (settings) sheet is available
- (BOOL)hasConfigureSheet
{
    return NO;
}

// Provide the configuration sheet (return nil = none)
- (NSWindow*)configureSheet
{
    return nil;
}

@end
