//
//	Xy.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Xy.h"

NSString *const kXyAddress = @"address";
NSString *const kXyCity = @"city";
NSString *const kXyDistince = @"distince";
NSString *const kXyLat = @"lat";
NSString *const kXyLng = @"lng";

@interface Xy ()
@end
@implementation Xy




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kXyAddress] isKindOfClass:[NSNull class]]){
		self.address = dictionary[kXyAddress];
	}	
	if(![dictionary[kXyCity] isKindOfClass:[NSNull class]]){
		self.city = dictionary[kXyCity];
	}	
	if(![dictionary[kXyDistince] isKindOfClass:[NSNull class]]){
		self.distince = dictionary[kXyDistince];
	}	
	if(![dictionary[kXyLat] isKindOfClass:[NSNull class]]){
		self.lat = dictionary[kXyLat];
	}	
	if(![dictionary[kXyLng] isKindOfClass:[NSNull class]]){
		self.lng = dictionary[kXyLng];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.address != nil){
		dictionary[kXyAddress] = self.address;
	}
	if(self.city != nil){
		dictionary[kXyCity] = self.city;
	}
	if(self.distince != nil){
		dictionary[kXyDistince] = self.distince;
	}
	if(self.lat != nil){
		dictionary[kXyLat] = self.lat;
	}
	if(self.lng != nil){
		dictionary[kXyLng] = self.lng;
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
	if(self.address != nil){
		[aCoder encodeObject:self.address forKey:kXyAddress];
	}
	if(self.city != nil){
		[aCoder encodeObject:self.city forKey:kXyCity];
	}
	if(self.distince != nil){
		[aCoder encodeObject:self.distince forKey:kXyDistince];
	}
	if(self.lat != nil){
		[aCoder encodeObject:self.lat forKey:kXyLat];
	}
	if(self.lng != nil){
		[aCoder encodeObject:self.lng forKey:kXyLng];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.address = [aDecoder decodeObjectForKey:kXyAddress];
	self.city = [aDecoder decodeObjectForKey:kXyCity];
	self.distince = [aDecoder decodeObjectForKey:kXyDistince];
	self.lat = [aDecoder decodeObjectForKey:kXyLat];
	self.lng = [aDecoder decodeObjectForKey:kXyLng];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Xy *copy = [Xy new];

	copy.address = [self.address copy];
	copy.city = [self.city copy];
	copy.distince = [self.distince copy];
	copy.lat = [self.lat copy];
	copy.lng = [self.lng copy];

	return copy;
}
@end