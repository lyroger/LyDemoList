//
//	ReplyList.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "ReplyList.h"

NSString *const kReplyListAgreeCount = @"agree_count";
NSString *const kReplyListAppid = @"appid";
NSString *const kReplyListArticleId = @"article_id";
NSString *const kReplyListArticleImgurl = @"article_imgurl";
NSString *const kReplyListArticleTitle = @"article_title";
NSString *const kReplyListCattr = @"cattr";
NSString *const kReplyListCharName = @"char_name";
NSString *const kReplyListCommentContent = @"commentContent";
NSString *const kReplyListCommentNick = @"commentNick";
NSString *const kReplyListCommentShareEnable = @"commentShareEnable";
NSString *const kReplyListCommentid = @"commentid";
NSString *const kReplyListCoralScore = @"coral_score";
NSString *const kReplyListCoralUid = @"coral_uid";
NSString *const kReplyListForbidEdit = @"forbidEdit";
NSString *const kReplyListHeadUrl = @"head_url";
NSString *const kReplyListIsOpenMb = @"isOpenMb";
NSString *const kReplyListIsSinaVip = @"isSinaVip";
NSString *const kReplyListIssupport = @"issupport";
NSString *const kReplyListMbHeadUrl = @"mb_head_url";
NSString *const kReplyListMbIsgroupvip = @"mb_isgroupvip";
NSString *const kReplyListMbIsvip = @"mb_isvip";
NSString *const kReplyListMbNickName = @"mb_nick_name";
NSString *const kReplyListMbUsrDesc = @"mb_usr_desc";
NSString *const kReplyListMbUsrDescDetail = @"mb_usr_desc_detail";
NSString *const kReplyListMediaid = @"mediaid";
NSString *const kReplyListNick = @"nick";
NSString *const kReplyListOpenid = @"openid";
NSString *const kReplyListParentid = @"parentid";
NSString *const kReplyListPic = @"pic";
NSString *const kReplyListPokeCount = @"poke_count";
NSString *const kReplyListProvinceCity = @"province_city";
NSString *const kReplyListPubTime = @"pub_time";
NSString *const kReplyListRadio = @"radio";
NSString *const kReplyListReplyContent = @"reply_content";
NSString *const kReplyListReplyId = @"reply_id";
NSString *const kReplyListReplyList = @"reply_list";
NSString *const kReplyListReplyNum = @"reply_num";
NSString *const kReplyListRootid = @"rootid";
NSString *const kReplyListSex = @"sex";
NSString *const kReplyListStatus = @"status";
NSString *const kReplyListTipstime = @"tipstime";
NSString *const kReplyListUin = @"uin";
NSString *const kReplyListUinType = @"uin_type";
NSString *const kReplyListUrl = @"url";
NSString *const kReplyListXy = @"xy";

