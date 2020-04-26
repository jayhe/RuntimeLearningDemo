//
//  ViewController.h
//  RuntimeLearning
//
//  Created by hechao on 2019/2/20.
//  Copyright © 2019 hechao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end

@class TableDataRow;

@interface TableDataSection : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSMutableArray<TableDataRow *> *items;

@end

@interface TableDataRow : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) SEL action;

@end

