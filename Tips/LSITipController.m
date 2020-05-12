//
//  LSITipController.m
//  Tips
//
//  Created by Tobi Kuyoro on 12/05/2020.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "LSITipController.h"
#import "LSITip.h"

// Class extension
@interface LSITipController () {
    // (Optional) Private instance variables
}
// Private Properties
@property (nonatomic, readwrite) NSMutableArray<LSITip *> *internalTips;

// Private Outlets
// Private methods
@end

@implementation LSITipController

- (instancetype)init {
    self = [super init];
    if (self) {
        _internalTips = [[NSMutableArray alloc] init];
    }

    return self;
}

- (NSArray<LSITip *> *)tips {
    return [_internalTips copy]; // copy: NSMutableArray -> NSArray
}

- (void)addTip:(LSITip *)tip {
    [ self.internalTips addObject:tip];
}


@end
