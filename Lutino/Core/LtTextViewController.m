//
//  LtTextViewController.m
//  LybabTrans
//
//  Created by Spencer on 7/25/13.
//  Copyright (c) 2013 Yeh Technology. All rights reserved.
//

//#import <Foundation/NSException.h>
//#import <MessageUI/MessageUI.h>
#import <AVFoundation/AVFoundation.h>

#import "LtTextViewController.h"
//#import "LtSelectLocaleViewController.h"
#import "LtTranslationCell.h"
//#import "LtTranslation_UNUSED.h"
/*
#import "LtTranslating.h"
#import "LtTranslatorFactory.h"
#import "LtOptions.h"
#import "LtRecognizing.h"
#import "LtRecognizerFactory.h"
#import "LtVocalizing.h"
#import "LtVocalizerFactory.h"
 */
#import "LtTranslationData.h"
#import "LtContext.h"

#import "LtLocale.h"

/*
#import "LtUsage.h"
#import "LtZoomViewController.h"
#import "LtSupportedLocales.h"
 */
#import "UIKitLineMetrics.h"
//#import "LtStoreViewController.h"
#import "LtUiUtility.h"

#define kTextViewFont @"Roboto-Light"
#define kMaxFontSize 40
#define kMinFontSize 6
#define kGreenColor [UIColor colorWithRed:0.2 green:0.4 blue:0.0 alpha:0.4]

@interface LtTextViewController ()

@end

@implementation LtTextViewController
{
    UITextView *m_SourceTextView;
    UITextView *m_TargetTextView;
    
    NSString *m_SourceLocale;
    NSString *m_TargetLocale;
    
    /*
    LtLocale *m_Footer1Locale;
    LtLocale *m_Footer2Locale;
    
    id <LtRecognizing> m_DefaultRecognizer;
    id <LtRecognizing> m_SpecifiedRecognizer;
    NSString *m_DefaultRecognizerName;
    id <LtTranslating> m_DefaultTranslator;
    id <LtTranslating> m_SpecifiedTranslator;
    NSString *m_DefaultTranslatorName;
    NSString *m_TranslatorName;
    id <LtVocalizing> m_DefaultVocalizer;
    id <LtVocalizing> m_SpecifiedVocalizer;
    NSString *m_DefaultVocalizerName;
     */
    
    BOOL m_IsInConversationMode;
    BOOL m_IsReverseTranslation;
    BOOL m_IsRecognizing;
    
    __weak LtTranslationData *m_CurrentTranslation;
    
    UITextView *m_CurrentTextView;
    
    NSString *m_LastTranslationText;
    NSString *m_LastTranslationLocaleCode;
    
    UIKitLineMetrics *m_LineMetrics;
    
    UIButton *m_LastButtonPressed;
    
    BOOL m_IsResizingFont;
}

@synthesize tableView;

@synthesize footer1LocaleButton;
@synthesize footer2LocaleButton;
@synthesize footer1SpeakButton;
@synthesize footer2SpeakButton;
@synthesize pinchGestureRecognizer;

@synthesize managedObjectContext;
@synthesize fetchedResultsController;

@synthesize textViewFontSize;

@synthesize editButton;
@synthesize tableViewToolBar;

@synthesize topLogoImageView;
@synthesize bottomLogoImageView;
@synthesize logoView;

/*
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
      
    }
    return self;
}
 */



