//
//	Orig.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Orig.h"

NSString *const kOrigAgreeCount = @"agree_count";
NSString *const kOrigAppid = @"appid";
NSString *const kOrigArticleId = @"article_id";
NSString *const kOrigArticleImgurl = @"article_imgurl";
NSString *const kOrigArticleTitle = @"article_title";
NSString *const kOrigCattr = @"cattr";
NSString *const kOrigCharName = @"char_name";
NSString *const kOrigCommentContent = @"commentContent";
NSString *const kOrigCommentNick = @"commentNick";
NSString *const kOrigCommentShareEnable = @"commentShareEnable";
NSString *const kOrigCommentid = @"commentid";
NSString *const kOrigCoralUid = @"coral_uid";
NSString *const kOrigForbidEdit = @"forbidEdit";
NSString *const kOrigHeadUrl = @"head_url";
NSString *const kOrigIsOpenMb = @"isOpenMb";
NSString *const kOrigIsSinaVip = @"isSinaVip";
NSString *const kOrigIssupport = @"issupport";
NSString *const kOrigMbHeadUrl = @"mb_head_url";
NSString *const kOrigMbIsgroupvip = @"mb_isgroupvip";
NSString *const kOrigMbIsvip = @"mb_isvip";
NSString *const kOrigMbNickName = @"mb_nick_name";
NSString *const kOrigMbUsrDesc = @"mb_usr_desc";
NSString *const kOrigMbUsrDescDetail = @"mb_usr_desc_detail";
NSString *const kOrigMediaid = @"mediaid";
NSString *const kOrigNick = @"nick";
NSString *const kOrigOpenid = @"openid";
NSString *const kOrigParentid = @"parentid";
NSString *const kOrigPic = @"pic";
NSString *const kOrigPokeCount = @"poke_count";
NSString *const kOrigProvinceCity = @"province_city";
NSString *const kOrigPubTime = @"pub_time";
NSString *const kOrigRadio = @"radio";
NSString *const kOrigReplyContent = @"reply_content";
NSString *const kOrigReplyId = @"reply_id";
NSString *const kOrigReplyNum = @"reply_num";
NSString *const kOrigRootid = @"rootid";
NSString *const kOrigSex = @"sex";
NSString *const kOrigStatus = @"status";
NSString *const kOrigTipstime = @"tipstime";
NSString *const kOrigUin = @"uin";
NSString *const kOrigUinType = @"uin_type";
NSString *const kOrigUrl = @"url";
NSString *const kOrigXy = @"xy";

@interface Orig ()
@end
@implementation Orig


