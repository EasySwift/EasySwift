//
//  LeftMenuViewController.m
//  test123
//
//  Created by kf1 on 14-9-16.
//  Copyright (c) 2014年 kf1. All rights reserved.
//

#import "FLSideSlipViewController.h"

@interface FLSideSlipViewController ()<UIGestureRecognizerDelegate>

@end

static const CGFloat min_Alpha = 0.2f;/**< 背景最小的透明度*/
static const CGFloat defaultLeftDistance = 160.0f;/**< 默认离左边的距离*/
static const CGFloat defaultScale = 0.85;/**< 默认缩小范围*/

@implementation FLSideSlipViewController{
    UIImageView *g_backGroundImage;
}

#pragma mark - UIViewController life cycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _leftDistance = defaultLeftDistance;
        _scaleSize = defaultScale;
        _animationType = AnimationTransitionAndScaleAndIncline;
    }
    return self;
}

-(id)initWithRootViewController:(UIViewController *)viewController{
    if ((self = [super init])) {
        self.rootViewController = viewController;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    g_backGroundImage = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [g_backGroundImage setImage:[UIImage imageNamed:@"backGroundImage"]];
    [g_backGroundImage setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    g_backGroundImage.alpha = min_Alpha;
    [self.view insertSubview:g_backGroundImage atIndex:0];
    g_overView = [[UIView alloc]initWithFrame:self.view.frame];
    [g_overView setBackgroundColor:[UIColor clearColor]];
}

#pragma mark - Custom Delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (_canSlideInPush) {
        return YES;
    }
    if (_rootViewController.childViewControllers.count == 1 && !_canSlideInPush) {
        return YES;
    }
    return NO;
}

#pragma mark - event response
/**
 *  单击返回主界面
 */
-(void)tapInRootController{
    [self showRootViewController:YES];
}

/**
 *  滑动事件
 */
