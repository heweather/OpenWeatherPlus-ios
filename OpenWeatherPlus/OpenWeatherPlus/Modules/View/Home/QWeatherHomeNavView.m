//
//  QWeatherHomeNavView.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 QWeather. All rights reserved.
//

#import "QWeatherHomeNavView.h"

@implementation QWeatherHomeNavView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.menuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(StatusBarHeight+6);
        make.right.equalTo(-16);
    }];
    [self.locationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Space_16);
        make.centerY.equalTo(self.menuButton);
        make.height.equalTo(@[self.locationButton,self.locationAddButton]);
    }];
    
    [self.locationTitleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.locationButton.mas_right).offset(8);
        make.centerY.equalTo(self.menuButton);
    }];
    [self.locationAddButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.menuButton);
        make.left.equalTo(self.locationTitleButton.mas_right).offset(8);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.locationButton.mas_bottom).offset(8);
        make.left.equalTo(self.locationTitleButton).offset(2);
        make.height.equalTo(4);
    }];
}
-(void)configUI{
    self.userInteractionEnabled = YES;
    self.menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.menuButton setImage:UIImageMake(@"hefeng_menu") forState:UIControlStateNormal];
    [self addSubview:self.menuButton];
    
    self.locationButton = [UIButton new];
    [self.locationButton setImage:UIImageMake(@"hefeng_location") forState:UIControlStateNormal];
    [self addSubview:self.locationButton];
    
    self.locationTitleButton = [QWeatherBaseButton new];
    self.locationTitleButton.hefengFontSize = QWeatherFontSize_16;
    [self.locationTitleButton setTitleColor:QWeatherColor_FFFFFF forState:UIControlStateNormal];
    [self addSubview:self.locationTitleButton];
    self.locationAddButton = [UIButton new];
    [self.locationAddButton setImage:UIImageMake(@"hefeng_add") forState:UIControlStateNormal];
    [self addSubview:self.locationAddButton];
    
    
    self.pageControl = [UIPageControl new];
    self.pageControl.pageIndicatorTintColor = QWeatherColor_CCCCCC;
    self.pageControl.currentPageIndicatorTintColor = QWeatherColor_FAFAFA;
    [self addSubview:self.pageControl];
    
}
-(void)setPage:(NSInteger)page{
    self.pageControl.numberOfPages = QWeatherManager.collectionDataArray.count;
    self.pageControl.currentPage = page;
    self.locationButton.hidden = self.pageControl.currentPage!=0;
    if (QWeatherManager.collectionDataArray.count>page) {
        [self.locationTitleButton setTitle:QWeatherManager.collectionDataArray[page].basic.name forState:UIControlStateNormal];
        self.image = [[[QWeatherTool getWeatherImageWithWeatherCode:QWeatherManager.collectionDataArray[page].now.icon date:QWeatherManager.collectionDataArray[page].updateTime formatString:QWeatherBgImageFormatString] qmui_imageResizedInLimitedSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-160-NavigationContentTop) resizingMode:QMUIImageResizingModeScaleAspectFill scale:ScreenScale] qmui_imageResizedInLimitedSize:CGSizeMake(SCREEN_WIDTH, 1) resizingMode:QMUIImageResizingModeScaleAspectFillTop];
       
    }
}

@end
