# YXJXibView
OC新建view勾选上xib文件即可自动关联，swift新建view已经不能勾选xib，但是又想用到xib，YXJXibView就能帮你搞定两秒钟搞定！

## Join Us 
为了更好的完善EasySwift框架，希望更多对此框架有兴趣的朋友一起加入进来打造最好用最全面扩展最好的swift框架。
[EasySwift](https://github.com/stubbornnessness/EasySwift)官方QQ群：<mark>**542916901**</mark>

## Mark
先更新Github上的项目，所以最新的项目一定在[Github](https://github.com/stubbornnessness)上。

## Features
* 及其强大的标签框架，不仅可以填充文字，任意视图都可以。

### ScreenShot
![image](https://github.com/stubbornnessness/YXJXibView/blob/master/testYXJXibView/testYXJXibView/demo.gif)

## System Requirements
iOS 8.0 or above

## Installation
### As a CocoaPods Dependency
Add the following to your Podfile:

	pod 'YXJXibView'
	
## Version
**V0.0.1** ---- 2016-7-4

* 首次发版
	
## Example
	import UIKit

	class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 方式一:在storyBoard中自动生成

        // 方式二:代码生成
        let v2 = TextXibView2(frame: CGRect(x: 50, y: 300, width: 50, height: 50))
        self.view.addSubview(v2)

        // 方式二:代码生成
        let v3 = TestXibView3(frame: CGRect(x: 50, y: 500, width: 50, height: 50))
        self.view.addSubview(v3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	}

    
## 极致框架
* EasySwift是从2014年开始打造的贯穿整个Swift开发的整套解决方案，只为最简单，最高效，最全面，高扩展性，囊括最前沿的架构，思想在其中[EasySwift](https://github.com/stubbornnessness/EasySwift)

## License
YXJXibView is licensed under the Apache License, Version 2.0 License. For more information, please see the LICENSE file.