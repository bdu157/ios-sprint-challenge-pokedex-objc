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

//c pointer
void *KVOContext = &KVOContext;

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pokedexImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UITextView *abilitiesTextView;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateViews];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [DWPokemonAPI.sharedController fillInDetailsFor:self.pokemon];
}


#pragma mark - private methods
-(void)updateViews
{
    if (self.pokemon) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.nameLabel.text = self.pokemon.name;
            self.idLabel.text = [self.pokemon.identifier stringValue];
            self.abilitiesTextView.text = [self.pokemon.abilities componentsJoinedByString:@" \n"];
        });
    };
    
    //give a conditional that you only fetch if there is image string from calling fillinDetails method
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


//setter - add observer
-(void)setPokemon:(DWPPokemon *)pokemon
{
    //if old user is not same as new user here then assign old user (original user) to new user and updateViews
    if(pokemon != _pokemon) {
        
        NSLog(@"setting a pokemon being triggers");
        
        [_pokemon removeObserver:self forKeyPath:@"identifier" context:KVOContext];
        [_pokemon removeObserver:self forKeyPath:@"abilities" context:KVOContext];
        [_pokemon removeObserver:self forKeyPath:@"sprite" context:KVOContext];
        
        NSLog(@"setting old pokemon: %@ new pokemon: %@", _pokemon, pokemon);
        //old pokemon = Null
        _pokemon = pokemon;
        
        NSLog(@"setting old pokemon: %@ new pokemon: %@", _pokemon, pokemon);
        
        [_pokemon addObserver:self forKeyPath:@"identifier" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"abilities" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"sprite" options:NSKeyValueObservingOptionInitial context:KVOContext];
        
        [self updateViews];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == KVOContext) {
        [self updateViews];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
