//
//	Comment.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Comment.h"

NSString *const kCommentBnext = @"bnext";
NSString *const kCommentCount = @"count";
NSString *const kCommentOrig = @"orig";
NSString *const kCommentReplyList = @"reply_list";

@interface Comment ()
@end
@implementation Comment

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"replyList":@"reply_list"
             };
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"replyList":[ReplyList class]};
}

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kCommentBnext] isKindOfClass:[NSNull class]]){
		self.bnext = [dictionary[kCommentBnext] integerValue];
	}

	if(![dictionary[kCommentCount] isKindOfClass:[NSNull class]]){
		self.count = [dictionary[kCommentCount] integerValue];
	}

	if(![dictionary[kCommentOrig] isKindOfClass:[NSNull class]]){
		self.orig = [[Orig alloc] initWithDictionary:dictionary[kCommentOrig]];
	}

	if(dictionary[kCommentReplyList] != nil && [dictionary[kCommentReplyList] isKindOfClass:[NSArray class]]){
		NSArray * replyListDictionaries = dictionary[kCommentReplyList];
		NSMutableArray * replyListItems = [NSMutableArray array];
		for(NSDictionary * replyListDictionary in replyListDictionaries){
			ReplyList * replyListItem = [[ReplyList alloc] initWithDictionary:replyListDictionary];
			[replyListItems addObject:replyListItem];
		}
		self.replyList = replyListItems;
	}
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kCommentBnext] = @(self.bnext);
	dictionary[kCommentCount] = @(self.count);
	if(self.orig != nil){
		dictionary[kCommentOrig] = [self.orig toDictionary];
	}
	if(self.replyList != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(ReplyList * replyListElement in self.replyList){
			[dictionaryElements addObject:[replyListElement toDictionary]];
		}
		dictionary[kCommentReplyList] = dictionaryElements;
	}
	return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:@(self.bnext) forKey:kCommentBnext];	[aCoder encodeObject:@(self.count) forKey:kCommentCount];	if(self.orig != nil){
		[aCoder encodeObject:self.orig forKey:kCommentOrig];
	}
	if(self.replyList != nil){
		[aCoder encodeObject:self.replyList forKey:kCommentReplyList];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.bnext = [[aDecoder decodeObjectForKey:kCommentBnext] integerValue];
	self.count = [[aDecoder decodeObjectForKey:kCommentCount] integerValue];
	self.orig = [aDecoder decodeObjectForKey:kCommentOrig];
	self.replyList = [aDecoder decodeObjectForKey:kCommentReplyList];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Comment *copy = [Comment new];

	copy.bnext = self.bnext;
	copy.count = self.count;
	copy.orig = [self.orig copy];
	copy.replyList = [self.replyList copy];

	return copy;
}
@end