@interface ReplyList ()
@end
@implementation ReplyList

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"replyList":@"reply_list",
             @"replyContent":@"reply_content",
             @"agreeCount":@"agree_count",
             @"pubTime":@"pub_time",
             @"provinceCity":@"province_city",
             @"headUrl":@"head_url",
             };
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"reply_list":[ReplyList class]};
}

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kReplyListAgreeCount] isKindOfClass:[NSNull class]]){
		self.agreeCount = [dictionary[kReplyListAgreeCount] integerValue];
	}

	if(![dictionary[kReplyListAppid] isKindOfClass:[NSNull class]]){
		self.appid = dictionary[kReplyListAppid];
	}	
	if(![dictionary[kReplyListArticleId] isKindOfClass:[NSNull class]]){
		self.articleId = dictionary[kReplyListArticleId];
	}	
	if(![dictionary[kReplyListArticleImgurl] isKindOfClass:[NSNull class]]){
		self.articleImgurl = dictionary[kReplyListArticleImgurl];
	}	
	if(![dictionary[kReplyListArticleTitle] isKindOfClass:[NSNull class]]){
		self.articleTitle = dictionary[kReplyListArticleTitle];
	}	
	if(![dictionary[kReplyListCattr] isKindOfClass:[NSNull class]]){
		self.cattr = dictionary[kReplyListCattr];
	}	
	if(![dictionary[kReplyListCharName] isKindOfClass:[NSNull class]]){
		self.charName = dictionary[kReplyListCharName];
	}	
	if(![dictionary[kReplyListCommentContent] isKindOfClass:[NSNull class]]){
		self.commentContent = dictionary[kReplyListCommentContent];
	}	
	if(![dictionary[kReplyListCommentNick] isKindOfClass:[NSNull class]]){
		self.commentNick = dictionary[kReplyListCommentNick];
	}	
	if(![dictionary[kReplyListCommentShareEnable] isKindOfClass:[NSNull class]]){
		self.commentShareEnable = dictionary[kReplyListCommentShareEnable];
	}	
	if(![dictionary[kReplyListCommentid] isKindOfClass:[NSNull class]]){
		self.commentid = dictionary[kReplyListCommentid];
	}	
	if(![dictionary[kReplyListCoralScore] isKindOfClass:[NSNull class]]){
		self.coralScore = dictionary[kReplyListCoralScore];
	}	
	if(![dictionary[kReplyListCoralUid] isKindOfClass:[NSNull class]]){
		self.coralUid = dictionary[kReplyListCoralUid];
	}	
	if(![dictionary[kReplyListForbidEdit] isKindOfClass:[NSNull class]]){
		self.forbidEdit = [dictionary[kReplyListForbidEdit] integerValue];
	}

	if(![dictionary[kReplyListHeadUrl] isKindOfClass:[NSNull class]]){
		self.headUrl = dictionary[kReplyListHeadUrl];
	}	
	if(![dictionary[kReplyListIsOpenMb] isKindOfClass:[NSNull class]]){
		self.isOpenMb = [dictionary[kReplyListIsOpenMb] integerValue];
	}

	if(![dictionary[kReplyListIsSinaVip] isKindOfClass:[NSNull class]]){
		self.isSinaVip = [dictionary[kReplyListIsSinaVip] integerValue];
	}

	if(![dictionary[kReplyListIssupport] isKindOfClass:[NSNull class]]){
		self.issupport = [dictionary[kReplyListIssupport] integerValue];
	}

	if(![dictionary[kReplyListMbHeadUrl] isKindOfClass:[NSNull class]]){
		self.mbHeadUrl = dictionary[kReplyListMbHeadUrl];
	}	
	if(![dictionary[kReplyListMbIsgroupvip] isKindOfClass:[NSNull class]]){
		self.mbIsgroupvip = [dictionary[kReplyListMbIsgroupvip] integerValue];
	}

	if(![dictionary[kReplyListMbIsvip] isKindOfClass:[NSNull class]]){
		self.mbIsvip = [dictionary[kReplyListMbIsvip] integerValue];
	}

	if(![dictionary[kReplyListMbNickName] isKindOfClass:[NSNull class]]){
		self.mbNickName = dictionary[kReplyListMbNickName];
	}	
	if(![dictionary[kReplyListMbUsrDesc] isKindOfClass:[NSNull class]]){
		self.mbUsrDesc = dictionary[kReplyListMbUsrDesc];
	}	
	if(![dictionary[kReplyListMbUsrDescDetail] isKindOfClass:[NSNull class]]){
		self.mbUsrDescDetail = dictionary[kReplyListMbUsrDescDetail];
	}	
	if(![dictionary[kReplyListMediaid] isKindOfClass:[NSNull class]]){
		self.mediaid = dictionary[kReplyListMediaid];
	}	
	if(![dictionary[kReplyListNick] isKindOfClass:[NSNull class]]){
		self.nick = dictionary[kReplyListNick];
	}	
	if(![dictionary[kReplyListOpenid] isKindOfClass:[NSNull class]]){
		self.openid = dictionary[kReplyListOpenid];
	}	
	if(![dictionary[kReplyListParentid] isKindOfClass:[NSNull class]]){
		self.parentid = dictionary[kReplyListParentid];
	}	
	if(![dictionary[kReplyListPic] isKindOfClass:[NSNull class]]){
		self.pic = dictionary[kReplyListPic];
	}	
	if(![dictionary[kReplyListPokeCount] isKindOfClass:[NSNull class]]){
		self.pokeCount = [dictionary[kReplyListPokeCount] integerValue];
	}

	if(![dictionary[kReplyListProvinceCity] isKindOfClass:[NSNull class]]){
		self.provinceCity = dictionary[kReplyListProvinceCity];
	}	
	if(![dictionary[kReplyListPubTime] isKindOfClass:[NSNull class]]){
		self.pubTime = [dictionary[kReplyListPubTime] integerValue];
	}

	if(![dictionary[kReplyListRadio] isKindOfClass:[NSNull class]]){
		self.radio = dictionary[kReplyListRadio];
	}	
	if(![dictionary[kReplyListReplyContent] isKindOfClass:[NSNull class]]){
		self.replyContent = dictionary[kReplyListReplyContent];
	}	
	if(![dictionary[kReplyListReplyId] isKindOfClass:[NSNull class]]){
		self.replyId = dictionary[kReplyListReplyId];
	}	
	if(![dictionary[kReplyListReplyList] isKindOfClass:[NSNull class]]){
		self.replyList = dictionary[kReplyListReplyList];
	}	
	if(![dictionary[kReplyListReplyNum] isKindOfClass:[NSNull class]]){
		self.replyNum = [dictionary[kReplyListReplyNum] integerValue];
	}

	if(![dictionary[kReplyListRootid] isKindOfClass:[NSNull class]]){
		self.rootid = dictionary[kReplyListRootid];
	}	
	if(![dictionary[kReplyListSex] isKindOfClass:[NSNull class]]){
		self.sex = [dictionary[kReplyListSex] integerValue];
	}

	if(![dictionary[kReplyListStatus] isKindOfClass:[NSNull class]]){
		self.status = [dictionary[kReplyListStatus] integerValue];
	}

	if(![dictionary[kReplyListTipstime] isKindOfClass:[NSNull class]]){
		self.tipstime = dictionary[kReplyListTipstime];
	}	
	if(![dictionary[kReplyListUin] isKindOfClass:[NSNull class]]){
		self.uin = dictionary[kReplyListUin];
	}	
	if(![dictionary[kReplyListUinType] isKindOfClass:[NSNull class]]){
		self.uinType = [dictionary[kReplyListUinType] integerValue];
	}

	if(![dictionary[kReplyListUrl] isKindOfClass:[NSNull class]]){
		self.url = dictionary[kReplyListUrl];
	}	
	if(dictionary[kReplyListXy] != nil && [dictionary[kReplyListXy] isKindOfClass:[NSArray class]]){
		NSArray * xyDictionaries = dictionary[kReplyListXy];
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
	dictionary[kReplyListAgreeCount] = @(self.agreeCount);
	if(self.appid != nil){
		dictionary[kReplyListAppid] = self.appid;
	}
	if(self.articleId != nil){
		dictionary[kReplyListArticleId] = self.articleId;
	}
	if(self.articleImgurl != nil){
		dictionary[kReplyListArticleImgurl] = self.articleImgurl;
	}
	if(self.articleTitle != nil){
		dictionary[kReplyListArticleTitle] = self.articleTitle;
	}
	if(self.cattr != nil){
		dictionary[kReplyListCattr] = self.cattr;
	}
	if(self.charName != nil){
		dictionary[kReplyListCharName] = self.charName;
	}
	if(self.commentContent != nil){
		dictionary[kReplyListCommentContent] = self.commentContent;
	}
	if(self.commentNick != nil){
		dictionary[kReplyListCommentNick] = self.commentNick;
	}
	if(self.commentShareEnable != nil){
		dictionary[kReplyListCommentShareEnable] = self.commentShareEnable;
	}
	if(self.commentid != nil){
		dictionary[kReplyListCommentid] = self.commentid;
	}
	if(self.coralScore != nil){
		dictionary[kReplyListCoralScore] = self.coralScore;
	}
	if(self.coralUid != nil){
		dictionary[kReplyListCoralUid] = self.coralUid;
	}
	dictionary[kReplyListForbidEdit] = @(self.forbidEdit);
	if(self.headUrl != nil){
		dictionary[kReplyListHeadUrl] = self.headUrl;
	}
	dictionary[kReplyListIsOpenMb] = @(self.isOpenMb);
	dictionary[kReplyListIsSinaVip] = @(self.isSinaVip);
	dictionary[kReplyListIssupport] = @(self.issupport);
	if(self.mbHeadUrl != nil){
		dictionary[kReplyListMbHeadUrl] = self.mbHeadUrl;
	}
	dictionary[kReplyListMbIsgroupvip] = @(self.mbIsgroupvip);
	dictionary[kReplyListMbIsvip] = @(self.mbIsvip);
	if(self.mbNickName != nil){
		dictionary[kReplyListMbNickName] = self.mbNickName;
	}
	if(self.mbUsrDesc != nil){
		dictionary[kReplyListMbUsrDesc] = self.mbUsrDesc;
	}
	if(self.mbUsrDescDetail != nil){
		dictionary[kReplyListMbUsrDescDetail] = self.mbUsrDescDetail;
	}
	if(self.mediaid != nil){
		dictionary[kReplyListMediaid] = self.mediaid;
	}
	if(self.nick != nil){
		dictionary[kReplyListNick] = self.nick;
	}
	if(self.openid != nil){
		dictionary[kReplyListOpenid] = self.openid;
	}
	if(self.parentid != nil){
		dictionary[kReplyListParentid] = self.parentid;
	}
	if(self.pic != nil){
		dictionary[kReplyListPic] = self.pic;
	}
	dictionary[kReplyListPokeCount] = @(self.pokeCount);
	if(self.provinceCity != nil){
		dictionary[kReplyListProvinceCity] = self.provinceCity;
	}
	dictionary[kReplyListPubTime] = @(self.pubTime);
	if(self.radio != nil){
		dictionary[kReplyListRadio] = self.radio;
	}
	if(self.replyContent != nil){
		dictionary[kReplyListReplyContent] = self.replyContent;
	}
	if(self.replyId != nil){
		dictionary[kReplyListReplyId] = self.replyId;
	}
	if(self.replyList != nil){
		dictionary[kReplyListReplyList] = self.replyList;
	}
	dictionary[kReplyListReplyNum] = @(self.replyNum);
	if(self.rootid != nil){
		dictionary[kReplyListRootid] = self.rootid;
	}
	dictionary[kReplyListSex] = @(self.sex);
	dictionary[kReplyListStatus] = @(self.status);
	if(self.tipstime != nil){
		dictionary[kReplyListTipstime] = self.tipstime;
	}
	if(self.uin != nil){
		dictionary[kReplyListUin] = self.uin;
	}
	dictionary[kReplyListUinType] = @(self.uinType);
	if(self.url != nil){
		dictionary[kReplyListUrl] = self.url;
	}
	if(self.xy != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(Xy * xyElement in self.xy){
			[dictionaryElements addObject:[xyElement toDictionary]];
		}
		dictionary[kReplyListXy] = dictionaryElements;
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
	[aCoder encodeObject:@(self.agreeCount) forKey:kReplyListAgreeCount];	if(self.appid != nil){
		[aCoder encodeObject:self.appid forKey:kReplyListAppid];
	}
	if(self.articleId != nil){
		[aCoder encodeObject:self.articleId forKey:kReplyListArticleId];
	}
	if(self.articleImgurl != nil){
		[aCoder encodeObject:self.articleImgurl forKey:kReplyListArticleImgurl];
	}
	if(self.articleTitle != nil){
		[aCoder encodeObject:self.articleTitle forKey:kReplyListArticleTitle];
	}
	if(self.cattr != nil){
		[aCoder encodeObject:self.cattr forKey:kReplyListCattr];
	}
	if(self.charName != nil){
		[aCoder encodeObject:self.charName forKey:kReplyListCharName];
	}
	if(self.commentContent != nil){
		[aCoder encodeObject:self.commentContent forKey:kReplyListCommentContent];
	}
	if(self.commentNick != nil){
		[aCoder encodeObject:self.commentNick forKey:kReplyListCommentNick];
	}
	if(self.commentShareEnable != nil){
		[aCoder encodeObject:self.commentShareEnable forKey:kReplyListCommentShareEnable];
	}
	if(self.commentid != nil){
		[aCoder encodeObject:self.commentid forKey:kReplyListCommentid];
	}
	if(self.coralScore != nil){
		[aCoder encodeObject:self.coralScore forKey:kReplyListCoralScore];
	}
	if(self.coralUid != nil){
		[aCoder encodeObject:self.coralUid forKey:kReplyListCoralUid];
	}
	[aCoder encodeObject:@(self.forbidEdit) forKey:kReplyListForbidEdit];	if(self.headUrl != nil){
		[aCoder encodeObject:self.headUrl forKey:kReplyListHeadUrl];
	}
	[aCoder encodeObject:@(self.isOpenMb) forKey:kReplyListIsOpenMb];	[aCoder encodeObject:@(self.isSinaVip) forKey:kReplyListIsSinaVip];	[aCoder encodeObject:@(self.issupport) forKey:kReplyListIssupport];	if(self.mbHeadUrl != nil){
		[aCoder encodeObject:self.mbHeadUrl forKey:kReplyListMbHeadUrl];
	}
	[aCoder encodeObject:@(self.mbIsgroupvip) forKey:kReplyListMbIsgroupvip];	[aCoder encodeObject:@(self.mbIsvip) forKey:kReplyListMbIsvip];	if(self.mbNickName != nil){
		[aCoder encodeObject:self.mbNickName forKey:kReplyListMbNickName];
	}
	if(self.mbUsrDesc != nil){
		[aCoder encodeObject:self.mbUsrDesc forKey:kReplyListMbUsrDesc];
	}
	if(self.mbUsrDescDetail != nil){
		[aCoder encodeObject:self.mbUsrDescDetail forKey:kReplyListMbUsrDescDetail];
	}
	if(self.mediaid != nil){
		[aCoder encodeObject:self.mediaid forKey:kReplyListMediaid];
	}
	if(self.nick != nil){
		[aCoder encodeObject:self.nick forKey:kReplyListNick];
	}
	if(self.openid != nil){
		[aCoder encodeObject:self.openid forKey:kReplyListOpenid];
	}
	if(self.parentid != nil){
		[aCoder encodeObject:self.parentid forKey:kReplyListParentid];
	}
	if(self.pic != nil){
		[aCoder encodeObject:self.pic forKey:kReplyListPic];
	}
	[aCoder encodeObject:@(self.pokeCount) forKey:kReplyListPokeCount];	if(self.provinceCity != nil){
		[aCoder encodeObject:self.provinceCity forKey:kReplyListProvinceCity];
	}
	[aCoder encodeObject:@(self.pubTime) forKey:kReplyListPubTime];	if(self.radio != nil){
		[aCoder encodeObject:self.radio forKey:kReplyListRadio];
	}
	if(self.replyContent != nil){
		[aCoder encodeObject:self.replyContent forKey:kReplyListReplyContent];
	}
	if(self.replyId != nil){
		[aCoder encodeObject:self.replyId forKey:kReplyListReplyId];
	}
	if(self.replyList != nil){
		[aCoder encodeObject:self.replyList forKey:kReplyListReplyList];
	}
	[aCoder encodeObject:@(self.replyNum) forKey:kReplyListReplyNum];	if(self.rootid != nil){
		[aCoder encodeObject:self.rootid forKey:kReplyListRootid];
	}
	[aCoder encodeObject:@(self.sex) forKey:kReplyListSex];	[aCoder encodeObject:@(self.status) forKey:kReplyListStatus];	if(self.tipstime != nil){
		[aCoder encodeObject:self.tipstime forKey:kReplyListTipstime];
	}
	if(self.uin != nil){
		[aCoder encodeObject:self.uin forKey:kReplyListUin];
	}
	[aCoder encodeObject:@(self.uinType) forKey:kReplyListUinType];	if(self.url != nil){
		[aCoder encodeObject:self.url forKey:kReplyListUrl];
	}
	if(self.xy != nil){
		[aCoder encodeObject:self.xy forKey:kReplyListXy];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.agreeCount = [[aDecoder decodeObjectForKey:kReplyListAgreeCount] integerValue];
	self.appid = [aDecoder decodeObjectForKey:kReplyListAppid];
	self.articleId = [aDecoder decodeObjectForKey:kReplyListArticleId];
	self.articleImgurl = [aDecoder decodeObjectForKey:kReplyListArticleImgurl];
	self.articleTitle = [aDecoder decodeObjectForKey:kReplyListArticleTitle];
	self.cattr = [aDecoder decodeObjectForKey:kReplyListCattr];
	self.charName = [aDecoder decodeObjectForKey:kReplyListCharName];
	self.commentContent = [aDecoder decodeObjectForKey:kReplyListCommentContent];
	self.commentNick = [aDecoder decodeObjectForKey:kReplyListCommentNick];
	self.commentShareEnable = [aDecoder decodeObjectForKey:kReplyListCommentShareEnable];
	self.commentid = [aDecoder decodeObjectForKey:kReplyListCommentid];
	self.coralScore = [aDecoder decodeObjectForKey:kReplyListCoralScore];
	self.coralUid = [aDecoder decodeObjectForKey:kReplyListCoralUid];
	self.forbidEdit = [[aDecoder decodeObjectForKey:kReplyListForbidEdit] integerValue];
	self.headUrl = [aDecoder decodeObjectForKey:kReplyListHeadUrl];
	self.isOpenMb = [[aDecoder decodeObjectForKey:kReplyListIsOpenMb] integerValue];
	self.isSinaVip = [[aDecoder decodeObjectForKey:kReplyListIsSinaVip] integerValue];
	self.issupport = [[aDecoder decodeObjectForKey:kReplyListIssupport] integerValue];
	self.mbHeadUrl = [aDecoder decodeObjectForKey:kReplyListMbHeadUrl];
	self.mbIsgroupvip = [[aDecoder decodeObjectForKey:kReplyListMbIsgroupvip] integerValue];
	self.mbIsvip = [[aDecoder decodeObjectForKey:kReplyListMbIsvip] integerValue];
	self.mbNickName = [aDecoder decodeObjectForKey:kReplyListMbNickName];
	self.mbUsrDesc = [aDecoder decodeObjectForKey:kReplyListMbUsrDesc];
	self.mbUsrDescDetail = [aDecoder decodeObjectForKey:kReplyListMbUsrDescDetail];
	self.mediaid = [aDecoder decodeObjectForKey:kReplyListMediaid];
	self.nick = [aDecoder decodeObjectForKey:kReplyListNick];
	self.openid = [aDecoder decodeObjectForKey:kReplyListOpenid];
	self.parentid = [aDecoder decodeObjectForKey:kReplyListParentid];
	self.pic = [aDecoder decodeObjectForKey:kReplyListPic];
	self.pokeCount = [[aDecoder decodeObjectForKey:kReplyListPokeCount] integerValue];
	self.provinceCity = [aDecoder decodeObjectForKey:kReplyListProvinceCity];
	self.pubTime = [[aDecoder decodeObjectForKey:kReplyListPubTime] integerValue];
	self.radio = [aDecoder decodeObjectForKey:kReplyListRadio];
	self.replyContent = [aDecoder decodeObjectForKey:kReplyListReplyContent];
	self.replyId = [aDecoder decodeObjectForKey:kReplyListReplyId];
	self.replyList = [aDecoder decodeObjectForKey:kReplyListReplyList];
	self.replyNum = [[aDecoder decodeObjectForKey:kReplyListReplyNum] integerValue];
	self.rootid = [aDecoder decodeObjectForKey:kReplyListRootid];
	self.sex = [[aDecoder decodeObjectForKey:kReplyListSex] integerValue];
	self.status = [[aDecoder decodeObjectForKey:kReplyListStatus] integerValue];
	self.tipstime = [aDecoder decodeObjectForKey:kReplyListTipstime];
	self.uin = [aDecoder decodeObjectForKey:kReplyListUin];
	self.uinType = [[aDecoder decodeObjectForKey:kReplyListUinType] integerValue];
	self.url = [aDecoder decodeObjectForKey:kReplyListUrl];
	self.xy = [aDecoder decodeObjectForKey:kReplyListXy];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	ReplyList *copy = [ReplyList new];

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
	copy.coralScore = [self.coralScore copy];
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
	copy.replyList = [self.replyList copy];
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
