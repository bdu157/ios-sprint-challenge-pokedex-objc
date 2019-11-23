//
//  DWPPokemon.m
//  Pokedex-Hybrid-Objc-Swift
//
//  Created by Dongwoo Pae on 11/23/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

#import "DWPPokemon.h"

@implementation DWPPokemon

- (instancetype)initWithName:(NSString *)name identifier:(NSString *)identifier abilities:(NSArray *)abilities sprite:(NSString *)sprite
{
    self = [super init];
    if (self) {
        _name = name.copy;
        _identifier = identifier.copy;
        _abilities = abilities.copy;
        _sprite = sprite.copy;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    
    NSString *name = dictionary[@"name"];
    return [self initWithName:name identifier:NULL abilities:NULL sprite:NULL];
}

@end
