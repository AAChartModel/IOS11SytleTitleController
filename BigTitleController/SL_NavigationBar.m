//
//  SL_NavigationBar.m
//  BigTitleNavigationController
//
//  Created by admin on 2017/2/21.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "SL_NavigationBar.h"
#import "UIView+SLFrame.h"
#import "UIControl+BlocksKit.h"

@interface SL_NavigationBar (){
    float _originTitleCenterX;
}
@property (nonatomic, strong) UIButton *rightImageBtn;

@end

@implementation SL_NavigationBar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _titleMargin=25;
        _lineMargin=10;
        _lblTitleFontSize=30;
        _lblTitleSmallFontSize=16;
        
        [self addSubview:self.btnBack];
        [self addSubview:self.lblTitle];
        [self addSubview:self.lblSmallTitle];
        [self addSubview:self.lineView];
        
        CGFloat btnWidth=44;
        CGFloat firstY=[UIApplication sharedApplication].statusBarFrame.origin.y + [UIApplication sharedApplication].statusBarFrame.size.height;

        _btnBack.frame=CGRectMake(0, firstY, btnWidth, btnWidth);
        _lblTitle.frame=CGRectMake(self.titleMargin, _btnBack.bottom, frame.size.width-self.titleMargin*2, frame.size.height-_btnBack.bottom);
        
        _lineView.frame=CGRectMake(self.lineMargin, frame.size.height-1, frame.size.width-self.lineMargin, 1);
        
        
    }
    return self;
}

-(void)setTitleMargin:(CGFloat)titleMargin{
    _titleMargin=titleMargin;
    self.lblTitle.left=titleMargin;
    self.lblTitle.width=self.width-titleMargin*2;
}

-(void)setLineMargin:(CGFloat)lineMargin{
    _lineMargin=lineMargin;
    self.lineView.left=lineMargin;
    self.lineView.width=self.width-lineMargin*2;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.lblTitle.bottom=self.height;
    self.lblSmallTitle.height=(self.height-self.lblSmallTitle.top);
    self.lineView.bottom=self.height;
}

-(void)navigationBarAnimationWithScale:(CGFloat)scale{
    switch (_scrollType) {
        case SL_NavigationBarScrollType_Scale:{
            CGRect navigationFrame = self.frame;
            navigationFrame.origin.y=(NavigationBarNormalHeight-(44.+ScreenStatusBottom))*(scale);
            navigationFrame.size.height=NavigationBarNormalHeight-(NavigationBarNormalHeight-(44.+ScreenStatusBottom))*(scale);
            self.frame=navigationFrame;
            
            self.lblTitle.font=[UIFont systemFontOfSize:_lblTitleFontSize-(_lblTitleFontSize-_lblTitleSmallFontSize)*scale];
            [self.lblTitle sizeToFit];
            

            float lblTitleHeight=NavigationBarNormalHeight-self.btnBack.bottom;
            
            self.lblTitle.height=lblTitleHeight-(lblTitleHeight-self.btnBack.height)*scale;

        }
            break;
        case SL_NavigationBarScrollType_ScaleToCenter:{
            CGRect navigationFrame = self.frame;
            navigationFrame.origin.y=(NavigationBarNormalHeight-(44.+ScreenStatusBottom))*(scale);
            navigationFrame.size.height=NavigationBarNormalHeight-(NavigationBarNormalHeight-(44.+ScreenStatusBottom))*(scale);
            self.frame=navigationFrame;
            
            self.lblTitle.font=[UIFont systemFontOfSize:_lblTitleFontSize-(_lblTitleFontSize-_lblTitleSmallFontSize)*scale];
            [self.lblTitle sizeToFit];
            
            float lblTitleHeight=NavigationBarNormalHeight-self.btnBack.bottom;
            
            self.lblTitle.height=lblTitleHeight-(lblTitleHeight-self.btnBack.height)*scale;
            
            self.lblTitle.centerX=_originTitleCenterX+(self.centerX-_originTitleCenterX)*scale;
        }
            break;
        case SL_NavigationBarScrollType_CenterScale:{
            CGRect navigationFrame = self.frame;
            navigationFrame.origin.y=(NavigationBarNormalHeight-(44.+ScreenStatusBottom))*(scale);
            navigationFrame.size.height=NavigationBarNormalHeight-(NavigationBarNormalHeight-(44.+ScreenStatusBottom))*(scale);
            self.frame=navigationFrame;
            
            self.lblTitle.font=[UIFont systemFontOfSize:_lblTitleFontSize-(_lblTitleFontSize-_lblTitleSmallFontSize)*scale];
            [self.lblTitle sizeToFit];
            
            float lblTitleHeight=NavigationBarNormalHeight-self.btnBack.bottom;
            
            self.lblTitle.height=lblTitleHeight-(lblTitleHeight-self.btnBack.height)*scale;
            
            self.lblTitle.centerX=self.centerX;
        }
            break;

        default:{
            CGRect navigationFrame = self.frame;
            navigationFrame.origin.y=(NavigationBarNormalHeight-(44.+ScreenStatusBottom))*(scale);
            navigationFrame.size.height=NavigationBarNormalHeight-(NavigationBarNormalHeight-(44.+ScreenStatusBottom))*(scale);
            self.frame=navigationFrame;
            
            self.lblTitle.alpha=1-scale*2;
            self.lblSmallTitle.alpha=1-(1-scale)*2;

        }            
            break;
    }
    CGRect navigationFrame = self.frame;
    navigationFrame.origin.y=(NavigationBarNormalHeight-(44.+ScreenStatusBottom))*(scale);
    navigationFrame.size.height=NavigationBarNormalHeight-(NavigationBarNormalHeight-(44.+ScreenStatusBottom))*(scale);
    self.frame=navigationFrame;
    
    self.lblTitle.font=[UIFont systemFontOfSize:_lblTitleFontSize-(_lblTitleFontSize-_lblTitleSmallFontSize)*scale];
    [self.lblTitle sizeToFit];
    
    
    float lblTitleHeight=NavigationBarNormalHeight-self.btnBack.bottom;
    
    self.lblTitle.height=lblTitleHeight-(lblTitleHeight-self.btnBack.height)*scale;
    
    
    
    
    
    
    
    
    self.rightImageBtn.alpha = 1-scale*2;
    CGFloat rightImageWidth = lblTitleHeight-(lblTitleHeight-self.btnBack.height)*scale;
    self.rightImageBtn.height = rightImageWidth;
    self.rightImageBtn.width = rightImageWidth;

    //    CGAffineTransform transform = self.rightImageView.transform;
//   transform = CGAffineTransformScale(transform, 1-scale*2,1-scale*2);//前面的2表示横向放大2倍，后边的0.5表示纵向缩小一半
//    self.rightImageView.transform = transform;
    


    
}