-(void)pan:(UIPanGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [self showShadow:YES];
        [_rootViewController.view setNeedsDisplay];
        g_currentTranslateX = _rootViewController.view.frame.origin.x;
        if (g_menuFlags.showingRightView) {//解决右边返回的时候动画跳变问题
            g_currentTranslateX = -_leftDistance;
        }else if(g_menuFlags.showingLeftView){//解决左边返回的时候动画跳变问题
            g_currentTranslateX = _leftDistance;
        }
    }else if(gesture.state == UIGestureRecognizerStateChanged){
        CGPoint velocity = [gesture velocityInView:self.view];//滑动速度
        CGPoint translation = [gesture translationInView:_rootViewController.view];//滑动距离
        CGFloat transX = translation.x;
        transX = transX + g_currentTranslateX;
        CGFloat transleft = (-_leftDistance + transX) < 0 ? (-_leftDistance + transX) : 0;
        if (velocity.x > 0) {
            g_panDirection = LeftMenuPanDirectionRight;
        }else if(velocity.x < 0){
            g_panDirection = LeftMenuPanDirectionLeft;
        }
        CGFloat sca = 0;//缩放值
        CGFloat scaleft = 0;//左视图缩放值
        if (transX > 0 && g_menuFlags.canShowLeft) {
            _leftViewController.view.alpha = (transX / _leftDistance);
            g_backGroundImage.alpha = (transX / _leftDistance);
            if (g_menuFlags.canShowRight) {
                g_menuFlags.showingRightView = NO;
                [_rightViewController.view removeFromSuperview];
            }
            
            if (!g_menuFlags.showingLeftView) {
                g_menuFlags.showingLeftView = YES;
                CGRect leftFrame = self.view.bounds;
                CGAffineTransform oriT = CGAffineTransformIdentity;
                _leftViewController.view.transform = oriT;//先将leftviewcontroller的view置回原来的大小，否则再缩小的时候位置会改变
                _leftViewController.view.frame = leftFrame;
                [self.view insertSubview:_leftViewController.view atIndex:1];
                CGAffineTransform transRight = CGAffineTransformMakeTranslation(-_leftDistance, 0);
                CGAffineTransform transScale = CGAffineTransformMakeScale(_scaleSize, _scaleSize);
                CGAffineTransform transConcat = CGAffineTransformConcat(transRight, transScale);
                _leftViewController.view.transform = transConcat;
            }
            if (transX < _leftDistance) {
                sca = 1 - (transX / _leftDistance) * (1 - _scaleSize);
                scaleft = (1 - _scaleSize) * (transX / _leftDistance) + _scaleSize;
            } else {
                sca = _scaleSize;
                scaleft = 1;
            }
            CGAffineTransform transSl = CGAffineTransformMakeScale(scaleft, scaleft);
            CGAffineTransform transTl = CGAffineTransformMakeTranslation(transleft, 0);
            CGAffineTransform conTleft = CGAffineTransformConcat(transTl, transSl);
            _leftViewController.view.transform = conTleft;
        }else if(transX < 0 && g_menuFlags.canShowRight){
            _rightViewController.view.alpha = (-transX / _leftDistance);
            g_backGroundImage.alpha = (-transX / _leftDistance);
            if (g_menuFlags.canShowLeft) {
                g_menuFlags.showingLeftView = NO;
                [_leftViewController.view removeFromSuperview];
            }
            if (!g_menuFlags.showingRightView) {
                g_menuFlags.showingRightView = YES;
                CGRect rightFrame = self.view.bounds;
                _rightViewController.view.frame = rightFrame;
                [self.view insertSubview:_rightViewController.view atIndex:1];
            }
            if (transX > (-_leftDistance)) {
                sca = 1 - (-transX / _leftDistance) * (1 - _scaleSize);
            }else{
                sca = _scaleSize;
            }
        }else{
            g_menuFlags.showingLeftView = NO;
            g_menuFlags.showingRightView = NO;
            CGAffineTransform transIdentify = CGAffineTransformIdentity;
            _rootViewController.view.transform = transIdentify;
            return;
        }
        switch (_animationType) {
            case AnimationTransition: {
                CGAffineTransform transT = CGAffineTransformMakeTranslation(transX, 0);
                _rootViewController.view.transform = transT;
                break;
            }
            case AnimationTransitionAndScale: {
                CGAffineTransform transS = CGAffineTransformMakeScale(sca, sca);
                CGAffineTransform transT = CGAffineTransformMakeTranslation(transX, 0);
                CGAffineTransform conT = CGAffineTransformConcat(transT, transS);
                _rootViewController.view.transform = conT;
                break;
            }
            case AnimationTransitionAndScaleAndIncline: {
                CATransform3D transform = CATransform3DIdentity;
                transform.m34 = 1.0 / -600;//透视效果，要操作的这个对象要有旋转的角度，否则没有效果。正直/负值都有意义
                transform.m11 = sca;//x轴缩放
                transform.m22 = sca;//y轴缩放
                transform.m41 = transX;//平移
                CGFloat angle =  30.0f * M_PI / 180.0f * (transX / self.view.frame.size.width);//旋转角度
                transform = CATransform3DRotate(transform, angle , 0.0f, 1.0f, 0.0f);//Y轴方向旋转angle角度
                _rootViewController.view.layer.transform = transform;
                _rootViewController.view.layer.shouldRasterize = YES;//抗锯齿
                [_rootViewController.view.layer setRasterizationScale:[[UIScreen mainScreen] scale]];
                break;
            }
            default: {
                CGAffineTransform transT = CGAffineTransformMakeTranslation(transX, 0);
                _rootViewController.view.transform = transT;
                break;
            }
        }
    }else if(gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled){
        CGPoint velocity = [gesture velocityInView:self.view];
        if (velocity.x > 0 && !g_menuFlags.showingRightView && g_menuFlags.canShowLeft) {
            if (!g_menuFlags.showingLeftView) {
                g_menuFlags.showingLeftView = YES;
                CGRect leftFrame = self.view.bounds;
                CGAffineTransform oriT = CGAffineTransformIdentity;
                _leftViewController.view.transform = oriT;//先将leftviewcontroller的view置回原来的大小，否则再缩小的时候位置会改变
                _leftViewController.view.frame = leftFrame;
                [self.view insertSubview:_leftViewController.view atIndex:1];
                CGAffineTransform transRight = CGAffineTransformMakeTranslation(-_leftDistance, 0);
                CGAffineTransform transScale = CGAffineTransformMakeScale(_scaleSize, _scaleSize);
                CGAffineTransform transConcat = CGAffineTransformConcat(transRight, transScale);
                _leftViewController.view.transform = transConcat;
            }
            g_menuFlags.showingRightView = NO;
            [g_tap setEnabled:YES];
            [UIView beginAnimations:Nil context:nil];
            [UIView setAnimationDuration:0.3];
            switch (_animationType) {
                case AnimationTransition: {
                    CGAffineTransform conT = [self getCGAffineTransform];
                    _rootViewController.view.transform = conT;
                    break;
                }
                case AnimationTransitionAndScale: {
                    CGAffineTransform conT = [self getCGAffineTransform];
                    _rootViewController.view.transform = conT;
                    break;
                }
                case AnimationTransitionAndScaleAndIncline: {
                    CATransform3D transform = [self getCATransform3D];
                    _rootViewController.view.layer.transform = transform;
                    break;
                }
                default: {
                    CGAffineTransform conT = [self getCGAffineTransform];
                    _rootViewController.view.transform = conT;
                    break;
                }
            }
            CGAffineTransform oriT = CGAffineTransformIdentity;
            _leftViewController.view.transform = oriT;
            _leftViewController.view.alpha = 1;
            g_backGroundImage.alpha = 1;
            [UIView commitAnimations];
            [_rootViewController.view addSubview:g_overView];
            
            return;
        }
        if (velocity.x < 0 && !g_menuFlags.showingLeftView && g_menuFlags.canShowRight) {
            
            g_menuFlags.showingLeftView = NO;
            g_menuFlags.showingRightView = YES;
            [g_tap setEnabled:YES];
            [UIView beginAnimations:Nil context:nil];
            [UIView setAnimationDuration:0.3];
            switch (_animationType) {
                case AnimationTransition: {
                    CGAffineTransform conT = [self getCGAffineTransform];
                    _rootViewController.view.transform = conT;
                    break;
                }
                case AnimationTransitionAndScale: {
                    CGAffineTransform conT = [self getCGAffineTransform];
                    _rootViewController.view.transform = conT;
                    break;
                }
                case AnimationTransitionAndScaleAndIncline: {
                    CATransform3D transform = [self getCATransform3D];
                    _rootViewController.view.layer.transform = transform;
                    break;
                }
                default: {
                    CGAffineTransform conT = [self getCGAffineTransform];
                    _rootViewController.view.transform = conT;
                    break;
                }
            }
            _rightViewController.view.alpha = 1;
            g_backGroundImage.alpha = 1;
            [UIView commitAnimations];
            [_rootViewController.view addSubview:g_overView];
            return;
        } else {
            _rootViewController.view.layer.shouldRasterize = NO;//取消抗锯齿
            CGAffineTransform oriT = CGAffineTransformIdentity;
            CGAffineTransform transRight = CGAffineTransformMakeTranslation(-_leftDistance, 0);
            CGAffineTransform transScale = CGAffineTransformMakeScale(_scaleSize, _scaleSize);
            CGAffineTransform transConcat = CGAffineTransformConcat(transRight, transScale);
            
            [UIView animateWithDuration:.3 animations:^{
                _rootViewController.view.transform = oriT;
                if (velocity.x < 0 && g_menuFlags.showingLeftView) {
                    _leftViewController.view.transform = transConcat;
                }
                _leftViewController.view.alpha = min_Alpha;
                _rightViewController.view.alpha = min_Alpha;
                g_backGroundImage.alpha = min_Alpha;
            }completion:^(BOOL success){
                [self showShadow:NO];
                g_menuFlags.showingLeftView = NO;
                g_menuFlags.showingRightView = NO;
                [g_overView removeFromSuperview];
                if (_leftViewController) {
                    [_leftViewController.view removeFromSuperview];
                }
                if (_rightViewController) {
                    [_rightViewController.view removeFromSuperview];
                }
            }];
        }
    }
}

