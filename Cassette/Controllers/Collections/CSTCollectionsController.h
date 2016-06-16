//
//  CSTCollectionsController.h
//  Cassette
//
//  Created by Stephen Hatton on 27/04/2016.
//  Copyright © 2016 Stephen Hatton. All rights reserved.
//

#import "CSTParentController.h"

#import "CSTBaseMix.h"
#import "CSTCollection.h"
#import "CSTUser.h"

@interface CSTCollectionsController : CSTParentController

@property (nonatomic, retain) NSMutableArray *collections;
@property (nonatomic, retain) CSTCollection *listenLaterCollection;



- (RXPromise *)getCollections:(CSTUser *)user;
- (void)getEditableCollections:(CSTUser *)user;

- (void)createCollection:(NSString *)nameOfCollection :(NSArray *)mixes :(CSTUser *)userID :(NSString *)username :(NSString *)password;
- (void)editCollection:(NSString *)collectionID :(NSString *)name :(NSString *)desc :(NSString *)username :(NSString *)password;
- (void)deleteCollection:(CSTCollection *)collection :(NSString *)username :(NSString *)password;

- (void)addMixToCollection:(NSString *)collectionID :(CSTBaseMix *)mix :(NSString *)username :(NSString *)password;
- (void)removeMixFromCollection:(NSString *)collectionID :(CSTBaseMix *)mix :(NSString *)username :(NSString *)password;

@end
