


#import "SharedValues.h"

@implementation SharedValues


+ (SharedValues *) allValues {
    
    static SharedValues *allValues;
    if (!allValues) {
        allValues = [[super allocWithZone:nil] init];
    }
    
    return allValues;
}

+ (id) allocWithZone:(struct _NSZone *)zone {
    return [self allValues];
}

@end