- (void)viewDidLoad
{
    [super viewDidLoad];
        
    // Hide keypad when user touches on background of TableView
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:gestureRecognizer];
    
    
    
    /*
    if (m_Footer1Locale == nil)
    {
        m_Footer1Locale = [[LtLocale alloc] initWithLocaleCode:LtOptions.instance.footer1Locale];
        [footer1LocaleButton setImage:m_Footer1Locale.largeFlag forState:UIControlStateNormal];
        [footer1SpeakButton setTitle:m_Footer1Locale.name forState:UIControlStateNormal];
        if (LtOptions.instance.voiceRecognition && [LtSupportedLocales.instance.recognitionLocaleCodes containsObject:m_Footer1Locale.localeCode])
        {
            [footer1SpeakButton setImage:[UIImage imageNamed:@"microphone.14x24.png"] forState:UIControlStateNormal];
        }
        else
        {
            [footer1SpeakButton setImage:nil forState:UIControlStateNormal];
        }
        //[footer1SpeakButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 2)];
        [footer1SpeakButton layoutIfNeeded];  // needed to fix truncated button image problem
    }
    //footer1SpeakButton.titleLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:11];
    
    if (m_Footer2Locale == nil)
    {
        m_Footer2Locale = [[LtLocale alloc] initWithLocaleCode:LtOptions.instance.footer2Locale];
        [footer2LocaleButton setImage:m_Footer2Locale.largeFlag forState:UIControlStateNormal];
        [footer2SpeakButton setTitle:m_Footer2Locale.name forState:UIControlStateNormal];
        if (LtOptions.instance.voiceRecognition && [LtSupportedLocales.instance.recognitionLocaleCodes containsObject:m_Footer2Locale.localeCode])
        {
            [footer2SpeakButton setImage:[UIImage imageNamed:@"microphone.14x24.png"] forState:UIControlStateNormal];
        }
        else
        {
            [footer2SpeakButton setImage:nil forState:UIControlStateNormal];
        }
        //[footer2SpeakButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 2)];
        [footer2SpeakButton layoutIfNeeded]; // needed to fix truncated button image problem
    }
    //footer2SpeakButton.titleLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:11];
    
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}
     */
    
    textViewFontSize = 17.0; //LtOptions.instance.textViewFontSize;
    //xtextViewFont = kTextViewFont;
    
    pinchGestureRecognizer.delaysTouchesBegan = YES;
    
    tableView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    tableView.layer.borderWidth = 0.3f;
    
    // iOS 8
    /*
    tableView.estimatedRowHeight = 100.0;
    tableView.rowHeight = UITableViewAutomaticDimension;
     */

    
    m_LineMetrics = [UIKitLineMetrics new];
    
/*
    NSMutableArray *menuItems = [NSMutableArray new];
    
    if (LtOptions.instance.advancedFeatures)
    {
        [menuItems addObject:[[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"Duplicate", @"") action:@selector(duplicate:)]];
    }

    [menuItems addObject:[[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"Rate5Stars", @"") action:@selector(rate5Stars:)]];
    [[UIMenuController sharedMenuController] setMenuItems:menuItems];
    
    //[self.tableView addLongPressRecognizer];
    
    if (kBuildType == kFreeVersion)
    {
        topLogoImageView.image = [UIImage imageNamed:@"LutinoFreeLogo.145x40.png"];
    }
    // Else default is set in storyboard
    
    [self checkAudioPermissions];
 */
    
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    if ([[self.fetchedResultsController fetchedObjects] count] == 0)
    {
        [self addTranslation];
    }
    
}

- (void) viewWillAppear:(BOOL)animated
{
    // Turn off navigation bar in this view.
    self.navigationController.navigationBarHidden = YES;
    
    /*
    [LtSupportedLocales refresh];
    
    if (LtOptions.instance.voiceRecognition && [LtSupportedLocales.instance.recognitionLocaleCodes containsObject:m_Footer1Locale.localeCode])
    {
        [footer1SpeakButton setImage:[UIImage imageNamed:@"microphone.14x24.png"] forState:UIControlStateNormal];
    }
    else
    {
        [footer1SpeakButton setImage:nil forState:UIControlStateNormal];
    }
    [footer1SpeakButton layoutIfNeeded];  // needed to fix truncated button image problem
    
    if (LtOptions.instance.voiceRecognition && [LtSupportedLocales.instance.recognitionLocaleCodes containsObject:m_Footer2Locale.localeCode])
    {
        [footer2SpeakButton setImage:[UIImage imageNamed:@"microphone.14x24.png"] forState:UIControlStateNormal];
    }
    else
    {
        [footer2SpeakButton setImage:nil forState:UIControlStateNormal];
    }
    [footer2SpeakButton layoutIfNeeded];  // needed to fix truncated button image problem
*/
    
    [tableView reloadData];  // Needed to update UI widget visibility if Options change.
                            // May need to make this conditional if performance becomes an issue.
    
    /*
    float logoViewHeight;
    
    if ([LtOptions.instance.recognizer isEqualToString:@"NuanceRecognizer"] || [LtOptions.instance.vocalizer isEqualToString:@"NuanceVocalizer"])
    {
        [bottomLogoImageView setImage:[UIImage imageNamed:@"nuance.75x28.png"]];
        logoViewHeight = 72;
    }
    else
    {
        [bottomLogoImageView setImage:nil];
        logoViewHeight = 40;
    }
    
    CGRect logoViewFrame = CGRectMake(logoView.frame.origin.x, logoView.frame.origin.y, logoView.frame.size.width, logoViewHeight);
    
    logoView.frame = logoViewFrame;
     */
}

