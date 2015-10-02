//
//  CLInterestCollectionViewCell.m
//  Cooleaf
//
//  Created by Haider Khan on 10/1/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import "CLInterestCollectionViewCell.h"
#import "FXBlurView.h"

static UIImage *gCheckboxOn;
static UIImage *gCheckboxOff;

@interface CLInterestCollectionViewCell() {
    FXBlurView *_blurView;
    NSLayoutConstraint *_lblConstraint;
}

@end

@implementation CLInterestCollectionViewCell

+ (void)load {
    gCheckboxOn = [UIImage imageNamed:@"CheckboxChecked"];
    gCheckboxOff = [UIImage imageNamed:@"CheckboxUnchecked"];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self render];
    }
    return self;
}

- (void)render {
    
    // interest image
    _imageView = [[UIImageView alloc] init];
    _imageView.translatesAutoresizingMaskIntoConstraints = FALSE;
    _imageView.userInteractionEnabled = TRUE;
    [_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doActionToggleActive:)]];
    [self.contentView addSubview:_imageView];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeTop    relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop   multiplier:1 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeLeft   relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft  multiplier:1 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeRight  relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_imageView       attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    
    // blur view
    _blurView = [[FXBlurView alloc] init];
    _blurView.backgroundColor = [UIColor clearColor];
    _blurView.tintColor = [UIColor blackColor];
    _blurView.alpha = 0.7;
    _blurView.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self.contentView addSubview:_blurView];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_blurView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_blurView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_blurView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_blurView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:40]];
    
    // interest enabled -- in the footer, visible when the cell is in edit mode
    _checkboxImg = [[UIImageView alloc] init];
    _checkboxImg.translatesAutoresizingMaskIntoConstraints = FALSE;
    _checkboxImg.userInteractionEnabled = TRUE;
    [_checkboxImg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doActionToggleActive:)]];
    [_blurView addSubview:_checkboxImg];
    [_blurView addConstraint:[NSLayoutConstraint constraintWithItem:_checkboxImg attribute:NSLayoutAttributeLeft    relatedBy:NSLayoutRelationEqual toItem:_blurView attribute:NSLayoutAttributeLeft           multiplier:1 constant:10]];
    [_blurView addConstraint:[NSLayoutConstraint constraintWithItem:_checkboxImg attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_blurView attribute:NSLayoutAttributeCenterY        multiplier:1 constant: 0]];
    [_blurView addConstraint:[NSLayoutConstraint constraintWithItem:_checkboxImg attribute:NSLayoutAttributeWidth   relatedBy:NSLayoutRelationEqual toItem:nil         attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:20]];
    [_blurView addConstraint:[NSLayoutConstraint constraintWithItem:_checkboxImg attribute:NSLayoutAttributeHeight  relatedBy:NSLayoutRelationEqual toItem:nil         attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:20]];
    
    // interest title -- in the footer
    _titleLbl = [[UILabel alloc] init];
    _titleLbl.translatesAutoresizingMaskIntoConstraints = FALSE;
    _titleLbl.textAlignment = NSTextAlignmentLeft;
    _titleLbl.textColor = UIColor.whiteColor;
    _titleLbl.font = [UIFont systemFontOfSize:12.0];
    [_blurView addSubview:_titleLbl];
    _lblConstraint = [[NSLayoutConstraint alloc] init];
    _lblConstraint = [NSLayoutConstraint constraintWithItem:_titleLbl attribute:NSLayoutAttributeLeft    relatedBy:NSLayoutRelationEqual toItem:_blurView attribute:NSLayoutAttributeLeft    multiplier:1 constant: 10];
    [_blurView addConstraint:_lblConstraint];
    [_blurView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLbl attribute:NSLayoutAttributeLeft    relatedBy:NSLayoutRelationEqual toItem:_checkboxImg attribute:NSLayoutAttributeLeft    multiplier:1 constant: 20]];
    [_blurView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLbl attribute:NSLayoutAttributeRight   relatedBy:NSLayoutRelationEqual toItem:_blurView attribute:NSLayoutAttributeRight   multiplier:1 constant:-10]];
    [_blurView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLbl attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_blurView attribute:NSLayoutAttributeCenterY multiplier:1 constant:  0]];
}

- (void)setEditModeOn:(BOOL)editModeOn {
    if (editModeOn) {
        _checkboxImg.hidden = FALSE;
        _checkboxImg.image = _interest.member ? gCheckboxOn : gCheckboxOff;
        _titleLbl.textAlignment = NSTextAlignmentLeft;
        _lblConstraint.constant = 33;
        [_blurView layoutIfNeeded];
        [_titleLbl layoutIfNeeded];
    } else {
        _checkboxImg.hidden = TRUE;
        _titleLbl.textAlignment = NSTextAlignmentLeft;
        _lblConstraint.constant = 10;
        [_blurView layoutIfNeeded];
        [_titleLbl layoutIfNeeded];
    }
}

- (void)toggleCheckBox:(BOOL)isMember {
    _checkboxImg.image = isMember ? gCheckboxOn : gCheckboxOff;
}

- (void)doActionToggleActive:(id)sender {
    _interest.member = !_interest.member;
    _checkboxImg.image = _interest.member ? gCheckboxOn : gCheckboxOff;
}

@end