+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"replyContent":@"reply_content",
             @"agreeCount":@"agree_count",
             @"pubTime":@"pub_time",
             @"provinceCity":@"province_city",
             @"headUrl":@"head_url",
             };
}

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kOrigAgreeCount] isKindOfClass:[NSNull class]]){
		self.agreeCount = [dictionary[kOrigAgreeCount] integerValue];
	}

	if(![dictionary[kOrigAppid] isKindOfClass:[NSNull class]]){
		self.appid = dictionary[kOrigAppid];
	}	
	if(![dictionary[kOrigArticleId] isKindOfClass:[NSNull class]]){
		self.articleId = dictionary[kOrigArticleId];
	}	
	if(![dictionary[kOrigArticleImgurl] isKindOfClass:[NSNull class]]){
		self.articleImgurl = dictionary[kOrigArticleImgurl];
	}	
	if(![dictionary[kOrigArticleTitle] isKindOfClass:[NSNull class]]){
		self.articleTitle = dictionary[kOrigArticleTitle];
	}	
	if(![dictionary[kOrigCattr] isKindOfClass:[NSNull class]]){
		self.cattr = dictionary[kOrigCattr];
	}	
	if(![dictionary[kOrigCharName] isKindOfClass:[NSNull class]]){
		self.charName = dictionary[kOrigCharName];
	}	
	if(![dictionary[kOrigCommentContent] isKindOfClass:[NSNull class]]){
		self.commentContent = dictionary[kOrigCommentContent];
	}	
	if(![dictionary[kOrigCommentNick] isKindOfClass:[NSNull class]]){
		self.commentNick = dictionary[kOrigCommentNick];
	}	
	if(![dictionary[kOrigCommentShareEnable] isKindOfClass:[NSNull class]]){
		self.commentShareEnable = dictionary[kOrigCommentShareEnable];
	}	
	if(![dictionary[kOrigCommentid] isKindOfClass:[NSNull class]]){
		self.commentid = dictionary[kOrigCommentid];
	}	
	if(![dictionary[kOrigCoralUid] isKindOfClass:[NSNull class]]){
		self.coralUid = dictionary[kOrigCoralUid];
	}	
	if(![dictionary[kOrigForbidEdit] isKindOfClass:[NSNull class]]){
		self.forbidEdit = [dictionary[kOrigForbidEdit] integerValue];
	}

	if(![dictionary[kOrigHeadUrl] isKindOfClass:[NSNull class]]){
		self.headUrl = dictionary[kOrigHeadUrl];
	}	
	if(![dictionary[kOrigIsOpenMb] isKindOfClass:[NSNull class]]){
		self.isOpenMb = [dictionary[kOrigIsOpenMb] integerValue];
	}

	if(![dictionary[kOrigIsSinaVip] isKindOfClass:[NSNull class]]){
		self.isSinaVip = [dictionary[kOrigIsSinaVip] integerValue];
	}

	if(![dictionary[kOrigIssupport] isKindOfClass:[NSNull class]]){
		self.issupport = [dictionary[kOrigIssupport] integerValue];
	}

	if(![dictionary[kOrigMbHeadUrl] isKindOfClass:[NSNull class]]){
		self.mbHeadUrl = dictionary[kOrigMbHeadUrl];
	}	
	if(![dictionary[kOrigMbIsgroupvip] isKindOfClass:[NSNull class]]){
		self.mbIsgroupvip = [dictionary[kOrigMbIsgroupvip] integerValue];
	}

	if(![dictionary[kOrigMbIsvip] isKindOfClass:[NSNull class]]){
		self.mbIsvip = [dictionary[kOrigMbIsvip] integerValue];
	}

	if(![dictionary[kOrigMbNickName] isKindOfClass:[NSNull class]]){
		self.mbNickName = dictionary[kOrigMbNickName];
	}	
	if(![dictionary[kOrigMbUsrDesc] isKindOfClass:[NSNull class]]){
		self.mbUsrDesc = dictionary[kOrigMbUsrDesc];
	}	
	if(![dictionary[kOrigMbUsrDescDetail] isKindOfClass:[NSNull class]]){
		self.mbUsrDescDetail = dictionary[kOrigMbUsrDescDetail];
	}	
	if(![dictionary[kOrigMediaid] isKindOfClass:[NSNull class]]){
		self.mediaid = dictionary[kOrigMediaid];
	}	
	if(![dictionary[kOrigNick] isKindOfClass:[NSNull class]]){
		self.nick = dictionary[kOrigNick];
	}	
	if(![dictionary[kOrigOpenid] isKindOfClass:[NSNull class]]){
		self.openid = dictionary[kOrigOpenid];
	}	
	if(![dictionary[kOrigParentid] isKindOfClass:[NSNull class]]){
		self.parentid = dictionary[kOrigParentid];
	}	
	if(![dictionary[kOrigPic] isKindOfClass:[NSNull class]]){
		self.pic = dictionary[kOrigPic];
	}	
	if(![dictionary[kOrigPokeCount] isKindOfClass:[NSNull class]]){
		self.pokeCount = [dictionary[kOrigPokeCount] integerValue];
	}

	if(![dictionary[kOrigProvinceCity] isKindOfClass:[NSNull class]]){
		self.provinceCity = dictionary[kOrigProvinceCity];
	}	
	if(![dictionary[kOrigPubTime] isKindOfClass:[NSNull class]]){
		self.pubTime = [dictionary[kOrigPubTime] integerValue];
	}

	if(![dictionary[kOrigRadio] isKindOfClass:[NSNull class]]){
		self.radio = dictionary[kOrigRadio];
	}	
	if(![dictionary[kOrigReplyContent] isKindOfClass:[NSNull class]]){
		self.replyContent = dictionary[kOrigReplyContent];
	}	
	if(![dictionary[kOrigReplyId] isKindOfClass:[NSNull class]]){
		self.replyId = dictionary[kOrigReplyId];
	}	
	if(![dictionary[kOrigReplyNum] isKindOfClass:[NSNull class]]){
		self.replyNum = [dictionary[kOrigReplyNum] integerValue];
	}

	if(![dictionary[kOrigRootid] isKindOfClass:[NSNull class]]){
		self.rootid = dictionary[kOrigRootid];
	}	
	if(![dictionary[kOrigSex] isKindOfClass:[NSNull class]]){
		self.sex = [dictionary[kOrigSex] integerValue];
	}

	if(![dictionary[kOrigStatus] isKindOfClass:[NSNull class]]){
		self.status = [dictionary[kOrigStatus] integerValue];
	}

	if(![dictionary[kOrigTipstime] isKindOfClass:[NSNull class]]){
		self.tipstime = dictionary[kOrigTipstime];
	}	
	if(![dictionary[kOrigUin] isKindOfClass:[NSNull class]]){
		self.uin = dictionary[kOrigUin];
	}	
	if(![dictionary[kOrigUinType] isKindOfClass:[NSNull class]]){
		self.uinType = [dictionary[kOrigUinType] integerValue];
	}

	if(![dictionary[kOrigUrl] isKindOfClass:[NSNull class]]){
		self.url = dictionary[kOrigUrl];
	}	
	if(dictionary[kOrigXy] != nil && [dictionary[kOrigXy] isKindOfClass:[NSArray class]]){
		NSArray * xyDictionaries = dictionary[kOrigXy];
		NSMutableArray * xyItems = [NSMutableArray array];
		for(NSDictionary * xyDictionary in xyDictionaries){
			Xy * xyItem = [[Xy alloc] initWithDictionary:xyDictionary];
			[xyItems addObject:xyItem];
		}
		self.xy = xyItems;
	}
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kOrigAgreeCount] = @(self.agreeCount);
	if(self.appid != nil){
		dictionary[kOrigAppid] = self.appid;
	}
	if(self.articleId != nil){
		dictionary[kOrigArticleId] = self.articleId;
	}
	if(self.articleImgurl != nil){
		dictionary[kOrigArticleImgurl] = self.articleImgurl;
	}
	if(self.articleTitle != nil){
		dictionary[kOrigArticleTitle] = self.articleTitle;
	}
	if(self.cattr != nil){
		dictionary[kOrigCattr] = self.cattr;
	}
	if(self.charName != nil){
		dictionary[kOrigCharName] = self.charName;
	}
	if(self.commentContent != nil){
		dictionary[kOrigCommentContent] = self.commentContent;
	}
	if(self.commentNick != nil){
		dictionary[kOrigCommentNick] = self.commentNick;
	}
	if(self.commentShareEnable != nil){
		dictionary[kOrigCommentShareEnable] = self.commentShareEnable;
	}
	if(self.commentid != nil){
		dictionary[kOrigCommentid] = self.commentid;
	}
	if(self.coralUid != nil){
		dictionary[kOrigCoralUid] = self.coralUid;
	}
	dictionary[kOrigForbidEdit] = @(self.forbidEdit);
	if(self.headUrl != nil){
		dictionary[kOrigHeadUrl] = self.headUrl;
	}
	dictionary[kOrigIsOpenMb] = @(self.isOpenMb);
	dictionary[kOrigIsSinaVip] = @(self.isSinaVip);
	dictionary[kOrigIssupport] = @(self.issupport);
	if(self.mbHeadUrl != nil){
		dictionary[kOrigMbHeadUrl] = self.mbHeadUrl;
	}
	dictionary[kOrigMbIsgroupvip] = @(self.mbIsgroupvip);
	dictionary[kOrigMbIsvip] = @(self.mbIsvip);
	if(self.mbNickName != nil){
		dictionary[kOrigMbNickName] = self.mbNickName;
	}
	if(self.mbUsrDesc != nil){
		dictionary[kOrigMbUsrDesc] = self.mbUsrDesc;
	}
	if(self.mbUsrDescDetail != nil){
		dictionary[kOrigMbUsrDescDetail] = self.mbUsrDescDetail;
	}
	if(self.mediaid != nil){
		dictionary[kOrigMediaid] = self.mediaid;
	}
	if(self.nick != nil){
		dictionary[kOrigNick] = self.nick;
	}
	if(self.openid != nil){
		dictionary[kOrigOpenid] = self.openid;
	}
	if(self.parentid != nil){
		dictionary[kOrigParentid] = self.parentid;
	}
	if(self.pic != nil){
		dictionary[kOrigPic] = self.pic;
	}
	dictionary[kOrigPokeCount] = @(self.pokeCount);
	if(self.provinceCity != nil){
		dictionary[kOrigProvinceCity] = self.provinceCity;
	}
	dictionary[kOrigPubTime] = @(self.pubTime);
	if(self.radio != nil){
		dictionary[kOrigRadio] = self.radio;
	}
	if(self.replyContent != nil){
		dictionary[kOrigReplyContent] = self.replyContent;
	}
	if(self.replyId != nil){
		dictionary[kOrigReplyId] = self.replyId;
	}
	dictionary[kOrigReplyNum] = @(self.replyNum);
	if(self.rootid != nil){
		dictionary[kOrigRootid] = self.rootid;
	}
	dictionary[kOrigSex] = @(self.sex);
	dictionary[kOrigStatus] = @(self.status);
	if(self.tipstime != nil){
		dictionary[kOrigTipstime] = self.tipstime;
	}
	if(self.uin != nil){
		dictionary[kOrigUin] = self.uin;
	}
	dictionary[kOrigUinType] = @(self.uinType);
	if(self.url != nil){
		dictionary[kOrigUrl] = self.url;
	}
	if(self.xy != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(Xy * xyElement in self.xy){
			[dictionaryElements addObject:[xyElement toDictionary]];
		}
		dictionary[kOrigXy] = dictionaryElements;
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
	[aCoder encodeObject:@(self.agreeCount) forKey:kOrigAgreeCount];	if(self.appid != nil){
		[aCoder encodeObject:self.appid forKey:kOrigAppid];
	}
	if(self.articleId != nil){
		[aCoder encodeObject:self.articleId forKey:kOrigArticleId];
	}
	if(self.articleImgurl != nil){
		[aCoder encodeObject:self.articleImgurl forKey:kOrigArticleImgurl];
	}
	if(self.articleTitle != nil){
		[aCoder encodeObject:self.articleTitle forKey:kOrigArticleTitle];
	}
	if(self.cattr != nil){
		[aCoder encodeObject:self.cattr forKey:kOrigCattr];
	}
	if(self.charName != nil){
		[aCoder encodeObject:self.charName forKey:kOrigCharName];
	}
	if(self.commentContent != nil){
		[aCoder encodeObject:self.commentContent forKey:kOrigCommentContent];
	}
	if(self.commentNick != nil){
		[aCoder encodeObject:self.commentNick forKey:kOrigCommentNick];
	}
	if(self.commentShareEnable != nil){
		[aCoder encodeObject:self.commentShareEnable forKey:kOrigCommentShareEnable];
	}
	if(self.commentid != nil){
		[aCoder encodeObject:self.commentid forKey:kOrigCommentid];
	}
	if(self.coralUid != nil){
		[aCoder encodeObject:self.coralUid forKey:kOrigCoralUid];
	}
	[aCoder encodeObject:@(self.forbidEdit) forKey:kOrigForbidEdit];	if(self.headUrl != nil){
		[aCoder encodeObject:self.headUrl forKey:kOrigHeadUrl];
	}
	[aCoder encodeObject:@(self.isOpenMb) forKey:kOrigIsOpenMb];	[aCoder encodeObject:@(self.isSinaVip) forKey:kOrigIsSinaVip];	[aCoder encodeObject:@(self.issupport) forKey:kOrigIssupport];	if(self.mbHeadUrl != nil){
		[aCoder encodeObject:self.mbHeadUrl forKey:kOrigMbHeadUrl];
	}
	[aCoder encodeObject:@(self.mbIsgroupvip) forKey:kOrigMbIsgroupvip];	[aCoder encodeObject:@(self.mbIsvip) forKey:kOrigMbIsvip];	if(self.mbNickName != nil){
		[aCoder encodeObject:self.mbNickName forKey:kOrigMbNickName];
	}
	if(self.mbUsrDesc != nil){
		[aCoder encodeObject:self.mbUsrDesc forKey:kOrigMbUsrDesc];
	}
	if(self.mbUsrDescDetail != nil){
		[aCoder encodeObject:self.mbUsrDescDetail forKey:kOrigMbUsrDescDetail];
	}
	if(self.mediaid != nil){
		[aCoder encodeObject:self.mediaid forKey:kOrigMediaid];
	}
	if(self.nick != nil){
		[aCoder encodeObject:self.nick forKey:kOrigNick];
	}
	if(self.openid != nil){
		[aCoder encodeObject:self.openid forKey:kOrigOpenid];
	}
	if(self.parentid != nil){
		[aCoder encodeObject:self.parentid forKey:kOrigParentid];
	}
	if(self.pic != nil){
		[aCoder encodeObject:self.pic forKey:kOrigPic];
	}
	[aCoder encodeObject:@(self.pokeCount) forKey:kOrigPokeCount];	if(self.provinceCity != nil){
		[aCoder encodeObject:self.provinceCity forKey:kOrigProvinceCity];
	}
	[aCoder encodeObject:@(self.pubTime) forKey:kOrigPubTime];	if(self.radio != nil){
		[aCoder encodeObject:self.radio forKey:kOrigRadio];
	}
	if(self.replyContent != nil){
		[aCoder encodeObject:self.replyContent forKey:kOrigReplyContent];
	}
	if(self.replyId != nil){
		[aCoder encodeObject:self.replyId forKey:kOrigReplyId];
	}
	[aCoder encodeObject:@(self.replyNum) forKey:kOrigReplyNum];	if(self.rootid != nil){
		[aCoder encodeObject:self.rootid forKey:kOrigRootid];
	}
	[aCoder encodeObject:@(self.sex) forKey:kOrigSex];	[aCoder encodeObject:@(self.status) forKey:kOrigStatus];	if(self.tipstime != nil){
		[aCoder encodeObject:self.tipstime forKey:kOrigTipstime];
	}
	if(self.uin != nil){
		[aCoder encodeObject:self.uin forKey:kOrigUin];
	}
	[aCoder encodeObject:@(self.uinType) forKey:kOrigUinType];	if(self.url != nil){
		[aCoder encodeObject:self.url forKey:kOrigUrl];
	}
	if(self.xy != nil){
		[aCoder encodeObject:self.xy forKey:kOrigXy];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.agreeCount = [[aDecoder decodeObjectForKey:kOrigAgreeCount] integerValue];
	self.appid = [aDecoder decodeObjectForKey:kOrigAppid];
	self.articleId = [aDecoder decodeObjectForKey:kOrigArticleId];
	self.articleImgurl = [aDecoder decodeObjectForKey:kOrigArticleImgurl];
	self.articleTitle = [aDecoder decodeObjectForKey:kOrigArticleTitle];
	self.cattr = [aDecoder decodeObjectForKey:kOrigCattr];
	self.charName = [aDecoder decodeObjectForKey:kOrigCharName];
	self.commentContent = [aDecoder decodeObjectForKey:kOrigCommentContent];
	self.commentNick = [aDecoder decodeObjectForKey:kOrigCommentNick];
	self.commentShareEnable = [aDecoder decodeObjectForKey:kOrigCommentShareEnable];
	self.commentid = [aDecoder decodeObjectForKey:kOrigCommentid];
	self.coralUid = [aDecoder decodeObjectForKey:kOrigCoralUid];
	self.forbidEdit = [[aDecoder decodeObjectForKey:kOrigForbidEdit] integerValue];
	self.headUrl = [aDecoder decodeObjectForKey:kOrigHeadUrl];
	self.isOpenMb = [[aDecoder decodeObjectForKey:kOrigIsOpenMb] integerValue];
	self.isSinaVip = [[aDecoder decodeObjectForKey:kOrigIsSinaVip] integerValue];
	self.issupport = [[aDecoder decodeObjectForKey:kOrigIssupport] integerValue];
	self.mbHeadUrl = [aDecoder decodeObjectForKey:kOrigMbHeadUrl];
	self.mbIsgroupvip = [[aDecoder decodeObjectForKey:kOrigMbIsgroupvip] integerValue];
	self.mbIsvip = [[aDecoder decodeObjectForKey:kOrigMbIsvip] integerValue];
	self.mbNickName = [aDecoder decodeObjectForKey:kOrigMbNickName];
	self.mbUsrDesc = [aDecoder decodeObjectForKey:kOrigMbUsrDesc];
	self.mbUsrDescDetail = [aDecoder decodeObjectForKey:kOrigMbUsrDescDetail];
	self.mediaid = [aDecoder decodeObjectForKey:kOrigMediaid];
	self.nick = [aDecoder decodeObjectForKey:kOrigNick];
	self.openid = [aDecoder decodeObjectForKey:kOrigOpenid];
	self.parentid = [aDecoder decodeObjectForKey:kOrigParentid];
	self.pic = [aDecoder decodeObjectForKey:kOrigPic];
	self.pokeCount = [[aDecoder decodeObjectForKey:kOrigPokeCount] integerValue];
	self.provinceCity = [aDecoder decodeObjectForKey:kOrigProvinceCity];
	self.pubTime = [[aDecoder decodeObjectForKey:kOrigPubTime] integerValue];
	self.radio = [aDecoder decodeObjectForKey:kOrigRadio];
	self.replyContent = [aDecoder decodeObjectForKey:kOrigReplyContent];
	self.replyId = [aDecoder decodeObjectForKey:kOrigReplyId];
	self.replyNum = [[aDecoder decodeObjectForKey:kOrigReplyNum] integerValue];
	self.rootid = [aDecoder decodeObjectForKey:kOrigRootid];
	self.sex = [[aDecoder decodeObjectForKey:kOrigSex] integerValue];
	self.status = [[aDecoder decodeObjectForKey:kOrigStatus] integerValue];
	self.tipstime = [aDecoder decodeObjectForKey:kOrigTipstime];
	self.uin = [aDecoder decodeObjectForKey:kOrigUin];
	self.uinType = [[aDecoder decodeObjectForKey:kOrigUinType] integerValue];
	self.url = [aDecoder decodeObjectForKey:kOrigUrl];
	self.xy = [aDecoder decodeObjectForKey:kOrigXy];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Orig *copy = [Orig new];

	copy.agreeCount = self.agreeCount;
	copy.appid = [self.appid copy];
	copy.articleId = [self.articleId copy];
	copy.articleImgurl = [self.articleImgurl copy];
	copy.articleTitle = [self.articleTitle copy];
	copy.cattr = [self.cattr copy];
	copy.charName = [self.charName copy];
	copy.commentContent = [self.commentContent copy];
	copy.commentNick = [self.commentNick copy];
	copy.commentShareEnable = [self.commentShareEnable copy];
	copy.commentid = [self.commentid copy];
	copy.coralUid = [self.coralUid copy];
	copy.forbidEdit = self.forbidEdit;
	copy.headUrl = [self.headUrl copy];
	copy.isOpenMb = self.isOpenMb;
	copy.isSinaVip = self.isSinaVip;
	copy.issupport = self.issupport;
	copy.mbHeadUrl = [self.mbHeadUrl copy];
	copy.mbIsgroupvip = self.mbIsgroupvip;
	copy.mbIsvip = self.mbIsvip;
	copy.mbNickName = [self.mbNickName copy];
	copy.mbUsrDesc = [self.mbUsrDesc copy];
	copy.mbUsrDescDetail = [self.mbUsrDescDetail copy];
	copy.mediaid = [self.mediaid copy];
	copy.nick = [self.nick copy];
	copy.openid = [self.openid copy];
	copy.parentid = [self.parentid copy];
	copy.pic = [self.pic copy];
	copy.pokeCount = self.pokeCount;
	copy.provinceCity = [self.provinceCity copy];
	copy.pubTime = self.pubTime;
	copy.radio = [self.radio copy];
	copy.replyContent = [self.replyContent copy];
	copy.replyId = [self.replyId copy];
	copy.replyNum = self.replyNum;
	copy.rootid = [self.rootid copy];
	copy.sex = self.sex;
	copy.status = self.status;
	copy.tipstime = [self.tipstime copy];
	copy.uin = [self.uin copy];
	copy.uinType = self.uinType;
	copy.url = [self.url copy];
	copy.xy = [self.xy copy];

	return copy;
}
@end