-(UILabel *)lblSmallTitle{
    if (_lblSmallTitle==nil) {
        _lblSmallTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, ScreenStatusBottom, self.frame.size.width, self.frame.size.height)];
        _lblSmallTitle.font=[UIFont systemFontOfSize:_lblTitleSmallFontSize];
        _lblSmallTitle.alpha=0;
        _lblSmallTitle.textColor=[UIColor blackColor];
        _lblSmallTitle.textAlignment=NSTextAlignmentCenter;
    }
    return _lblSmallTitle;
}

-(UILabel*)lblTitle{
    if (_lblTitle==nil) {
        _lblTitle=[[UILabel alloc] initWithFrame:CGRectZero];
        _lblTitle.textAlignment=NSTextAlignmentLeft;
        _lblTitle.font=[UIFont systemFontOfSize:_lblTitleFontSize];
        _lblSmallTitle.textColor=[UIColor blackColor];
    }
    return _lblTitle;
}

-(UIView *)lineView{
    if (_lineView==nil) {
        _lineView=[[UIView alloc] init];
        _lineView.backgroundColor=[UIColor lightGrayColor];
    }
    return _lineView;
}

-(UIButton *)btnBack{
    if (_btnBack==nil) {
        _btnBack=[UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _btnBack;
}

-(void)setTitle:(NSString *)title{
    _title=title;
    
    CGFloat height=self.lblTitle.height;
    self.lblTitle.text = title;
    self.lblSmallTitle.text = title;
    
    [self.lblTitle sizeToFit];
    self.lblTitle.height=height;
    
    _originTitleCenterX=self.lblTitle.centerX;
    
    if (self.height<=(44+ScreenStatusBottom)) {
        self.lblTitle.height=(self.height-self.btnBack.top);
    }
    else{
        self.lblTitle.height=(self.height-self.btnBack.bottom);
    }

}

-(void)setLblTitleFontSize:(CGFloat)lblTitleFontSize{
    _lblTitleFontSize=lblTitleFontSize;
    self.lblTitle.font=[UIFont systemFontOfSize:lblTitleFontSize];
}

-(void)setLblTitleSmallFontSize:(CGFloat)lblTitleSmallFontSize{
    _lblTitleSmallFontSize=lblTitleSmallFontSize;
    self.lblSmallTitle.font=[UIFont systemFontOfSize:lblTitleSmallFontSize];
}

-(void)setScrollType:(SL_NavigationBarScrollType)scrollType{
    _scrollType=scrollType;
    if (_scrollType==SL_NavigationBarScrollType_CenterScale) {
        self.lblTitle.centerX=self.centerX;
    }
}

- (void)setRightImage:(UIImage *)rightImage {
    _rightImage = rightImage;
    
    UIButton *rightImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat imageWidth = self.frame.size.height-_btnBack.bottom;
    
    rightImageBtn.frame = CGRectMake(self.frame.size.width - self.titleMargin - imageWidth, _btnBack.bottom, imageWidth,imageWidth);
    [self addSubview:rightImageBtn];
    [rightImageBtn setImage:_rightImage forState:UIControlStateNormal];
    self.rightImageBtn = rightImageBtn;
 
 
}

- (void)rightImageAddDidTapEventHandler:(void(^)(id sender))handler {
    [self.rightImageBtn bk_addEventHandler:handler forControlEvents:UIControlEventTouchUpInside];
}



@end
