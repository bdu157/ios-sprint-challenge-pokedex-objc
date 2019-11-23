//
//  DetailViewController.m
//  Pokedex-Hybrid-Objc-Swift
//
//  Created by Dongwoo Pae on 11/23/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

#import "DetailViewController.h"
#import "DWPPokemon.h"
#import "Pokedex_Hybrid_Objc_Swift-Swift.h"

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
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateViews];
    
    [DWPokemonAPI.sharedController fillInDetailsFor:self.pokemon];
}


#pragma mark - private methods
-(void)updateViews
{
    if (self.pokemon) {
        self.nameLabel.text = self.pokemon.name;
        self.idLabel.text = self.pokemon.identifier;
        //self.abilitiesTextView.text = self.pokemon.abilities;
        
        //give a conditional that you only fetch if there is image string from calling fillinperson method
        if (self.pokemon.sprite) {
            [DWPokemonAPI.sharedController fetchSprite:self.pokemon.sprite completionHandler:^(UIImage *image, NSError *error) {
                if (error) {
                    NSLog(@"Error in fetching images: %@", error);
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.pokedexImageView.image = image;
                });
            }];
        }
    }
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
        [self updateViews];
    }
}

@end
