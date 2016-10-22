# YXJPageController
高扩展的PageController  

## Join Us 
为了更好的完善EasySwift框架，希望更多对此框架有兴趣的朋友一起加入进来打造最好用最全面扩展最好的swift框架。
[EasySwift](https://github.com/stubbornnessness/EasySwift)官方QQ群：<mark>**542916901**</mark>

## Mark
先更新Github上的项目，所以最新的项目一定在[Github](https://github.com/stubbornnessness)上。

## Features
* 一个超级好用的倒计时Button

### ScreenShot
![image](http://120.27.93.73/files/myPublicProject/YXJPageController1.png)

## System Requirements
iOS 8.0 or above

## Installation
### As a CocoaPods Dependency
Add the following to your Podfile:

	pod 'YXJPageController'
	
## Version
**V0.0.1** ---- 2016-8-11

* 首次发版
	
## Example
	import UIKit
	import YXJPageController
	
	class DIYPageView: YXJAbstractDotView {
	
	    override init(frame: CGRect) {
	        super.init(frame: frame)
	        self.backgroundColor = UIColor.blueColor()
	    }
	
	    required init?(coder aDecoder: NSCoder) {
	        super.init(coder: aDecoder)
	
	        self.backgroundColor = UIColor.blueColor()
	    }
	
	    override func changeActivityState(active: Bool) {
	        if active == true {
	            self.backgroundColor = UIColor.redColor()
	        } else {
	            self.backgroundColor = UIColor.blueColor()
	        }
	    }
	
	}


    
## 极致框架
* EasySwift是从2014年开始打造的贯穿整个Swift开发的整套解决方案，只为最简单，最高效，最全面，高扩展性，囊括最前沿的架构，思想在其中[EasySwift](https://github.com/stubbornnessness/EasySwift)

## License
EasyEmoji is licensed under the Apache License, Version 2.0 License. For more information, please see the LICENSE file.
