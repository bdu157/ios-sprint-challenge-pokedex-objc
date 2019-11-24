//
//  DWPPokemon.h
//  Pokedex-Hybrid-Objc-Swift
//
//  Created by Dongwoo Pae on 11/23/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(Pokemon)
@interface DWPPokemon : NSObject

@property (nonatomic, copy, readonly, nonnull) NSString *name;
@property (nonatomic, copy, nullable) NSNumber *identifier;
@property (nonatomic, copy, nullable) NSArray *abilities;
@property (nonatomic, copy, nullable) NSString *sprite;

-(nonnull instancetype)initWithName:(nonnull NSString *)name identifier:(nullable NSNumber *)identifier abilities:(nullable NSArray *)abilities sprite:(nullable NSString *)sprite;

-(nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;

@end

