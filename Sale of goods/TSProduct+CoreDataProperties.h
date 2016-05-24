//
//  TSProduct+CoreDataProperties.h
//  Sale of goods
//
//  Created by Mac on 23.05.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TSProduct.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSProduct (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *price;
@property (nullable, nonatomic, retain) NSString *specification;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *images;

@end

@interface TSProduct (CoreDataGeneratedAccessors)

- (void)addImagesObject:(NSManagedObject *)value;
- (void)removeImagesObject:(NSManagedObject *)value;
- (void)addImages:(NSSet<NSManagedObject *> *)values;
- (void)removeImages:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
