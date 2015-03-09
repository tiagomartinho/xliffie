//
//  DocumentWindowController.h
//  Xliffie
//
//  Created by b123400 on 18/1/15.
//  Copyright (c) 2015 b123400. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ViewController.h"
#import "DocumentWindow.h"

@interface DocumentWindowController : NSWindowController <ViewControllerDelegate, DocumentWindowDelegate, NSSplitViewDelegate, NSWindowRestoration>

- (void)toggleNotes;

- (NSURL*)baseFolderURL;
- (void)addDocument:(Document*)newDocument;

- (void)openDocumentDrawer;

@end