// To fix floating table view bug
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

- (void) hideKeyboard {
    [self.view endEditing:YES];
    m_LastButtonPressed = nil;  // context menu will close if open, so clear last button
}

- (void) hideLoupe {
    for (UIView *view in [[UIApplication sharedApplication] windows])
    {
        if (strcmp(object_getClassName(view), "UITextEffectsWindow") == 0)
        {
            view.hidden = YES;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   // return [[self.fetchedResultsController fetchedObjects] count] == 0 ? 1 : [[self.fetchedResultsController fetchedObjects] count];
    return [[self.fetchedResultsController fetchedObjects] count];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LtTranslationCell *translationCell;
    
    //LtTranslationData *info = [fetchedResultsController objectAtIndexPath:indexPath];  // cannot use this; controller thinks we're dealing with rows in a single section
    LtTranslationData *info = [self getTranslationDataForIndexPath:indexPath];
    
    translationCell = [table dequeueReusableCellWithIdentifier:@"TranslationCell" forIndexPath:indexPath];
    translationCell.indexPath = indexPath;
    translationCell.textView.scrollEnabled = NO;
    translationCell.textView.scrollsToTop = NO;
    
    // translationCell.frame =CGRectMake(translationCell.frame.origin.x, translationCell.frame.origin.y, tableView.frame.size.width, translationCell.frame.size.height);
    

    if (indexPath.row == 0)
    {
        [self loadTranslationCell:translationCell withLocale:info.text1Locale fromText:info.text1Text];
    }
    else
    {
        [self loadTranslationCell:translationCell withLocale:info.text2Locale fromText:info.text2Text];
    }
    return translationCell;
}

- (void)loadTranslationCell:(LtTranslationCell *)cell withLocale:(NSString *)localeCode fromText:(NSString *)text
{
    LtLocale *locale = [[LtLocale alloc] initWithLocaleCode:localeCode];
    [cell.flagButton setImage:locale.mediumFlag forState:UIControlStateNormal];
    [cell.flagButton setTitle:locale.name forState:UIControlStateNormal];
    cell.localeCode = localeCode;
    //cell.textView.font = [UIFont fontWithName:textViewFont size:textViewFontSize];
    cell.textView.font = [self fontForLocale:localeCode ofSize:textViewFontSize];
    cell.textView.text = text;
    
    /*
    if (!LtOptions.instance.flag)
    {
        cell.flagButton.hidden = YES;
    }
    else
    {
        cell.flagButton.hidden = NO;
    }
    
    if (!LtOptions.instance.microphone || ![LtSupportedLocales.instance.recognitionLocaleCodes containsObject:localeCode] || !LtOptions.instance.voiceRecognition)
    {
        cell.microphoneButton.hidden = YES;
    }
    else
    {
        cell.microphoneButton.hidden = NO;
    }
    
    if (!LtOptions.instance.speaker || ![LtSupportedLocales.instance.vocalizationLocaleCodes containsObject:localeCode] || !LtOptions.instance.sound)
    {
        cell.speakerButton.hidden = YES;
    }
    else
    {
        cell.speakerButton.hidden = NO;
    }
    
    if (!LtOptions.instance.action)
        cell.actionButton.hidden = YES;
    else
        cell.actionButton.hidden = NO;
    
    if (!LtOptions.instance.clear)
        cell.clearButton.hidden = YES;
    else
        cell.clearButton.hidden = NO;
     */
    
    
    NSLayoutConstraint *textTopToCellConstraint;
    for (NSLayoutConstraint *constraint in [cell constraints])
    {
        //NSLog(@"constraint=%@", constraint);
        if (constraint.firstItem == cell.textView && constraint.firstAttribute == NSLayoutAttributeTop && constraint.secondItem == cell && constraint.secondAttribute == NSLayoutAttributeTop)
        {
            textTopToCellConstraint = constraint;
            break;
        }
    }
    
    
//    if (!LtOptions.instance.flag &&
//        !LtOptions.instance.microphone &&
//        !LtOptions.instance.speaker &&
//        !LtOptions.instance.action)
//    {
//        textTopToCellConstraint.constant = 5;
//    }
//    else
//    {
        textTopToCellConstraint.constant = 26;
//    }

}

- (UIFont *)fontForLocale:(NSString *)locale ofSize:(CGFloat)fontSize
{

    if ([locale isEqualToString:@"km-KH"])
    {
        return [UIFont fontWithName:@"Khmer Sangam MN" size:fontSize];
    }
    else
    {
        return [UIFont fontWithName:kTextViewFont size:fontSize];
    }
}

- (NSIndexPath *) getSiblingIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return [NSIndexPath indexPathForRow:1 inSection:indexPath.section];
    }
    else
    {
        return [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
    }
}

- (LtTranslationData *) getTranslationDataForIndexPath:(NSIndexPath *)indexPath
{
    LtTranslationData *info = [[fetchedResultsController fetchedObjects] objectAtIndex:indexPath.section];
    return info;
}

- (NSManagedObjectContext*) managedObjectContext
{
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
    
    managedObjectContext = LtContext.instance.managedObjectContext;
    return managedObjectContext;
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"LtTranslationData" inManagedObjectContext:[self managedObjectContext]];
    [fetchRequest setEntity:entity];
    
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"createdDate" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:[self managedObjectContext] sectionNameKeyPath:nil
                                                   cacheName:@"Root"];
    self.fetchedResultsController = theFetchedResultsController;
    fetchedResultsController.delegate = (id<NSFetchedResultsControllerDelegate>)self;
    
    return fetchedResultsController;
}



