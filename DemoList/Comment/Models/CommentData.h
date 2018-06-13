#import <UIKit/UIKit.h>
#import "Comment.h"

@interface CommentData : NSObject

@property (nonatomic, strong) Comment * comments;
@property (nonatomic, strong) NSString * info;
@property (nonatomic, assign) NSInteger ret;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end