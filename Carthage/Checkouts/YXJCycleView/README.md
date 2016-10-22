# YXJCycleView
任意视图的无限循环轮播图，可以是本地图片，可以是任意的view，可以是远程图片，再加文字描述岂不更好，pageController也支持高度自定义。几乎可以满足所有循环视图的需求，不仅是轮播组件，做app首次安装或者更新的介绍页也照样能胜任。支持缓存



## Join Us 
为了更好的完善EasySwift框架，希望更多对此框架有兴趣的朋友一起加入进来打造最好用最全面扩展最好的swift框架。
[EasySwift](https://github.com/stubbornnessness/EasySwift)官方QQ群：<mark>**542916901**</mark>

## Mark
先更新Github上的项目，所以最新的项目一定在[Github](https://github.com/stubbornnessness)上。

## Features
* 本地图片轮播图
* 远程图片轮播图
* 任意视图轮播图
* 无限循环
* pageController高度自定义
* 缓存支持
* 可以用作app介绍页

### ScreenShot
![image](http://120.27.93.73/files/myPublicProject/YXJCycleView1.gif)

## System Requirements
iOS 8.0 or above

## Installation
### As a CocoaPods Dependency
Add the following to your Podfile:

	pod 'YXJCycleView'
	
## Version
**V0.0.1** ---- 2016-8-11

* 首次发版
	
## Example
	import UIKit
	import YXJCycleView
	
	var ScreenWidth: CGFloat {
	    return UIScreen.mainScreen().bounds.width
	}
	
	class ViewController: UIViewController, YXJCycleScrollViewDelegate {
	
	    private var cycleView: YXJCycleScrollView?
	
	    override func viewDidLoad() {
	        super.viewDidLoad()
	
	        /**
	         方式一
	         */
	        loadLocalImg()
	
	        /**
	         方式二
	         */
	        loadLocalView()
	
	        /**
	         方式三
	         */
	        loadURLImg()
	    }
	
	    /**
	     加载本地图片，使用场景，做静态展示或者app首次安装或者更新的介绍页
	     */
	    func loadLocalImg() {
	        self.cycleView = YXJCycleScrollView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 150))
	        self.view.addSubview(self.cycleView!)
	        self.cycleView?.backgroundColor = UIColor.whiteColor()
	        self.cycleView?.autoScroll = false
	        self.cycleView?.infiniteLoop = false
	        self.cycleView?.delegate = self
	        self.cycleView?.localizationImagesGroup = [UIImage.init(named: "init1")!, UIImage.init(named: "init2")!, UIImage.init(named: "init3")!, UIImage.init(named: "init4")!, UIImage.init(named: "init5")!]
	        self.cycleView?.pageControl.dotColor = UIColor.whiteColor()
	    }
	
	    /**
	     加载本地任意view
	     */
	    func loadLocalView() {
	        self.cycleView = YXJCycleScrollView(frame: CGRect(x: 0, y: 160, width: ScreenWidth, height: 150))
	        self.view.addSubview(self.cycleView!)
	        self.cycleView?.backgroundColor = UIColor.whiteColor()
	        self.cycleView?.autoScroll = false
	        self.cycleView?.infiniteLoop = false
	        self.cycleView?.delegate = self
	
	        let v1 = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 150))
	        v1.backgroundColor = UIColor.brownColor()
	        let v2 = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 150))
	        v2.backgroundColor = UIColor.purpleColor()
	        let v3 = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 150))
	        v3.backgroundColor = UIColor.orangeColor()
	        let v4 = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 150))
	        v4.backgroundColor = UIColor.magentaColor()
	
	        self.cycleView?.views = [v1, v2, v3, v4]
	        self.cycleView?.pageControl.dotColor = UIColor.whiteColor()
	    }
	
	    /**
	     加载网络图片
	     */
	    func loadURLImg() {
	        self.cycleView = YXJCycleScrollView(frame: CGRect(x: 0, y: 320, width: ScreenWidth, height: 150))
	        self.view.addSubview(self.cycleView!)
	        self.cycleView?.backgroundColor = UIColor.whiteColor()
	        self.cycleView?.autoScroll = true
	        self.cycleView?.autoScrollTimeInterval = 3
	        self.cycleView?.infiniteLoop = true
	        self.cycleView?.delegate = self
	        self.cycleView?.pageControlAliment = YXJCycleScrollViewPageContolAlimentRight
	        self.cycleView?.imageURLStringsGroup = [
	            "http://p0.so.qhmsg.com/bdm/326_204_/t011d35badee89c184a.jpg",
	            "http://p3.so.qhmsg.com/bdm/326_204_/t01d5cd3cd467db8b4d.jpg",
	            "http://p1.so.qhmsg.com/bdm/326_204_/t014986d9bc787ba0e1.jpg",
	            "http://p3.so.qhmsg.com/bdm/326_204_/t012e2e252b709019e3.jpg"
	        ]
	        self.cycleView?.titlesGroup = [
	            "第一张图片的描述",
	            "第二张图片的描述",
	            "第三张图片的描述",
	            "第四张图片的描述"
	        ]
	        self.cycleView?.pageControl.dotColor = UIColor.whiteColor()
	    }
	
	    // MARK:cycle
	    func cycleScrollView(cycleScrollView: YXJCycleScrollView!, didSelectItemAtIndex index: Int) {
	        print(index)
	    }
	    func cycleScrollView(cycleScrollView: YXJCycleScrollView!, didSwipeItemAtIndex index: Int) {
	        print(index)
	    }
	
	    override func didReceiveMemoryWarning() {
	        super.didReceiveMemoryWarning()
	    }
	}


    
## 极致框架
* EasySwift是从2014年开始打造的贯穿整个Swift开发的整套解决方案，只为最简单，最高效，最全面，高扩展性，囊括最前沿的架构，思想在其中[EasySwift](https://github.com/stubbornnessness/EasySwift)

## License
EasyEmoji is licensed under the Apache License, Version 2.0 License. For more information, please see the LICENSE file.