#pragma mark Add translation

- (void)addTranslation
{
    LtTranslationData *info = (LtTranslationData *)[NSEntityDescription insertNewObjectForEntityForName:@"LtTranslationData"
                                                                                     inManagedObjectContext:self.managedObjectContext];
    info.text1Locale = @"en-US"; //m_Footer1Locale.localeCode;
    info.text1Text = [[NSMutableString alloc] initWithString:@"text1Text"];
    info.text2Locale = @"zh-CN"; //m_Footer2Locale.localeCode;
    info.text2Text = [[NSMutableString alloc] initWithString:@"text2Text"];
    info.createdDate = [NSDate date];
    m_CurrentTranslation = info;
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Error in adding a new translation %@, %@", error, [error userInfo]);
    }
}


#pragma mark UITextView autosizing

// Precise but slow calculation
- (CGFloat)heightForTextView:(NSString *)text withFont:(UIFont *)font
{
    // Note we have to hardcode in the padding for performance, otherwise might be better to get from the constraints collection
    CGFloat horizontalPadding;
    CGFloat verticalPadding = 14;  // not sure why this isn't 26+5=31, but it works out to 14.
    
    if (SYSTEM_VERSION_LESS_THAN(@"7.0"))
    {
        // seems to be different on iOS 6
        horizontalPadding = 44;
    }
    else
    {
        // not sure why this isn't 10+30=40, but for some reason it works out as 24
        horizontalPadding = 24;
    }
    
    CGFloat textViewWidth = tableView.frame.size.width - horizontalPadding;
    
    [m_LineMetrics updateWithFont:font andWidth:textViewWidth];
    
    //text = [text stringByAppendingString:@"M"];  // Add an "M" width to help with empty new lines
    
    CGSize textSize = [m_LineMetrics UIKitLineSizeForText:text];
    
    CGFloat height = textSize.height + verticalPadding;
    
    NSLog(@"heightForTextView: textViewWidth=%f  textSize.width=%f  height=%f verticalPadding=%f horizontalPadding=%f", textViewWidth, textSize.width, height, verticalPadding, horizontalPadding);
    
    return height;
}

