# YXJTagView
及其强大的标签框架，不仅可以填充文字，任意视图都可以。


## Join Us 
为了更好的完善EasySwift框架，希望更多对此框架有兴趣的朋友一起加入进来打造最好用最全面扩展最好的swift框架。
[EasySwift](https://github.com/stubbornnessness/EasySwift)官方QQ群：<mark>**542916901**</mark>

## Mark
先更新Github上的项目，所以最新的项目一定在[Github](https://github.com/stubbornnessness)上。

## Features
* 及其强大的标签框架，不仅可以填充文字，任意视图都可以。

### ScreenShot 
![image](http://120.27.93.73/files/myPublicProject/YXJTagView1.gif)
![image](http://120.27.93.73/files/myPublicProject/YXJTagView2.gif)
![image](http://120.27.93.73/files/myPublicProject/YXJTagView3.gif)
![image](http://120.27.93.73/files/myPublicProject/YXJTagView4.gif)
![image](http://120.27.93.73/files/myPublicProject/YXJTagView5.gif)

## System Requirements
iOS 8.0 or above

## Installation
### As a CocoaPods Dependency
Add the following to your Podfile:

	pod 'YXJTagView'
	
## Version
**V0.0.1** ---- 2016-7-3

* 首次发版
	
## Example
	import UIKit
	import YXJTagView

	class ViewController: UIViewController, YXJTagViewDelegate {

    private var tagView: YXJTagView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tagView = YXJTagView(frame: CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: 20))
        self.view.addSubview(tagView)
        tagView.title = "标题"
        tagView.textColor = UIColor.grayColor()
        tagView.textBackgorund = UIColor.grayColor().colorWithAlphaComponent(0.6)
        tagView.selecteColor = UIColor.redColor()
        tagView.horizontalSpace = 10.0
        tagView.verticalSpace = 5.0
        tagView.margin = 15.0
        tagView.delegate = self

        // 场景一,纯文字
	//        tagView.textData = ["aa", "bbb", "cccc", "ddddd", "eeeeee", "fffffff", "gggggggg"]

        // 场景二,纯图片
	//        tagView.imageData = [UIImage.init(named: "1")!, UIImage.init(named: "2")!, UIImage.init(named: "3")!, UIImage.init(named: "4")!, UIImage.init(named: "5")!]

        // 场景三,纯图片加自定义图片大小
	//        tagView.imageData = [UIImage.init(named: "1")!, UIImage.init(named: "2")!, UIImage.init(named: "3")!, UIImage.init(named: "4")!, UIImage.init(named: "5")!]
	//        tagView.imageSize = CGSizeMake((self.view.frame.size.width - 60) / 2, (self.view.frame.size.width - 60) / 2 * (110 / 280))

        // 场景四,任意视图，颜色必须设置为可见颜色
	//        tagView.viewData = viewData()
	//        tagView.textBackgorund = UIColor.clearColor()
	//        tagView.selecteColor = 	UIColor.whiteColor().colorWithAlphaComponent(0.6)

        // 场景五,任意视图，自定义大小，颜色必须设置为可见颜色
        tagView.viewData = viewData()
        tagView.viewSize = CGSizeMake((self.view.frame.size.width - 60) / 2, 80)
        tagView.textBackgorund = UIColor.clearColor()
        tagView.selecteColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)

        tagView.setupUI()
    }

    func viewData() -> [UIView] {
        var views = [UIView]()

        let v1 = UIView.init(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        v1.backgroundColor = UIColor.brownColor()
        views.append(v1)

        let img1 = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        img1.image = UIImage.init(named: "1")
        v1.addSubview(img1)

        let v2 = UIView.init(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        v2.backgroundColor = UIColor.brownColor()
        views.append(v2)

        let img2 = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        img2.image = UIImage.init(named: "2")
        v2.addSubview(img2)

        let v3 = UIView.init(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        v3.backgroundColor = UIColor.brownColor()
        views.append(v3)

        let img3 = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        img3.image = UIImage.init(named: "3")
        v3.addSubview(img3)

        return views
    }

    func didClickView(text: String, index: Int) {
        print("index \(index)")
        print("text \(text)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

	}

    
## 极致框架
* EasySwift是从2014年开始打造的贯穿整个Swift开发的整套解决方案，只为最简单，最高效，最全面，高扩展性，囊括最前沿的架构，思想在其中[EasySwift](https://github.com/stubbornnessness/EasySwift)

## License
YXJTagView is licensed under the Apache License, Version 2.0 License. For more information, please see the LICENSE file.