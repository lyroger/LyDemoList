//
//	CommentData.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "CommentData.h"

NSString *const kCommentDataComments = @"comments";
NSString *const kCommentDataInfo = @"info";
NSString *const kCommentDataRet = @"ret";

@interface CommentData ()
@end
@implementation CommentData




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kCommentDataComments] isKindOfClass:[NSNull class]]){
		self.comments = [[Comment alloc] initWithDictionary:dictionary[kCommentDataComments]];
	}

	if(![dictionary[kCommentDataInfo] isKindOfClass:[NSNull class]]){
		self.info = dictionary[kCommentDataInfo];
	}	
	if(![dictionary[kCommentDataRet] isKindOfClass:[NSNull class]]){
		self.ret = [dictionary[kCommentDataRet] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.comments != nil){
		dictionary[kCommentDataComments] = [self.comments toDictionary];
	}
	if(self.info != nil){
		dictionary[kCommentDataInfo] = self.info;
	}
	dictionary[kCommentDataRet] = @(self.ret);
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
	if(self.comments != nil){
		[aCoder encodeObject:self.comments forKey:kCommentDataComments];
	}
	if(self.info != nil){
		[aCoder encodeObject:self.info forKey:kCommentDataInfo];
	}
	[aCoder encodeObject:@(self.ret) forKey:kCommentDataRet];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.comments = [aDecoder decodeObjectForKey:kCommentDataComments];
	self.info = [aDecoder decodeObjectForKey:kCommentDataInfo];
	self.ret = [[aDecoder decodeObjectForKey:kCommentDataRet] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	CommentData *copy = [CommentData new];

	copy.comments = [self.comments copy];
	copy.info = [self.info copy];
	copy.ret = self.ret;

	return copy;
}
@end