// Approximate but fast calculation, use only when resizing font
- (CGFloat)heightForTextViewFast:(NSString *)text withFont:(UIFont *)font
{
    CGFloat horizontalPadding;
    CGFloat verticalPadding = 32; // Add a bit more with the Fast version to be conservative.
    
    if (SYSTEM_VERSION_LESS_THAN(@"7.0"))
    {
        // seems to be different on iOS 6
        horizontalPadding = 44;
    }
    else
    {
        // not sure why this isn't 10+30=40, but for some reason it works out as 24
        horizontalPadding = 24;
    }
    
    CGFloat textViewWidth = tableView.frame.size.width - horizontalPadding;
    
    //text = [text stringByAppendingString:@"M"];  // Add an "M" width to help with empty new lines
    
    CGFloat height = [text sizeWithFont:font constrainedToSize:CGSizeMake(textViewWidth, 999999.0f) lineBreakMode:NSLineBreakByWordWrapping].height + verticalPadding;
    
    // NSLog(@"heightForTextViewFast: textViewWidth=%f height=%f verticalPadding=%f horizontalPadding=%f", textViewWidth, height, verticalPadding, horizontalPadding);
    
    return height;
}

- (CGFloat) tableView:(UITableView *)theTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath // UITableViewDelegate
{
    NSString *text;
    NSString *localeCode;
    
    LtTranslationData *translation = [[fetchedResultsController fetchedObjects] objectAtIndex:indexPath.section];
    
    if (indexPath.row == 0)
    {
        text = translation.text1Text;
        localeCode = translation.text1Locale;
    }
    else if (indexPath.row == 1)
    {
        text = translation.text2Text;
        localeCode = translation.text2Locale;
    }
    else
    {
        @throw ([NSException exceptionWithName:@"InvalidOperationException" reason:@"Invalid indexPath.row" userInfo:nil]);
    }
    
    UIFont *font = [self fontForLocale:localeCode ofSize:textViewFontSize];
    
    float height;
    
    NSLog(@"heightForRowAtIndexPath textViewHeightFast=%f  textViewHeightSlow=%f", [self heightForTextViewFast:text withFont:font], [self heightForTextView:text withFont:font]);
    
    if (m_IsResizingFont)
    {
        height = [self heightForTextViewFast:text withFont:font];
    }
    else
    {
        height = [self heightForTextView:text withFont:font];
    }
    
//    if (LtOptions.instance.flag ||
//        LtOptions.instance.microphone ||
//        LtOptions.instance.speaker ||
//        LtOptions.instance.action)
    {
        height += 34;
    }
//    else
//    {
//        height += 12;
//    }

    //textViewFontSize = textViewFontSize > kMinFontSize ? textViewFontSize : kMinFontSize;
    //NSInteger minHeight = textViewFontSize + 38;
    //return height > minHeight ? height : minHeight;
    //NSLog(@"row height=%f", height);
    return height;
}

- (CGFloat) tableView:(UITableView *)theTableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath // UITableViewDelegate
{
    return 100.0;
}

