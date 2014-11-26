//
//  LtTextViewController.h
//  LybabTrans
//
//  Created by Spencer on 7/25/13.
//  Copyright (c) 2013 Yeh Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

//#import "LtSelectLocaleViewController.h"
//#import "LtVocalizing.h"
//#import "LtLongPressButton.h"

//NSMutableData *responseData;
//NSMutableArray *responseArray;
//NSString *_lastText;

@interface LtTextViewController : UIViewController <UITableViewDataSource, UITextViewDelegate,UIGestureRecognizerDelegate,NSFetchedResultsControllerDelegate, MFMailComposeViewControllerDelegate>

//@property (nonatomic, strong) NSMutableArray *translations;
//@property (nonatomic, copy) NSString *lastText;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *footer1LocaleButton;
@property (weak, nonatomic) IBOutlet UIButton *footer2LocaleButton;

@property (weak, nonatomic) IBOutlet UIButton *footer1SpeakButton;
@property (weak, nonatomic) IBOutlet UIButton *footer2SpeakButton;
@property (weak, nonatomic) IBOutlet UIPinchGestureRecognizer *pinchGestureRecognizer;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

@property (weak, nonatomic) IBOutlet UIToolbar *tableViewToolBar;

@property (weak, nonatomic) IBOutlet UIImageView *topLogoImageView;

@property (weak, nonatomic) IBOutlet UIImageView *bottomLogoImageView;

@property (weak, nonatomic) IBOutlet UIView *logoView;

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@property (atomic) CGFloat textViewFontSize;
//@property (nonatomic, weak) NSString *xtextViewFont;



- (IBAction)clearTextView:(id)sender;

//- (IBAction)translate:(id)sender;  // Now done on the CR in the text view

- (IBAction)recognize:(id)sender;

- (IBAction)vocalize:(id)sender;

- (IBAction)selectLanguage:(id)sender;

- (IBAction)interpret:(id)sender;

- (IBAction)edit:(id)sender;

- (IBAction)deleteAll:(id)sender;

- (IBAction)handlePinch:(id)sender;

- (IBAction)actionMenu:(id)sender;

- (IBAction)shareTranscript:(id)sender;

@end
