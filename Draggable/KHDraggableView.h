//
//  KHDraggableView.h
//  Draggable
//
//  Created by Ken Huang on 2015-06-04.
//  Copyright (c) 2015 Ken Huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class KHDraggableView;
@class KHDraggableViewPage;
@protocol KHDraggableViewDelegate <NSObject>


@end

@protocol KHDraggableViewDataSource <NSObject>

- (NSInteger)numberOfPagesInDraggableView:(KHDraggableView *)view;
- (KHDraggableViewPage *)draggableView:(KHDraggableView *)draggableView pageForPageNumer:(NSInteger)page;

@end

@interface KHDraggableView : UIView

- (KHDraggableViewPage *)dequeueDraggablePageForCellIdentifier:(NSString *)identifier;
- (void)registerClass:(Class)aClass forIdentifier:(NSString *)identifier;

@end
