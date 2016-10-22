# YXJOnePixelLine
极其方便的画出真正的一个像素的线。即将到来

## Join Us 
为了更好的完善EasySwift框架，希望更多对此框架有兴趣的朋友一起加入进来打造最好用最全面扩展最好的swift框架。
[EasySwift](https://github.com/stubbornnessness/EasySwift)官方QQ群：<mark>**542916901**</mark>

## Mark
先更新Github上的项目，所以最新的项目一定在[Github](https://github.com/stubbornnessness)上。

## Features
* 微信，qq首页右上角完全一样的菜单效果

### ScreenShot
![image](http://120.27.93.73/files/myPublicProject/YXJOnePixeLine1.gif)
![image](http://120.27.93.73/files/myPublicProject/YXJOnePixeLine2.gif)

## System Requirements
iOS 8.0 or above

## Installation
### As a CocoaPods Dependency
Add the following to your Podfile:

	pod 'YXJOnePixeLine'
	
## Version
**V0.0.1** ---- 2016-8-10

* 首次发版
	
## Example
	import UIKit
	import YXJOnePixeLine
	
	class ViewController: UIViewController {
	
	    @IBOutlet weak var onePixeView: UIView!
	
	    override func viewDidLoad() {
	        super.viewDidLoad()
	    }
	
	    @IBAction func click(sender: AnyObject) {
	        // linePosition的按照顺时针的方向，依次对应 上>右>下>左
	
	        // 上
	        let pixe1 = YXJOnePixelLine(frame: onePixeView.frame,
	                                    lineColor: UIColor.redColor(),
	                                    linePosition: 0)
	        self.onePixeView.addSubview(pixe1)
	
	        // 右
	        let pixe2 = YXJOnePixelLine(frame: onePixeView.frame,
	                                    lineColor: UIColor.redColor(),
	                                    linePosition: 1)
	        self.onePixeView.addSubview(pixe2)
	        
	        // 下
	        let pixe3 = YXJOnePixelLine(frame: onePixeView.frame,
	                                    lineColor: UIColor.redColor(),
	                                    linePosition: 2)
	        self.onePixeView.addSubview(pixe3)
	        
	        // 左
	        let pixe4 = YXJOnePixelLine(frame: onePixeView.frame,
	                                    lineColor: UIColor.redColor(),
	                                    linePosition: 3)
	        self.onePixeView.addSubview(pixe4)
	    }
	
	    override func didReceiveMemoryWarning() {
	        super.didReceiveMemoryWarning()
	    }
	
	}


    
## 极致框架
* EasySwift是从2014年开始打造的贯穿整个Swift开发的整套解决方案，只为最简单，最高效，最全面，高扩展性，囊括最前沿的架构，思想在其中[EasySwift](https://github.com/stubbornnessness/EasySwift)

## License
EasyEmoji is licensed under the Apache License, Version 2.0 License. For more information, please see the LICENSE file.
