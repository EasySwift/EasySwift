# EasyCountDownButton
一个超级好用的倒计时Button

## Join Us 
为了更好的完善EasySwift框架，希望更多对此框架有兴趣的朋友一起加入进来打造最好用最全面扩展最好的swift框架。
[EasySwift](https://github.com/stubbornnessness/EasySwift)官方QQ群：<mark>**542916901**</mark>

## Mark
先更新Github上的项目，所以最新的项目一定在[Github](https://github.com/stubbornnessness)上。

## Features
* 一个超级好用的倒计时Button

### ScreenShot
![image](http://120.27.93.73/files/myPublicProject/EasyCountDownButton1.gif)

## System Requirements
iOS 8.0 or above

## Installation
### As a CocoaPods Dependency
Add the following to your Podfile:

	pod 'EasyCountDownButton'
	
## Version
**V0.0.1** ---- 2016-8-10

* 首次发版
	
## Example
	import UIKit
	import EasyCountDownButton
	
	class ViewController: UIViewController {
	
	    let btn = EasyCountDownButton(frame: CGRect(x: 100, y: 100, width: 100, height: 30))
	
	    override func viewDidLoad() {
	        super.viewDidLoad()
	
	        btn.disableConfig = EasyCountDownButtonConfig(
	            font: UIFont.systemFontOfSize(14),
	            title: "剩余 5 秒",
	            titleColor: UIColor.grayColor(),
	            backgroundColor: UIColor.groupTableViewBackgroundColor(),
	            backgroundImage: nil)
	
	        btn.enableConfig = EasyCountDownButtonConfig(
	            font: UIFont.systemFontOfSize(14),
	            title: "获取验证码",
	            titleColor: UIColor.magentaColor(),
	            backgroundColor: UIColor.blueColor(),
	            backgroundImage: nil)
	
	        self.view.addSubview(btn)
	
	        // 点击事件  button type要 设置成custom 否则会闪动
	        btn.addToucheHandler { (btn, second) in
	            btn.startWithSecond(5)
	        }
	
	        // 时间改变
	        btn.didChange { (btn, second) -> String! in
	            return "剩余 \(second) 秒"
	        }
	
	        // 时间结束
	        btn.didFinished { (btn, second) in
	            print(btn)
	            print(second)
	        }
	
	        // 手动停止
	//        btn.stop()
	    }
	
	    override func didReceiveMemoryWarning() {
	        super.didReceiveMemoryWarning()
	    }
	}


    
## 极致框架
* EasySwift是从2014年开始打造的贯穿整个Swift开发的整套解决方案，只为最简单，最高效，最全面，高扩展性，囊括最前沿的架构，思想在其中[EasySwift](https://github.com/stubbornnessness/EasySwift)

## License
EasyEmoji is licensed under the Apache License, Version 2.0 License. For more information, please see the LICENSE file.