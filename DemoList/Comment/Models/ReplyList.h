#import <UIKit/UIKit.h>
#import "Xy.h"

@interface ReplyList : NSObject

@property (nonatomic, assign) NSInteger agreeCount;
@property (nonatomic, strong) NSString * appid;
@property (nonatomic, strong) NSString * articleId;
@property (nonatomic, strong) NSString * articleImgurl;
@property (nonatomic, strong) NSString * articleTitle;
@property (nonatomic, strong) NSString * cattr;
@property (nonatomic, strong) NSString * charName;
@property (nonatomic, strong) NSString * commentContent;
@property (nonatomic, strong) NSObject * commentNick;
@property (nonatomic, strong) NSString * commentShareEnable;
@property (nonatomic, strong) NSString * commentid;
@property (nonatomic, strong) NSString * coralScore;
@property (nonatomic, strong) NSString * coralUid;
@property (nonatomic, assign) NSInteger forbidEdit;
@property (nonatomic, strong) NSString * headUrl;
@property (nonatomic, assign) NSInteger isOpenMb;
@property (nonatomic, assign) NSInteger isSinaVip;
@property (nonatomic, assign) NSInteger issupport;
@property (nonatomic, strong) NSString * mbHeadUrl;
@property (nonatomic, assign) NSInteger mbIsgroupvip;
@property (nonatomic, assign) NSInteger mbIsvip;
@property (nonatomic, strong) NSString * mbNickName;
@property (nonatomic, strong) NSString * mbUsrDesc;
@property (nonatomic, strong) NSString * mbUsrDescDetail;
@property (nonatomic, strong) NSString * mediaid;
@property (nonatomic, strong) NSString * nick;
@property (nonatomic, strong) NSString * openid;
@property (nonatomic, strong) NSString * parentid;
@property (nonatomic, strong) NSArray * pic;
@property (nonatomic, assign) NSInteger pokeCount;
@property (nonatomic, strong) NSString * provinceCity;
@property (nonatomic, assign) NSInteger pubTime;
@property (nonatomic, strong) NSArray * radio;
@property (nonatomic, strong) NSString * replyContent;
@property (nonatomic, strong) NSString * replyId;
@property (nonatomic, strong) NSArray * replyList;
@property (nonatomic, assign) NSInteger replyNum;
@property (nonatomic, strong) NSString * rootid;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString * tipstime;
@property (nonatomic, strong) NSString * uin;
@property (nonatomic, assign) NSInteger uinType;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSArray * xy;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