/**
 *  左上角按钮点击事件
 */
-(void)showLeftViewController{
    if (g_menuFlags.canShowRight) {
        [_rightViewController.view removeFromSuperview];
    }
    //    [self.view setBackgroundColor:[UIColor greenColor]];
    g_menuFlags.showingLeftView = YES;
    g_menuFlags.showingRightView = NO;
    CGAffineTransform oriT = CGAffineTransformIdentity;
    _leftViewController.view.transform = oriT;
    CGRect leftFrame = self.view.bounds;
    _leftViewController.view.frame = leftFrame;
    [self.view insertSubview:_leftViewController.view atIndex:1];
    
    CGAffineTransform transRight = CGAffineTransformMakeTranslation(-_leftDistance, 0);
    CGAffineTransform transScale = CGAffineTransformMakeScale(_scaleSize, _scaleSize);
    CGAffineTransform transConcat = CGAffineTransformConcat(transRight, transScale);
    _leftViewController.view.transform = transConcat;
    [self showShadow:YES];
    [g_tap setEnabled:YES];
    g_panDirection = LeftMenuPanDirectionRight;
    [UIView beginAnimations:Nil context:nil];
    [UIView setAnimationDuration:.3];
    switch (_animationType) {
        case AnimationTransition: {
            CGAffineTransform conT = [self getCGAffineTransform];
            _rootViewController.view.transform = conT;
            break;
        }
        case AnimationTransitionAndScale: {
            CGAffineTransform conT = [self getCGAffineTransform];
            _rootViewController.view.transform = conT;
            break;
        }
        case AnimationTransitionAndScaleAndIncline: {
            CATransform3D transform = [self getCATransform3D];
            _rootViewController.view.layer.transform = transform;
            _rootViewController.view.layer.shouldRasterize = YES;//抗锯齿
            [_rootViewController.view.layer setRasterizationScale:[[UIScreen mainScreen] scale]];
            break;
        }
        default: {
            CGAffineTransform conT = [self getCGAffineTransform];
            _rootViewController.view.transform = conT;
            break;
        }
    }
    _leftViewController.view.transform = oriT;
    _leftViewController.view.alpha = 1;
    g_backGroundImage.alpha = 1;
    [UIView commitAnimations];
    [_rootViewController.view addSubview:g_overView];
}

