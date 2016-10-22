# YXJSlideBar
仿照网易新闻的菜单

## Join Us 
为了更好的完善EasySwift框架，希望更多对此框架有兴趣的朋友一起加入进来打造最好用最全面扩展最好的swift框架。
[EasySwift](https://github.com/stubbornnessness/EasySwift)官方QQ群：<mark>**542916901**</mark>

## Mark
先更新Github上的项目，所以最新的项目一定在[Github](https://github.com/stubbornnessness)上。

## Features
* 微信，qq首页右上角完全一样的菜单效果

### ScreenShot
![image](http://120.27.93.73/files/myPublicProject/YXJSlideBar1.gif)

## System Requirements
iOS 8.0 or above

## Installation
### As a CocoaPods Dependency
Add the following to your Podfile:

	pod 'YXJSlideBar'
	
## Version
**V0.0.1** ---- 2016-8-10

* 首次发版
	
## Example
	import UIKit
	import YXJSlideBar
	
	class ViewController1: UIViewController, YXJSlideContentViewDataSource {
	
	    private var slideBar: YXJSlideBar!
	
	    private var contentView: YXJSlideContentView!
	
	    private var vcs = [
	        UIViewController(), UIViewController(),
	        UIViewController(), UIViewController(),
	        UIViewController(), UIViewController(),
	        UIViewController(), UIViewController(),
	        UIViewController(), UIViewController()]
	
	    override func viewDidLoad() {
	        super.viewDidLoad()
	
	        // 菜单2
	        self.slideBar = YXJSlideBar(frame: CGRect(x: 0, y: 50, width: ScreenWidth, height: 50))
	        self.slideBar.backgroundColor = UIColor.groupTableViewBackgroundColor()
	        self.slideBar.itemsTitle = ["选项1", "选项2", "选项3", "选项4", "选项5", "选项6", "选项7", "选项8", "选项9", "选项10"]
	        self.slideBar.itemColor = UIColor.grayColor()
	        self.slideBar.itemSelectedColor = UIColor.redColor()
	        self.slideBar.sliderColor = UIColor.redColor()
	        self.slideBar.slideBarItemSelectedCallback { [weak self](idx) -> Void in
	            print(idx)
	            self?.contentView.scrollSlideContentViewToIndex(idx)
	        }
	        self.view.addSubview(self.slideBar)
	
	        self.contentView = YXJSlideContentView(frame: CGRect(x: 0, y: 100, width: ScreenWidth, height: 300))
	        self.contentView.dataSource = self
	        self.contentView.setIsEnableScroll(true)
	        self.contentView.slideContentViewScrollFinished { [weak self](idx) in
	            print(idx)
	            self?.slideBar.selectSlideBarItemAtIndex(idx)
	        }
	        self.view.addSubview(contentView)
	
	        vcs[0].view.backgroundColor = UIColor.redColor()
	        vcs[1].view.backgroundColor = UIColor.blackColor()
	        vcs[2].view.backgroundColor = UIColor.darkGrayColor()
	        vcs[3].view.backgroundColor = UIColor.lightGrayColor()
	        vcs[4].view.backgroundColor = UIColor.greenColor()
	        vcs[5].view.backgroundColor = UIColor.blueColor()
	        vcs[6].view.backgroundColor = UIColor.cyanColor()
	        vcs[7].view.backgroundColor = UIColor.yellowColor()
	        vcs[8].view.backgroundColor = UIColor.magentaColor()
	        vcs[9].view.backgroundColor = UIColor.orangeColor()
	    }
	
	    // MARK:YXJSlideContentViewDataSource
	    func slideContentView(contentView: YXJSlideContentView!, viewControllerForIndex index: UInt) -> UIViewController! {
	        return vcs[Int(index)]
	    }
	    func numOfContentView() -> Int {
	        return vcs.count
	    }
	
	    override func didReceiveMemoryWarning() {
	        super.didReceiveMemoryWarning()
	    }
	}


    
## 极致框架
* EasySwift是从2014年开始打造的贯穿整个Swift开发的整套解决方案，只为最简单，最高效，最全面，高扩展性，囊括最前沿的架构，思想在其中[EasySwift](https://github.com/stubbornnessness/EasySwift)

## License
EasyEmoji is licensed under the Apache License, Version 2.0 License. For more information, please see the LICENSE file.