- (void) textViewDidChange:(UITextView *)changedTextView // UITextViewDelegate
{
    NSIndexPath* indexPath = [self.tableView indexPathForRowAtPoint:[self.tableView convertPoint:changedTextView.center fromView:changedTextView.superview]];

    if ([[fetchedResultsController fetchedObjects] count] > indexPath.section)
    {
        // Protect against case where user deletes cell while translation is processing.
        @try
        {
            LtTranslationData *translation = [[fetchedResultsController fetchedObjects] objectAtIndex:indexPath.section];
            
            // Setting the text1Text field below triggers the CoreData update and
            // refreshes the tableView.
            if (indexPath.row == 0)
            {
                translation.text1Text = changedTextView.text;
            }
            else
            {
                translation.text2Text = changedTextView.text;
            }
            
            
        }
        @catch (NSException *ex) {
            if (![[ex name] isEqualToString:NSObjectInaccessibleException])
             {
                 @throw;
             }
        }
        
    }
    
    NSLog(@"textViewDidChange textView.width=%f textView.height=%f cellWidth=%f cellHeight=%f parentCellWidth=%f parentCellHeight=%f tableViewWidth=%f", changedTextView.frame.size.width, changedTextView.frame.size.height, changedTextView.superview.frame.size.width, changedTextView.superview.frame.size.height, changedTextView.superview.superview.frame.size.width, changedTextView.superview.superview.frame.size.height, tableView.frame.size.width);
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    m_CurrentTextView = textView;
    m_LastButtonPressed = nil;  // context menu will close if open, so clear last button
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//    BOOL shouldChangeText = YES;
    
    if ([text isEqualToString:@"\n"]) {
        // Find the next entry field
        
//        BOOL isLastField = YES;
//        for (UIView *view in [self entryFields]) {
//            if (view.tag == (textView.tag + 1)) {
//                [view becomeFirstResponder];
//                isLastField = NO;
//                break;
//            }
//        }
//        if (isLastField) {
//            [textView resignFirstResponder];
//        }
        [textView resignFirstResponder];
        m_IsInConversationMode = NO;
        //[self translateInternal:textView withTranslator:nil];
        return NO;
    }
    
    return YES;
}




#pragma mark NSFetchedResultsController delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];  // Important, do not remove
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    //UITableView *tableView = self.tableView;
    // NSUInteger sectionIndex;
    NSIndexSet *indexSet;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            /*
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
             */
            
            indexSet = [NSIndexSet indexSetWithIndex:((newIndexPath.section*2) + newIndexPath.row)];  // Insert at appropriate place.  Note that fetchedResultsController thinks that items are row based, not section based.
//            sectionIndex = [[self.fetchedResultsController fetchedObjects] count];
//            indexSet = [NSIndexSet indexSetWithIndex:(sectionIndex-1)];
            [self.tableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            /*
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
             */
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:(indexPath.row)]  // note that fetched results controller thinks we're working with rows.
                 withRowAnimation:UITableViewRowAnimationFade];
            

            break;
            
        case NSFetchedResultsChangeUpdate:
            //[self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            /*
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
             */
            break;
    }
}


//- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
//    
//    switch(type) {
//            
//        case NSFetchedResultsChangeInsert:
//            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//            
//        case NSFetchedResultsChangeDelete:
//            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//    }
//}



- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];  // Important, do not remove
}


-(void)updateFooterButtons
{
    [self viewWillAppear:NO];
}

#pragma mark Interpret

// Action of the main footer interpret buttons
- (IBAction)interpret:(id)sender
{

    [self interpretInternal:sender];
}

- (void)interpretInternal:(id)sender {
    
    /*
     if (LtOptions.instance.continuous && !m_IsInConversationMode)
     {
     return;
     }
     */
    
//    UIButton *footerButton = (UIButton *)sender;
//    
//    LtTranslationCell *cell;
    
    m_IsInConversationMode = YES;
    
    [self addTranslation];
    
    
    // Need to bring newly added row into view otherwise cell microphone will not exist
    [self scrollToTop];
    

}

- (void)scrollToTop
{
    if (tableView.numberOfSections > 0)
    {
        NSIndexPath *pathToFirstRow = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [tableView scrollToRowAtIndexPath:pathToFirstRow
                         atScrollPosition:UITableViewScrollPositionTop
                                 animated:NO];  // if animated, sometimes does not fully scroll into view.
    }
}

- (void)scrollToBottom
{
    // First figure out how many sections there are
    NSInteger lastSectionIndex = [tableView numberOfSections] - 1;
    
    // Then grab the number of rows in the last section
    NSInteger lastRowIndex = [tableView numberOfRowsInSection:lastSectionIndex] - 1;
    
    // Now just construct the index path
    NSIndexPath *pathToLastRow = [NSIndexPath indexPathForRow:lastRowIndex inSection:lastSectionIndex];
    
    [tableView scrollToRowAtIndexPath:pathToLastRow
                     atScrollPosition:UITableViewScrollPositionBottom
                             animated:NO];  // if animated, sometimes does not fully scroll into view.
}


@end
