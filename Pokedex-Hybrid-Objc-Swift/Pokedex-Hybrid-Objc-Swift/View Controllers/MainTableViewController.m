//
//  MainTableViewController.m
//  Pokedex-Hybrid-Objc-Swift
//
//  Created by Dongwoo Pae on 11/23/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

#import "MainTableViewController.h"
#import "DWPPokemon.h"
#import "Pokedex_Hybrid_Objc_Swift-Swift.h"
#import "DetailViewController.h"

@interface MainTableViewController ()

@property (nonatomic) NSArray<DWPPokemon *> *pokemons;

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [DWPokemonAPI.sharedController fetchAllPokemonWithCompletion:^(NSArray<DWPPokemon *> *pokemons, NSError *error) {
        if (error) {
            NSLog(@"Error in getting Pokemons - error: %@", error);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.pokemons = pokemons;
            [self.tableView reloadData];
        });
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    DWPPokemon *pokemon = [self.pokemons objectAtIndex:indexPath.row];
    cell.textLabel.text = pokemon.name;
    
    return cell;
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqualToString:@"ToShowDetail"]) {
         NSIndexPath *selectedRow = self.tableView.indexPathForSelectedRow;
         DetailViewController *detailVC = segue.destinationViewController;
         detailVC.pokemon =  [self.pokemons objectAtIndex:selectedRow.row];
     }
 }
 

@end
