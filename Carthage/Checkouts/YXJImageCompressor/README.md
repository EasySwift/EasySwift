# YXJImageCompressor
图片压缩，拍照上传压缩图片，比例压缩，data压缩，方便好用

## Join Us 
为了更好的完善EasySwift框架，希望更多对此框架有兴趣的朋友一起加入进来打造最好用最全面扩展最好的swift框架。
[EasySwift](https://github.com/stubbornnessness/EasySwift)官方QQ群：<mark>**542916901**</mark>

## Mark
先更新Github上的项目，所以最新的项目一定在[Github](https://github.com/stubbornnessness)上。

## Features
* 灵活方便的图片压缩工具

### ScreenShot
![image](http://120.27.93.73/files/myPublicProject/YXJImageCompressor1.png)

## System Requirements
iOS 8.0 or above

## Installation
### As a CocoaPods Dependency
Add the following to your Podfile:

	pod 'YXJImageCompressor'
	
## Version
**V0.0.1** ---- 2016-8-11

* 首次发版
	
## Example
	import UIKit
	import YXJImageCompressor
	
	class ViewController: UIViewController {
	
	    var ScreenWidth: CGFloat {
	        return UIScreen.mainScreen().bounds.width
	    }
	
	    var ScreenHeight: CGFloat {
	        return UIScreen.mainScreen().bounds.height
	    }
	
	    override func viewDidLoad() {
	        super.viewDidLoad()
	
	        let tv = UITextView(frame: CGRect(x: 0, y: 20, width: ScreenWidth, height: ScreenHeight - 20))
	        tv.font = UIFont.systemFontOfSize(14)
	        self.view.addSubview(tv)
	
	        /// 原图
	        let oldImg = UIImage(named: "img.JPG")
	        let oldData = UIImageJPEGRepresentation(oldImg!, 0.7)
	
	        tv.text.appendContentsOf("原图大小 \(M(Double(oldData!.length))) M \n")
	        tv.text.appendContentsOf("原图宽度 \(oldImg?.size.width) \n")
	        tv.text.appendContentsOf("原图高度 \(oldImg?.size.height) \n\n")
	        tv.text.appendContentsOf("-------------------------------\n")
	
	        /// 压缩方式一：最大边不超过某个值等比例压缩
	        let px_1000_img = YXJImageCompressor.YXJImageWithMaxSide(_1000PX, sourceImage: oldImg)
	        let px_1000_data = UIImageJPEGRepresentation(px_1000_img!, 0.7)
	
	        tv.text.appendContentsOf("最大边不超过1000PX的大小 \(M(Double(px_1000_data!.length))) M \n")
	        tv.text.appendContentsOf("最大边不超过1000PX宽度 \(px_1000_img?.size.width)\n")
	        tv.text.appendContentsOf("最大边不超过1000PX高度 \(px_1000_img?.size.height)\n\n")
	        tv.text.appendContentsOf("-------------------------------\n")
	
	        let px_100_img = YXJImageCompressor.YXJImageWithMaxSide(_100PX, sourceImage: oldImg)
	        let px_100_data = UIImageJPEGRepresentation(px_100_img!, 0.7)
	
	        tv.text.appendContentsOf("最大边不超过100PX的大小 \(M(Double(px_100_data!.length))) M\n")
	        tv.text.appendContentsOf("最大边不超过100PX宽度 \(px_100_img?.size.width)\n")
	        tv.text.appendContentsOf("最大边不超过100PX高度 \(px_100_img?.size.height)\n\n")
	        tv.text.appendContentsOf("-------------------------------\n")
	
	        /// 压缩方式二：图片大小不超过某个值已经最大边不超过某个像素等比例压缩
	        YXJImageCompressor.YXJCompressImage(oldImg, limitSize: _1M, maxSide: _1000PX) { (data) in
	            let img = UIImage(data: data)
	            tv.text.appendContentsOf("图片最大值不超过最大边1M 以及 最大边不超过1000PX的大小 \(self.M(Double(data.length))) M\n")
	            tv.text.appendContentsOf("图片最大值不超过最大边1M 以及 最大边不超过1000PX的宽度 \(img!.size.width)\n")
	            tv.text.appendContentsOf("图片最大值不超过最大边1M 以及 最大边不超过1000PX的高度 \(img!.size.height)\n\n")
	            tv.text.appendContentsOf("-------------------------------\n")
	        }
	
	        YXJImageCompressor.YXJCompressImage(oldImg, limitSize: _64K, maxSide: _100PX) { (data) in
	            let img = UIImage(data: data)
	            tv.text.appendContentsOf("图片最大值不超过最大边64K 以及 最大边不超过100PX的大小 \(self.M(Double(data.length))) M\n")
	            tv.text.appendContentsOf("图片最大值不超过最大边64K 以及 最大边不超过100PX的宽度 \(img!.size.width)\n")
	            tv.text.appendContentsOf("图片最大值不超过最大边64K 以及 最大边不超过100PX的高度 \(img!.size.height)\n\n")
	        }
	    }
	
	    func M(k: Double) -> Double {
	        return k / Double(_1M.rawValue)
	    }
	
	    override func didReceiveMemoryWarning() {
	        super.didReceiveMemoryWarning()
	    }
	}


    
## 极致框架
* EasySwift是从2014年开始打造的贯穿整个Swift开发的整套解决方案，只为最简单，最高效，最全面，高扩展性，囊括最前沿的架构，思想在其中[EasySwift](https://github.com/stubbornnessness/EasySwift)

## License
EasyEmoji is licensed under the Apache License, Version 2.0 License. For more information, please see the LICENSE file.
