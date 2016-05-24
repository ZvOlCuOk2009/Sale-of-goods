//
//  TSDescriptionTableViewController.m
//  Sale of goods
//
//  Created by Mac on 22.05.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

#import "TSDescriptionTableViewController.h"
#import "TSProduct.h"
#import "TSDataManager.h"

@interface TSDescriptionTableViewController ()

@property (strong, nonatomic) TSProduct *currentProduct;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation TSDescriptionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameLabel.text = self.name;
    self.priceLabel.text = [NSString stringWithFormat:@"$%@", self.price];
    self.descriptionTextView.text = self.specification;
    UIImage *image = [UIImage imageWithData:self.image];
    self.mainImageView.image = image;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSManagedObjectContext

-(NSManagedObjectContext *) managedObjectContext {
    
    if (!_managedObjectContext) {
        _managedObjectContext = [[TSDataManager sharedManager] managedObjectContext];
    }
    return _managedObjectContext;
}

#pragma mark - Transfer pressed cell

- (void)receiveCell:(TSProduct *)product
{
    self.currentProduct = product;
}

#pragma mark - Ations

- (IBAction)trashButton:(id)sender {
    
    [self.managedObjectContext deleteObject:self.currentProduct];
    [self.managedObjectContext save:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)editButton:(id)sender {
    
}

@end
