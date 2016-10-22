# EasySearchBar
自定义SearchBar，由于系统的searchBar扩展性不强，所以打算自定义SearchBar，就有了此框架。


## Join Us 
为了更好的完善EasySwift框架，希望更多对此框架有兴趣的朋友一起加入进来打造最好用最全面扩展最好的swift框架。
[EasySwift](https://github.com/stubbornnessness/EasySwift)官方QQ群：<mark>**542916901**</mark>

## Mark
先更新Github上的项目，所以最新的项目一定在[Github](https://github.com/stubbornnessness)上。

## Features
* 自定义SearchBar

### ScreenShot
![image](http://120.27.93.73/files/myPublicProject/EasySearchBar1.gif)

## System Requirements
iOS 8.0 or above

## Installation
### As a CocoaPods Dependency
Add the following to your Podfile:

	pod 'EasySearchBar'
	
## Version
**V0.0.1** ---- 2016-7-1

* 首次发版
	
## Example
	import UIKit
	import EasySearchBar

	class ViewController: UIViewController {

    private var searchBar: EasySearchBar?

    override func viewDidLoad() {
        super.viewDidLoad()

        // 搜索框
        self.searchBar = EasySearchBar(frame: CGRectMake(0, 100, self.view.frame.size.width, 30))
        self.searchBar?.easySearchBarPlaceholder = "搜索课程"
        self.searchBar?.easyBackgroundColor = UIColor.cyanColor()
        self.view.addSubview(self.searchBar!)

        self.searchBar?.easyCancelBTClickedBlock({ (search) in
            print("点击了取消按钮")
            search.text = ""
        })
        self.searchBar?.easySearchBarTextDidBeginEditingBlock({ (search) in
            print("开始编辑" + search.text!)
        })
        self.searchBar?.easySearchBarTextDidChangeBlock({ (search, searchText) in
            print("内容改变" + searchText)
        })
        self.searchBar?.easySearchBarTextDidEndEditingBlock({ (search) in
            print("结束输入")
        })
        self.searchBar?.easySearchBarSearchButtonClickedBlock({ (search) in
            print("点击键盘搜索" + search.text!)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

	}

    
## 极致框架
* EasySwift是从2014年开始打造的贯穿整个Swift开发的整套解决方案，只为最简单，最高效，最全面，高扩展性，囊括最前沿的架构，思想在其中[EasySwift](https://github.com/stubbornnessness/EasySwift)

## License
EasyEmoji is licensed under the Apache License, Version 2.0 License. For more information, please see the LICENSE file.
