#import <UIKit/UIKit.h>
#import "Orig.h"
#import "ReplyList.h"

@interface Comment : NSObject

@property (nonatomic, assign) NSInteger bnext;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) Orig * orig;
@property (nonatomic, strong) NSArray<ReplyList*> * replyList;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
