//
//  LtLanguageCell.h
//  LybabTrans
//
//  Created by Spencer on 8/5/13.
//  Copyright (c) 2013 Yeh Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LtLocaleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *flagImage;

@property (weak, nonatomic) IBOutlet UIImageView *microphoneImage;

@property (weak, nonatomic) IBOutlet UIImageView *speakerImage;

@end
