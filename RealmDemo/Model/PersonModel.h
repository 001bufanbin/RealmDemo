//
//  PersonModel.h
//  RealmDemo
//
//  Created by bufb on 2017/9/12.
//  Copyright © 2017年 kris. All rights reserved.
//

#import "RealmBaseModel.h"

@interface Dog : RealmBaseModel
@property NSString *name;
@property NSInteger age;
@end
RLM_ARRAY_TYPE(Dog)

@interface Language : RealmBaseModel
@property NSString *value;
@end
RLM_ARRAY_TYPE(Language)

//Version-1.0
@interface PersonModel : RealmBaseModel
@property NSString *identification;
@property NSString *firstName;
@property NSString *secondName;
@property RLMArray<Dog> *dogs;
@property (nonatomic ,strong)NSArray *languages;
@property RLMArray<Language> *storedLanguages;
@end

////Version-2.0
//@interface PersonModel : RealmBaseModel
//@property NSString *identification;
//@property NSString *fullName;
//@property RLMArray<Dog> *dogs;
//@property (nonatomic ,strong)NSArray *languages;
//@property RLMArray<Language> *storedLanguages;
//@end
