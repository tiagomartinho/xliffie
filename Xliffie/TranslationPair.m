//
//  TranslationPair.m
//  Xliffie
//
//  Created by b123400 on 6/1/15.
//  Copyright (c) 2015 b123400. All rights reserved.
//

#import "TranslationPair.h"

@interface TranslationPair ()

@property (nonatomic, strong) NSXMLElement *xmlElement;

@end

@implementation TranslationPair

- (instancetype)initWithXMLElement:(NSXMLElement*)element {
    self = [super init];
    
    self.xmlElement = element;
    
    self.source = [[[element elementsForName:@"source"] firstObject] stringValue];
    self.target = [[[element elementsForName:@"target"] firstObject] stringValue];
    self.note = [[[element elementsForName:@"note"] firstObject] stringValue];
    
    return self;
}

- (void)setSource:(NSString *)source {
    NSXMLElement *sourceElement = [[self.xmlElement elementsForName:@"source"] firstObject];
    if (!sourceElement) {
        sourceElement = [NSXMLElement elementWithName:@"source"];
        [self.xmlElement addChild:sourceElement];
    }
    [sourceElement setStringValue:source];
    _source = source;
}

- (void)setTarget:(NSString *)target {
    NSXMLElement *targetElement = [[self.xmlElement elementsForName:@"target"] firstObject];
    if (!target) {
        if (!targetElement) return;
        
        NSUInteger index = [[self.xmlElement children] indexOfObject:targetElement];
        [self.xmlElement removeChildAtIndex:index];
        return;
    }
    if (!targetElement && target) {
        targetElement = [NSXMLElement elementWithName:@"target"];
        [self.xmlElement addChild:targetElement];
    }
    [targetElement setStringValue:target];
    _target = target;
}

- (BOOL)matchSearchFilter:(NSString*)filter {
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:filter options:NSRegularExpressionCaseInsensitive error:&error];
    if (regex && !error) {
        if (self.source && [regex numberOfMatchesInString:self.source options:0 range:NSMakeRange(0, self.source.length)] >= 1) {
            return YES;
        }
        if (self.target && [regex numberOfMatchesInString:self.target options:0 range:NSMakeRange(0, self.target.length)] >= 1) {
            return YES;
        }
        if (self.note && [regex numberOfMatchesInString:self.note options:0 range:NSMakeRange(0, self.note.length)] >= 1) {
            return YES;
        }
    }
    
    filter = filter.lowercaseString;
    
    return [self.source.lowercaseString containsString:filter] ||
        [self.target.lowercaseString containsString:filter] ||
        [self.note.lowercaseString containsString:filter];
}

@end