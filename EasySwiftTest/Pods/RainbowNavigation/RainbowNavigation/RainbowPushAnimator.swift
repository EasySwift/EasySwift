//
//  LLRainbowPushAnimator.swift
//  Pods
//
//  Created by Danis on 15/11/25.
//
//

class RainbowPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        let fromColorSource = fromVC as? RainbowColorSource
        let toColorSource = toVC as? RainbowColorSource
        
        var nextColor:UIColor?
        nextColor = fromColorSource?.navigationBarOutColor?()
        nextColor = toColorSource?.navigationBarInColor?()

        let containerView = transitionContext.containerView
        let shadowMask = UIView(frame: containerView.bounds)
        shadowMask.backgroundColor = UIColor.black
        shadowMask.alpha = 0
        containerView.addSubview(shadowMask)
        containerView.addSubview(toVC.view)
        
        // Layout
        let originFromFrame = fromVC.view.frame
        let finalToFrame = transitionContext.finalFrame(for: toVC)
        toVC.view.frame = finalToFrame.offsetBy(dx: finalToFrame.width, dy: 0)
        
        let tabBar = toVC.navigationController?.tabBarController?.tabBar
        
        let needPushTabBar = toVC.navigationController?.tabBarController != nil && toVC.hidesBottomBarWhenPushed && toVC.navigationController?.childViewControllers.count == 2
        
        if needPushTabBar {
            toVC.navigationController?.tabBarController?.view.sendSubview(toBack: tabBar!)
        }
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            toVC.view.frame = finalToFrame
            fromVC.view.frame = originFromFrame.offsetBy(dx: -originFromFrame.width / 2, dy: 0)
            shadowMask.alpha = 0.3
            if needPushTabBar {
                toVC.navigationController!.tabBarController!.tabBar.frame = CGRect(x: fromVC.view.frame.minX, y: fromVC.view.frame.minY, width: tabBar!.frame.width, height: tabBar!.frame.height)
            }
            if let navigationColor = nextColor {
                fromVC.navigationController?.navigationBar.df_setBackgroundColor(navigationColor)
            }
            
            }) { (finished) -> Void in
                if needPushTabBar {
                    toVC.navigationController?.tabBarController?.view.bringSubview(toFront: tabBar!)
                }
                fromVC.view.frame = originFromFrame
                shadowMask.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
