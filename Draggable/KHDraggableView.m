//
//  KHDraggableView.m
//  Draggable
//
//  Created by Ken Huang on 2015-06-04.
//  Copyright (c) 2015 Ken Huang. All rights reserved.
//

#import "KHDraggableView.h"

@interface ReusablePool : NSObject

- (void)registerClass:(Class)aClass forIdentifier:(NSString *)identifier;
- (id)pageForIdentifer:(NSString *)identifer;

@end

@implementation ReusablePool
{
    NSMutableDictionary *_dict;
    NSMutableDictionary *_nameTable;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _dict = [[NSMutableDictionary alloc] init];
        _nameTable = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)registerClassName:(NSString *)name
{
    if (name)
    {
        NSMutableArray *views = [[NSMutableArray alloc] init];
        _dict[name] = views;
    }
}

- (id)pageForIdentifer:(NSString *)identifer
{
    NSMutableArray *views = _dict[identifer];
    if (!views)
    {
        _dict[identifer] = [[NSMutableArray alloc] init];
        views = _dict[identifer];
    }
    if (views.count == 0){
        Class aClass = _nameTable[identifer];
        NSAssert(aClass != nil, @"Didnt register class %@", identifer);
        id view = [[aClass alloc] init];
        [views addObject:view];
        return view;
    }else{
        id view = [views lastObject];
        [views removeLastObject];
        return view;
    }
}

@end

@implementation KHDraggableView
{
    ReusablePool *_pool;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _pool = [[ReusablePool alloc] init];
    }
    return self;
}

- (KHDraggableViewPage *)dequeueDraggablePageForCellIdentifier:(NSString *)identifier
{
    return [_pool pageForIdentifer:identifier];
}

- (void)registerClass:(Class)aClass forIdentifier:(NSString *)identifier
{
//    NSString *className = NSStringFromClass(aClass);
    [_pool registerClass:aClass forIdentifier:identifier];
}

@end
