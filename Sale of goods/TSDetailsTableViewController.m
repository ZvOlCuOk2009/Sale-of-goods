//
//  TSDetailsTableViewController.m
//  Sale of goods
//
//  Created by Mac on 21.05.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

#import "TSDetailsTableViewController.h"
#import "TSProduct.h"
#import "TSDataManager.h"
#import <CoreData/CoreData.h>

@interface TSDetailsTableViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;

@property (weak, nonatomic) IBOutlet UIImage *imageView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *collectionButton;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) UIImagePickerController *imagePicker;

@property (strong, nonatomic) TSProduct *product;
@property (assign, nonatomic) NSInteger currentTag;

@end

@implementation TSDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Post your item";
    [self.navigationItem.backBarButtonItem setTitle:@""];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

#pragma mark - NSManagedObjectContext

-(NSManagedObjectContext *) managedObjectContext {
    
    if (!_managedObjectContext) {
        _managedObjectContext = [[TSDataManager sharedManager] managedObjectContext];
    }
    return _managedObjectContext;
}

#pragma mark - Actions

- (IBAction)photoAction:(UIButton *)sender {
    
    /*
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        picker.showsCameraControls = NO;
//        [self presentViewController:picker animated:YES
//                         completion:^ {
//                             [picker takePicture];
//                         }];
    }
    
    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
        picker.allowsEditing = false;
        [self presentViewController:picker animated:true completion:nil];
    }
    
    
     */
    
    NSLog(@"TAG - %ld", sender.tag);
     
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        picker.allowsEditing = true;
        [self presentViewController:picker animated:YES completion:nil];
    }
    self.currentTag = sender.tag;
    //sender.imageView.image = self.imageView.image;
    
    //[self setButtonImageBackgruond:sender];
}

- (IBAction)postItAction:(id)sender
{
    TSProduct *product = [NSEntityDescription insertNewObjectForEntityForName:@"TSProduct"
                                                       inManagedObjectContext:self.managedObjectContext];
    product.name = self.nameTextField.text;
    product.price = self.priceTextField.text;
    product.specification = self.descriptionTextField.text;
    NSData *dataImage = UIImagePNGRepresentation(self.imageView);
  //  product.image = dataImage;
    [self.managedObjectContext save:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    NSLog(@"НАЗВАНИЕ - %@", self.nameTextField.text);
    NSLog(@"ОПИСАНИЕ - %@", self.descriptionTextField.text);
    NSLog(@"ЦЕНА - %@", self.priceTextField.text);
}

- (IBAction)saveImageButton:(id)sender {
//    self.imageData = UIImageJPEGRepresentation(self.imageView, 0.6);
//    UIImage *compressedJPGImage = [UIImage imageWithData:self.imageData];
//    UIImageWriteToSavedPhotosAlbum(compressedJPGImage, nil, nil, nil);
    
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Wow"
//                                                   message:@"Your image has been saved to Photo Library!" delegate:nil
//                                         cancelButtonTitle:@"Ok"
//                                         otherButtonTitles:nil, nil];
//    [alert show];
}

#pragma mark - UIImagePickerController

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imageView = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    [self setButtonImageBackgruond:self.currentTag];
}

- (void)setButtonImageBackgruond:(NSInteger)tagButton
{
    UIButton *currentButton = [self.collectionButton objectAtIndex:tagButton];
    [currentButton setImage:self.imageView forState:UIControlStateNormal];
}

@end
