# YXJKxMenu
实现微信，qq首页右上角的菜单效果,高度自定义


## Join Us 
为了更好的完善EasySwift框架，希望更多对此框架有兴趣的朋友一起加入进来打造最好用最全面扩展最好的swift框架。
[EasySwift](https://github.com/stubbornnessness/EasySwift)官方QQ群：<mark>**542916901**</mark>

## Mark
先更新Github上的项目，所以最新的项目一定在[Github](https://github.com/stubbornnessness)上。

## Features
* 微信，qq首页右上角完全一样的菜单效果

### ScreenShot
![image](http://120.27.93.73/files/myPublicProject/YXJKxMenu1.gif)

## System Requirements
iOS 8.0 or above

## Installation
### As a CocoaPods Dependency
Add the following to your Podfile:

	pod 'YXJKxMenu'
	
## Version
**V0.0.1** ---- 2016-8-9

* 首次发版
	
## Example
	import UIKit
	import YXJKxMenu

	class ViewController: UIViewController {

	    var ScreenWidth: CGFloat {
	        return UIScreen.mainScreen().bounds.size.width
	    }
	
	    var ScreenHeight: CGFloat {
	        return UIScreen.mainScreen().bounds.size.height
	    }
	
	    override func viewDidLoad() {
	        super.viewDidLoad()
	    }

	    @IBAction func showMenu(sender: UIButton) {
	        var menuArray: [YXJKxMenuItem] = []
	
	        for i in 0..<4 {
	            let menuItem = YXJKxMenuItem("选项\(i)", image: UIImage(named: "\(i)"), target: self, action: #selector(ViewController.choiceTypeResult(_:)))
	            menuArray.append(menuItem)
	        }
	
	        YXJKxMenu.setTitleFont(UIFont.systemFontOfSize(14))
	
	        let option = OptionalConfiguration(
	            arrowSize: 10,
	            marginXSpacing: 10,
	            marginYSpacing: 10,
	            intervalSpacing: 10,
	            menuCornerRadius: 3,
	            maskToBackground: true,
	            shadowOfMenu: false,
	            hasSeperatorLine: true,
	            seperatorLineHasInsets: false,
	            textColor: Color(R: 82 / 255.0, G: 82 / 255.0, B: 82 / 255.0),
	            menuBackgroundColor: Color(R: 1, G: 1, B: 1),
	            setWidth: (ScreenWidth - 15 * 2) / 2)
	
	        let rect = CGRectMake(sender.frame.origin.x, 0, sender.frame.size.width, 64)
	
	        // 特别说明,这里的fromRect之所以没有直接使用sender.frame是因为该button的高度并没有占满整个navigationBar的高度，所以直接填写的titleBar加上navigationBar的高度(64)
	        YXJKxMenu.showMenuInView(self.view, fromRect: rect, menuItems: menuArray, withOptions: option)
	    }

	    @IBAction func showMenu1(sender: UIButton) {
	        var menuArray: [YXJKxMenuItem] = []
	
	        for i in 0..<5 {
	            let menuItem = YXJKxMenuItem("选项\(i)", image: nil, target: self, action: #selector(ViewController.choiceTypeResult(_:)))
	            menuArray.append(menuItem)
	        }
	
	        YXJKxMenu.setTitleFont(UIFont.systemFontOfSize(14))
	
	        let option = OptionalConfiguration(
	            arrowSize: 10,
	            marginXSpacing: 10,
	            marginYSpacing: 10,
	            intervalSpacing: 30,
	            menuCornerRadius: 3,
	            maskToBackground: true,
	            shadowOfMenu: false,
	            hasSeperatorLine: true,
	            seperatorLineHasInsets: false,
	            textColor: Color(R: 82 / 255.0, G: 82 / 255.0, B: 82 / 255.0),
	            menuBackgroundColor: Color(R: 1, G: 1, B: 1),
	            setWidth: 0)
	
		     // 特别说明,这里直接使用sender.frame是因为该框架能正确计算出YXJKxMenu将展示的位置
		     YXJKxMenu.showMenuInView(self.view, fromRect: sender.frame, menuItems: menuArray, withOptions: option)
		 }
	
	    // MAKR:实现YXJKxMenu协议
	    func choiceTypeResult(item: YXJKxMenuItem) {
	        print(item.title)
	    }
	
	    override func didReceiveMemoryWarning() {
	        super.didReceiveMemoryWarning()
	    }
	}


    
## 极致框架
* EasySwift是从2014年开始打造的贯穿整个Swift开发的整套解决方案，只为最简单，最高效，最全面，高扩展性，囊括最前沿的架构，思想在其中[EasySwift](https://github.com/stubbornnessness/EasySwift)

## License
EasyEmoji is licensed under the Apache License, Version 2.0 License. For more information, please see the LICENSE file.

        