/**
 *  右上角按钮点击事件
 */
-(void)showRightViewController{
    if (g_menuFlags.canShowLeft) {
        [_leftViewController.view removeFromSuperview];
    }
    g_menuFlags.showingRightView = YES;
    g_menuFlags.showingLeftView = NO;
    CGRect rightFrame = self.view.bounds;
    _rightViewController.view.frame = rightFrame;
    [self.view insertSubview:_rightViewController.view atIndex:1];
    [self showShadow:YES];
    [g_tap setEnabled:YES];
    g_panDirection = LeftMenuPanDirectionLeft;
    [UIView beginAnimations:Nil context:nil];
    [UIView setAnimationDuration:0.3];
    switch (_animationType) {
        case AnimationTransition: {
            CGAffineTransform conT = [self getCGAffineTransform];
            _rootViewController.view.transform = conT;
            break;
        }
        case AnimationTransitionAndScale: {
            CGAffineTransform conT = [self getCGAffineTransform];
            _rootViewController.view.transform = conT;
            break;
        }
        case AnimationTransitionAndScaleAndIncline: {
            CATransform3D transform = [self getCATransform3D];
            _rootViewController.view.layer.transform = transform;
            _rootViewController.view.layer.shouldRasterize = YES;//抗锯齿
            [_rootViewController.view.layer setRasterizationScale:[[UIScreen mainScreen] scale]];
            break;
        }
        default: {
            CGAffineTransform conT = [self getCGAffineTransform];
            _rootViewController.view.transform = conT;
            break;
        }
    }
    _rightViewController.view.alpha = 1;
    g_backGroundImage.alpha = 1;
    [UIView commitAnimations];
    [_rootViewController.view addSubview:g_overView];
}

/**
 *  主界面点击事件，返回到主界面
 */
