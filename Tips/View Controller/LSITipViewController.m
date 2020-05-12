//
//  LSITipViewController.m
//  Tips
//
//  Created by Spencer Curtis on 2/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "LSITipViewController.h"
#import "LSITipController.h"
#import "LSITip.h"

@interface LSITipViewController () <UITableViewDelegate, UITableViewDataSource>

// Private Properties

@property (nonatomic) double total;
@property (nonatomic) int split;
@property (nonatomic) double percentage;
@property (nonatomic) double tip;

// Private IBOutlets

@property (strong, nonatomic) IBOutlet UITextField *totalTextField;
@property (strong, nonatomic) IBOutlet UILabel *splitLabel;
@property (strong, nonatomic) IBOutlet UILabel *tipLabel;
@property (strong, nonatomic) IBOutlet UILabel *percentageLabel;
@property (strong, nonatomic) IBOutlet UIStepper *splitStepper;
@property (strong, nonatomic) IBOutlet UISlider *percentageSlider;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

// Private Methods

- (void)calculateTip;
- (void)updateViews;
- (void)saveTipNamed:(NSString *)name;

@end

@implementation LSITipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Move to init or computed property
    self.tipController = [[LSITipController alloc] init];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)calculateTip {
    self.percentage = round(self.percentageSlider.value);
    self.total = [self.totalTextField.text doubleValue];
    self.split = self.splitStepper.value;

    self.tip = self.total * (self.percentage / 100.0) / self.split;

    [self updateViews];
}

- (void)updateViews {
    self.splitStepper.value = self.split;
    self.percentageSlider.value = self.percentage;
    self.totalTextField.text = [NSString stringWithFormat:@"%.2f", self.total];

    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", self.tip];
    self.splitLabel.text = [NSString stringWithFormat:@"%d", self.split];

    // %% = % for output
    self.percentageLabel.text = [NSString stringWithFormat:@"%0.0f%%", self.percentage];
}

- (void)saveTipNamed:(NSString *)name {

    LSITip *tip = [[LSITip alloc] initWithName:name total:self.total splitCount:self.split tipPercentage:self.tip];

    [self.tipController addTip:tip];

    [self.tableView reloadData];
}

// MARK: - IBActions

- (IBAction)updateSplit:(UIStepper *)sender {
    self.split = round(self.splitStepper.value);
    [self calculateTip];
}

- (IBAction)updatePercentage:(UISlider *)sender {
    self.percentage = round(self.percentageSlider.value);
    [self calculateTip];
}

- (IBAction)saveTipTapped:(UIButton *)sender {
    [self showSaveTipAlert];
}


// TODO: Connect actions for splitChanged, sliderChanged, and Save Tip button


// MARK: - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tipController.tips.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TipCell" forIndexPath:indexPath];

    LSITip *tip = [self.tipController.tips objectAtIndex:indexPath.row];
    cell.textLabel.text = tip.name; // TODO: Add other attributes or a custom cell
    return cell;
}

// MARK: - UITableViewDelegate

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

// TODO: Load the selected tip from the controller

//}

// MARK: - Alert Helper

- (void)showSaveTipAlert {
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"Save Tip"
                                message:@"What name would you like to give to this tip?"
                                preferredStyle:UIAlertControllerStyleAlert];
    
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Tip Name:";
    }];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save"
                                                         style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *name = [[alert.textFields firstObject] text];
        if (name.length > 0) {
            [self saveTipNamed: name];
        }
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    
    [alert addAction:saveAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
