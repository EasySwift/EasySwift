# YXJPullScale
UITableView,UICollectionView,UIScrollerView的顶部放大控件,不仅支持图片,也支持任意视图

## Join Us 
为了更好的完善EasySwift框架，希望更多对此框架有兴趣的朋友一起加入进来打造最好用最全面扩展最好的swift框架。
[EasySwift](https://github.com/stubbornnessness/EasySwift)官方QQ群：<mark>**542916901**</mark>

## Mark
先更新Github上的项目，所以最新的项目一定在[Github](https://github.com/stubbornnessness)上。

## Features
* 支持图片
* 支持任意视图

### ScreenShot
![image](http://120.27.93.73/files/myPublicProject/YXJPullScale1.gif)

## System Requirements
iOS 8.0 or above

## Installation
### As a CocoaPods Dependency
Add the following to your Podfile:

	pod 'YXJPullScale'
	
## Version
**V0.0.1** ---- 2016-8-11

* 首次发版
	
## Example
	import UIKit
	import YXJPullScale
	
	class ViewController: UITableViewController {
	    
	    private var headerView: MineHeaderView!
	    
	    override func viewDidLoad() {
	        super.viewDidLoad()
	        
	        self.automaticallyAdjustsScrollViewInsets = false
	        
	        // 用户详情
	        headerView = MineHeaderView()
	        
	        self.tableView.addPullScaleFuncInVC(self, originalHeight: self.tableView.frame.size.width / (320.0 / 200.0), hasNavBar: false)
	        
	        self.tableView.scaleView.mainView = headerView
	        self.tableView.scaleView.scaleImage = UIImageView(image: UIImage(named: "left_headerBg"))
	    }
	    
	    override func didReceiveMemoryWarning() {
	        super.didReceiveMemoryWarning()
	    }
	}

    
## 极致框架
* EasySwift是从2014年开始打造的贯穿整个Swift开发的整套解决方案，只为最简单，最高效，最全面，高扩展性，囊括最前沿的架构，思想在其中[EasySwift](https://github.com/stubbornnessness/EasySwift)

## License
EasyEmoji is licensed under the Apache License, Version 2.0 License. For more information, please see the LICENSE file.