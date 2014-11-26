//
//  LtTranslationCell.m
//  LybabTrans
//
//  Created by Spencer on 7/27/13.
//  Copyright (c) 2013 Yeh Technology. All rights reserved.
//

#import "LtTranslationCell.h"

#import "LtTextViewController.h"

@implementation LtTranslationCell

@synthesize flagButton;
@synthesize microphoneButton;
@synthesize speakerButton;
@synthesize clearButton;

//@synthesize localeLabel;

@synthesize textView;

@synthesize localeCode;

@synthesize indexPath;

//@synthesize text;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// Narrower side borders of cell.
- (void)setFrame:(CGRect)frame {
    frame.origin.x -= 8;
    frame.size.width += 2 * 8;
    [super setFrame:frame];
}

//HACK to fix bug of Delete button being behind other objects
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (UIView *subview in self.subviews) {
        
        for (UIView *subview2 in subview.subviews) {
            
            if ([NSStringFromClass([subview2 class]) isEqualToString:@"UITableViewCellDeleteConfirmationView"])
            { // move delete confirmation view
                [subview bringSubviewToFront:subview2];
                break;
            }
        }
    }
}


@end