-(void)showRootViewController:(BOOL)animation{
    [UIView setAnimationsEnabled:animation];
    g_menuFlags.showingLeftView = NO;
    g_menuFlags.showingRightView = NO;
    [g_tap setEnabled:NO];
    CGAffineTransform oriT = CGAffineTransformIdentity;
    CGAffineTransform transRight = CGAffineTransformMakeTranslation(-_leftDistance, 0);
    CGAffineTransform transScale = CGAffineTransformMakeScale(_scaleSize, _scaleSize);
    CGAffineTransform transConcat = CGAffineTransformConcat(transRight, transScale);
    
    [UIView animateWithDuration:.3 animations:^{
        _rootViewController.view.transform = oriT;
        _leftViewController.view.transform = transConcat;
        _rootViewController.view.layer.shouldRasterize = NO;//取消抗锯齿
        _leftViewController.view.alpha = min_Alpha;
        _rightViewController.view.alpha = min_Alpha;
        g_backGroundImage.alpha = min_Alpha;
    }completion:^(BOOL success){
        [g_overView removeFromSuperview];
        [self showShadow:NO];
        [UIView setAnimationsEnabled:YES];
    }];
}

/**
 *  侧边栏菜单点击事件
 *
 *  @param viewController 新的rootviewcontroller
 *  @param animation      是否支持动画
 */
-(void)setNewRootViewController:(UIViewController *)viewController animation:(BOOL)animation{
    if (!viewController) {
        [self showRootViewController:animation];
        return;
    }
    if (g_menuFlags.showingLeftView) {
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        CGAffineTransform transRight = CGAffineTransformMakeTranslation(self.view.bounds.size.width, 0);
        CGAffineTransform transScale = CGAffineTransformMakeScale(_scaleSize, _scaleSize);
        CGAffineTransform transConcat = CGAffineTransformConcat(transRight, transScale);
        __block FLSideSlipViewController *selfRef = self;
        __block UIViewController *viewRef = viewController;
        CGRect rightFrame = _rootViewController.view.frame;
        rightFrame.origin.x = self.view.frame.size.width;
        [UIView animateWithDuration:.1 animations:^{
            _rootViewController.view.transform = transConcat;
        }completion:^(BOOL success){
            [selfRef setRootViewController:viewRef];
            _rootViewController.view.transform = transConcat;
            [self showShadow:YES];
            [selfRef showRootViewController:animation];
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }];
    }else if(g_menuFlags.showingRightView){
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        CGAffineTransform transLeft = CGAffineTransformMakeTranslation(-self.view.frame.size.width, 0);
        CGAffineTransform transScale = CGAffineTransformMakeScale(_scaleSize, _scaleSize);
        CGAffineTransform transConcat = CGAffineTransformConcat(transLeft, transScale);
        __block FLSideSlipViewController *selfRef = self;
        __block UIViewController *viewRef = viewController;
        CGRect leftFrame = _rootViewController.view.frame;
        leftFrame.origin.x = -self.view.frame.size.width;
        [UIView animateWithDuration:1.0 animations:^{
            _rootViewController.view.transform = transConcat;
        }completion:^(BOOL success){
            [selfRef setRootViewController:viewRef];
            _rootViewController.view.transform = transConcat;
            [self showShadow:YES];
            [selfRef showRootViewController:animation];
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }];
    }
}

/**
 *  侧边栏菜单点击后在主界面跳转界面
 *
 *  @param viewController 要跳转的界面
 *  @param animation      是否打开动画
 */
- (void)pushToNewViewController:(UIViewController *)viewController animation:(BOOL)animation {
    [self showRootViewController:YES];
    [(UINavigationController *)_rootViewController pushViewController:viewController animated:animation];
}

#pragma mark - private method
/**
 *  获取view的动画效果(有倾斜)
 *
 *  @return 返回动画效果
 */
