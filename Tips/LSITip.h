//
//  LSITip.h
//  Tips
//
//  Created by Tobi Kuyoro on 12/05/2020.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSITip : NSObject

// MARK: - Properties

@property NSString *name;
@property double total;
@property int splitCount;
@property double tipPercentage;

// 3 things happen with a property declaration
// 1. getter method
    //- (NSString *)name;
// 2. setter method
    //- (void)setName:(NSString * _Nonnull)name
// 3. instance variable
    // NSString *_name;

// MARK: - Methods

- (instancetype)initWithName:(NSString *)name
                       total:(double)total
                  splitCount:(int)splitCount
               tipPercentage:(double)tipPercentage;

@end

NS_ASSUME_NONNULL_END
