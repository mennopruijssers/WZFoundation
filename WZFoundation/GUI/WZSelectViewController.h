//
//  WZSelectViewController.h
//  WZFoundation
//
//  Created by Menno on 13-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WZSelectViewController;

typedef void(^CompletionBlock)(WZSelectViewController *controller, id selectedValue);

@interface WZSelectViewController : UITableViewController

- (id)initWithLabels:(NSArray*) labels values: (NSArray*) values;

@property (nonatomic, strong, readonly) NSArray *labels;
@property (nonatomic, strong, readonly) NSArray *values;
@property (nonatomic, strong) id selectedValue;
@property (nonatomic, copy) CompletionBlock onComplete;
@end
