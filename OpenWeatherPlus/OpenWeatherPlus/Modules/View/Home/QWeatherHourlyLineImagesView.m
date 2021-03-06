//
//  QWeatherHourlyLineImagesView.m
//  OpenWeatherPlus
//
//  Created by he on 2019/4/1.
//  Copyright © 2019 QWeather. All rights reserved.
//

#import "QWeatherHourlyLineImagesView.h"

@implementation QWeatherHourlyLineImagesView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
-(void)reloadViewWithModelArray:(NSArray<Hourly*> *)array{
    NSMutableArray<NSMutableArray<Hourly*>*> *viewDataArray = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(Hourly * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!QWeatherStrEqual(viewDataArray.lastObject.lastObject.text, obj.text)||[self isDaySpaceWithStr:obj.fxTime]!=0) {
            NSMutableArray *modelArray = [NSMutableArray array];
            [modelArray addObject:obj];
            [viewDataArray addObject:modelArray];
        }else{
            [viewDataArray.lastObject addObject:obj];
        }
    }];
    [viewDataArray enumerateObjectsUsingBlock:^(NSMutableArray<Hourly *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        QWeatherHourlyImageView *imageView = [QWeatherHourlyImageView new];
        if ([self isDaySpaceWithStr:obj.firstObject.fxTime]==1) {
            imageView.imageView.image = [QWeatherTool getWeatherImageWithWeatherCode: obj.firstObject.text isDay:NO formatString:QWeatherImageFormatString];
        }else if ([self isDaySpaceWithStr:obj.firstObject.fxTime]==2)
        {
            imageView.imageView.image = [QWeatherTool getWeatherImageWithWeatherCode: obj.firstObject.text isDay:YES formatString:QWeatherImageFormatString];
        }else{
            imageView.imageView.image = [QWeatherTool getWeatherImageWithWeatherCode: obj.firstObject.text date:obj.firstObject.fxTime formatString:QWeatherImageFormatString];
            
        }
        if (idx==viewDataArray.count-1) {
            imageView.progress = obj.count-1;
        }else{
            imageView.progress = obj.count;
        }
        [self addSubview:imageView];
        [self.imageViewArray addObject:imageView];
    }];
    [self.imageViewArray enumerateObjectsUsingBlock:^(QWeatherHourlyImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx==0) {
            obj.frame = CGRectMake(0,0,self.qmui_width/24.0*obj.progress,self.qmui_height);
        }else
        {
            obj.frame = CGRectMake(self.imageViewArray[idx-1].qmui_right, 0,self.qmui_width/24.0*obj.progress,self.qmui_height);
        }
        self.imageViewArray.lastObject.vlineLayer.hidden = YES;
    }];
}
-(NSInteger)isDaySpaceWithStr:(NSString*)str{
    NSInteger  hour = [NSDate dateWithString:str formatString:QWeatherFormatString1].hour;
    if (hour==20) {
        return 1;
    }
    if (hour==8) {
        return 2;
    }
    else{
        return 0;
    }
}
-(NSMutableArray *)imageViewArray{
    if (!_imageViewArray) {
        _imageViewArray = [NSMutableArray array];
    }
    return _imageViewArray;
}
@end
