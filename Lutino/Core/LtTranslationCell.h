//
//  LtTranslationCell.h
//  LybabTrans
//
//  Created by Spencer on 7/27/13.
//  Copyright (c) 2013 Yeh Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LtTranslationCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIButton *flagButton;
@property (nonatomic, strong) IBOutlet UIButton *microphoneButton;
@property (nonatomic, strong) IBOutlet UIButton *speakerButton;
@property (nonatomic, strong) IBOutlet UIButton *clearButton;
@property (nonatomic, strong) IBOutlet UIButton *actionButton;

//@property (nonatomic, strong) IBOutlet UILabel *localeLabel;
@property (nonatomic, strong) IBOutlet UITextView *textView;

@property (nonatomic, weak) NSString *localeCode;

@property (nonatomic, retain) NSIndexPath *indexPath;

@end
