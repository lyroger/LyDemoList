#import <UIKit/UIKit.h>

@interface Xy : NSObject

@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) NSString * city;
@property (nonatomic, strong) NSString * distince;
@property (nonatomic, strong) NSString * lat;
@property (nonatomic, strong) NSString * lng;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end