-(CATransform3D)getCATransform3D{
    CGFloat translateX = 0;
    CGFloat transcale = 0;
    switch (g_panDirection) {
        case LeftMenuPanDirectionLeft:
            translateX = -(_leftDistance);
            transcale = _scaleSize;
            break;
        case LeftMenuPanDirectionRight:
            translateX = _leftDistance;
            transcale = _scaleSize;
        default:
            break;
    }
//    CGAffineTransform transT = CGAffineTransformMakeTranslation(translateX, 0);
//    CGAffineTransform scaleT = CGAffineTransformMakeScale(transcale, transcale);
//    CGAffineTransform conT = CGAffineTransformConcat(transT, scaleT);
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0/-600;//透视效果，要操作的这个对象要有旋转的角度，否则没有效果。正直/负值都有意义
    transform.m11 = transcale;//x轴缩放
    transform.m22 = transcale;//y轴缩放
    transform.m41 = translateX;//平移
    CGFloat angle =  30.0f * M_PI / 180.0f * (translateX/self.view.frame.size.width);
    transform = CATransform3DRotate(transform, angle , 0.0f, 10.0f, 0.0f);
    
    return transform;
}

/**
 *  获取view的动画效果(平移加缩放)
 *
 *  @return 返回动画效果
 */
-(CGAffineTransform)getCGAffineTransform{
    CGFloat translateX = 0;
    CGFloat transcale = 0;
    switch (g_panDirection) {
        case LeftMenuPanDirectionLeft:
            translateX = -(_leftDistance);
            transcale = _scaleSize;
            break;
        case LeftMenuPanDirectionRight:
            translateX = _leftDistance;
            transcale = _scaleSize;
        default:
            break;
    }
    if (_animationType == AnimationTransition) {
        transcale = 1;
    }
    CGAffineTransform transT = CGAffineTransformMakeTranslation(translateX, 0);
    CGAffineTransform scaleT = CGAffineTransformMakeScale(transcale, transcale);
    CGAffineTransform conT = CGAffineTransformConcat(transT, scaleT);
    return conT;
}

/**
 *  显示阴影
 *
 *  @param val 是否显示阴影
 */
- (void)showShadow:(BOOL)val {
    if (!_rootViewController) return;
    
    _rootViewController.view.layer.shadowOpacity = val ? 0.8f : 0.0f;
    if (val) {
        _rootViewController.view.layer.cornerRadius = 4.0f;
        _rootViewController.view.layer.shadowOffset = CGSizeZero;
        _rootViewController.view.layer.shadowRadius = 4.0f;
        _rootViewController.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.view.bounds].CGPath;
    }
    
}

/**
 *  设置左右上角按钮
 */
