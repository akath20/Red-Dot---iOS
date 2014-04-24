


#import "SharedValues.h"

@implementation SharedValues


+ (SharedValues *) allValues {
    
    static SharedValues *allValues;
    if (!allValues) {
        allValues = [[super allocWithZone:nil] init];
    }
    
    return allValues;
}

- (void)createColors {
    
    
    NSArray *colorsArray = [NSArray arrayWithObjects:[UIColor blackColor], [UIColor grayColor], [UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor cyanColor], [UIColor yellowColor], [UIColor magentaColor], [UIColor orangeColor], [UIColor purpleColor], [UIColor brownColor], nil];
    
    _colorsArray = [[NSArray alloc] initWithArray:colorsArray copyItems:true];
    
    
    
}

@end
