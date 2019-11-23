//
//  DetailViewController.m
//  Pokedex-Hybrid-Objc-Swift
//
//  Created by Dongwoo Pae on 11/23/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pokedexImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UITextView *abilitiesTextView;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


//setter - add observer
-(void)setPokemon:(DWPPokemon *)pokemon
{
    //if old user is not same as new user here then assign old user (original user) to new user and updateViews
    if(pokemon != _pokemon) {
        
        NSLog(@"setting a pokemon being triggers");
        
 //       [_user removeObserver:self forKeyPath:@"email" context:KVOContext];

        NSLog(@"setting old pokemon: %@ new pokemon: %@", _pokemon, pokemon);
        //old pokemon = Null
        _pokemon = pokemon;
        
        NSLog(@"setting old pokemon: %@ new pokemon: %@", _pokemon, pokemon);
    
 //       [_user addObserver:self forKeyPath:@"email" options:NSKeyValueObservingOptionInitial context:KVOContext];

    }
}

@end