-(void)setNavigationBackButton{
    if (_rootViewController) {
        
        UIViewController *topController = nil;
        if ([_rootViewController isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController *navController = (UINavigationController*)_rootViewController;
            if ([[navController viewControllers] count] > 0) {
                topController = [[navController viewControllers] objectAtIndex:0];
            }
            
        } else if ([_rootViewController isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController *tabController = (UITabBarController*)_rootViewController;
            topController = [tabController selectedViewController];
            
        } else {
            
            topController = _rootViewController;
            
        }
        
        if (g_menuFlags.canShowLeft) {
            UIButton* leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            leftBtn.backgroundColor = [UIColor clearColor];
            [leftBtn setFrame:CGRectMake(0, 0, 24, 24)];
            [leftBtn addTarget:self action:@selector(showLeftViewController) forControlEvents:UIControlEventTouchUpInside];
            [leftBtn setImage:[UIImage imageNamed:@"nav_menu_icon"] forState:UIControlStateNormal];
            
            UIBarButtonItem* backItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
            topController.navigationItem.leftBarButtonItem = backItem;
        }
        if(g_menuFlags.canShowRight){
            UIButton* rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            rightBtn.backgroundColor = [UIColor clearColor];
            [rightBtn setFrame:CGRectMake(0, 0, 24, 24)];
            [rightBtn addTarget:self action:@selector(showRightViewController) forControlEvents:UIControlEventTouchUpInside];
            [rightBtn setImage:[UIImage imageNamed:@"nav_menu_icon"] forState:UIControlStateNormal];
            
            UIBarButtonItem* backItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
            topController.navigationItem.rightBarButtonItem = backItem;
        }
        
    }
}

#pragma mark - overwrite
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    CGAffineTransform oriT = CGAffineTransformIdentity;
    _rootViewController.view.transform = oriT;
    [self performSelector:@selector(layoutRootView) withObject:Nil afterDelay:0.1f];
}

-(void)layoutRootView{
    if (g_menuFlags.showingLeftView) {
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = 1.0/-600;//透视效果，要操作的这个对象要有旋转的角度，否则没有效果。正直/负值都有意义
        transform.m11 = _scaleSize;//x轴缩放
        transform.m22 = _scaleSize;//y轴缩放
        transform.m41 = _leftDistance;//平移
        CGFloat angle =  30.0f * M_PI / 180.0f * (_leftDistance/self.view.frame.size.width);
        transform = CATransform3DRotate(transform, angle , 0.0f, 10.0f, 0.0f);
        
//        CGAffineTransform transLeft = CGAffineTransformMakeTranslation(_leftDistance, 0);
//        CGAffineTransform transScale = CGAffineTransformMakeScale(_scaleSize, _scaleSize);
//        CGAffineTransform transConcat = CGAffineTransformConcat(transLeft, transScale);
        
        _rootViewController.view.layer.transform = transform;
    }else if(g_menuFlags.showingRightView){
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = 1.0/-600;//透视效果，要操作的这个对象要有旋转的角度，否则没有效果。正直/负值都有意义
        transform.m11 = _scaleSize;//x轴缩放
        transform.m22 = _scaleSize;//y轴缩放
        transform.m41 = _leftDistance;//平移
        CGFloat angle =  30.0f * M_PI / 180.0f * (_leftDistance/self.view.frame.size.width);
        transform = CATransform3DRotate(transform, angle , 0.0f, 10.0f, 0.0f);
        
//        CGAffineTransform transRight = CGAffineTransformMakeTranslation(-_leftDistance, 0);
//        CGAffineTransform transScale = CGAffineTransformMakeScale(_scaleSize, _scaleSize);
//        CGAffineTransform transConcat = CGAffineTransformConcat(transRight, transScale);
        
        _rootViewController.view.layer.transform = transform;
    }
    [self showShadow:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - set方法
/**
 *  设置右边UIViewController
 *
 *  @param rightController 右边UIViewController
 */
- (void)setRightViewController:(UIViewController *)rightController {
    _rightViewController = rightController;
    _rightViewController.view.alpha = min_Alpha;
    g_menuFlags.canShowRight = (_rightViewController != nil);
    [self setNavigationBackButton];
}

/**
 *  设置左边UIViewController
 *
 *  @param leftController 左边UIViewController
 */
- (void)setLeftViewController:(UIViewController *)leftController {
    _leftViewController = leftController;
    NSArray *array = _leftViewController.view.subviews;
    UITableView *tableview = array[0];
    tableview.frame = CGRectMake(0, self.view.frame.size.height/8, self.view.frame.size.width, self.view.frame.size.height-self.view.frame.size.height/4);
    _leftViewController.view.alpha = min_Alpha;
    g_menuFlags.canShowLeft = (_leftViewController != nil);
    [self setNavigationBackButton];
}

/**
 *  设置RootViewController
 *
 *  @param rootViewController RootViewController
 */
- (void)setRootViewController:(UIViewController *)rootViewController {
    UIViewController *tempRoot = _rootViewController;
    _rootViewController = rootViewController;
    _rootViewController.view.layer.zPosition = 100.0f;//设置_rootviewcontroller画在界面上的层级
    _rootViewController.view.layer.shouldRasterize = NO;//取消抗锯齿
    if (_rootViewController) {
        
        if (tempRoot) {
            [tempRoot.view removeFromSuperview];
            tempRoot = nil;
        }
        
        UIView *view = _rootViewController.view;
        view.frame = self.view.bounds;
        view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:view];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        pan.delegate = self;
        pan.delegate = (id<UIGestureRecognizerDelegate>)self;
        [view addGestureRecognizer:pan];
        
        g_tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapInRootController)];
        if (_rootViewController.view) {
            [_rootViewController.view addGestureRecognizer:g_tap];
        }
        [g_tap setEnabled:NO];
    } else {
        if (tempRoot) {
            [tempRoot.view removeFromSuperview];
            tempRoot = nil;
        }
    }
    [self setNavigationBackButton];
}

@end
