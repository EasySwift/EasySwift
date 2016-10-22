# EasyDropDownMenu
类似美团，糯米，大众点评的筛选排序菜单

## Join Us 
为了更好的完善此框架，希望更多对此框架有兴趣的朋友一起加入进来打造最好用最全面扩展最好的swift框架。
EasySwift官方QQ群：<mark>**542916901**</mark>

##Mark
先更新Github上的项目，所以最新的项目一定在[Github](https://github.com/stubbornnessness)上。

## Features
* 最简单，最快速的操作方式

## System Requirements
iOS 8.0 or above

## Installation
### As a CocoaPods Dependency
Add the following to your Podfile:

	pod 'EasyDropDownMenu'
	

### ScreenShot
![image](http://120.27.93.73/files/myPublicProject/EasyDorpDownMenu1.gif)

## Version
**V1.1** ---- 2016-9-22

* 针对ios10做调整


**V1.0.0** ---- 2016-6-21

* 重大更新，最大程度简化dataSource
* 支持文字以及图片的选择状态记录

**V0.0.1** ---- 2016-6-19

* 首次发版
	
## Example
	import UIKit
	import EasyDropDownMenu

	class ViewController: UIViewController, YXJDropDownMenuDelegate, YXJDropDownMenuDataSource {

    var classifys = [YXJCellData]()
    var cates = [YXJCellData]()
    var movices = [YXJCellData]()
    var hostels = [YXJCellData]()
    var areas = [YXJCellData]()
    var sorts = [YXJCellData]()

    lazy var menu = YXJDropDownMenu.init(origin: CGPointMake(0, 64), andHeight: 44)

    override func viewDidLoad() {
        super.viewDidLoad()

        // self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title:"重新加载", style:UIBarButtonItemStyle.Plain, target:self, action:"menuReloadData")

        classifys.append(YXJCellData(title: "美食", detailText: "1", defaultImage: UIImage(named: "TestImgs.bundle/0"), selectImage: UIImage(named: "TestImgs.bundle/0_select")))
        classifys.append(YXJCellData(title: "今日新单", detailText: "2", defaultImage: UIImage(named: "TestImgs.bundle/1"), selectImage: UIImage(named: "TestImgs.bundle/1_select")))
        classifys.append(YXJCellData(title: "电影", detailText: "3", defaultImage: UIImage(named: "TestImgs.bundle/2"), selectImage: UIImage(named: "TestImgs.bundle/2_select")))
        classifys.append(YXJCellData(title: "酒店", detailText: "4", defaultImage: UIImage(named: "TestImgs.bundle/3"), selectImage: UIImage(named: "TestImgs.bundle/3_select")))

        cates.append(YXJCellData(title: "自助餐", detailText: "1", defaultImage: UIImage(named: "TestImgs.bundle/5"), selectImage: UIImage(named: "TestImgs.bundle/5_select")))
        cates.append(YXJCellData(title: "快餐", detailText: "2", defaultImage: UIImage(named: "TestImgs.bundle/4"), selectImage: UIImage(named: "TestImgs.bundle/4_select")))
        cates.append(YXJCellData(title: "火锅", detailText: "3", defaultImage: UIImage(named: "TestImgs.bundle/3"), selectImage: UIImage(named: "TestImgs.bundle/3_select")))
        cates.append(YXJCellData(title: "日韩料理", detailText: "4", defaultImage: UIImage(named: "TestImgs.bundle/2"), selectImage: UIImage(named: "TestImgs.bundle/2_select")))
        cates.append(YXJCellData(title: "西餐", detailText: "5", defaultImage: UIImage(named: "TestImgs.bundle/1"), selectImage: UIImage(named: "TestImgs.bundle/1_select")))
        cates.append(YXJCellData(title: "烧烤小吃", detailText: "6", defaultImage: UIImage(named: "TestImgs.bundle/0"), selectImage: UIImage(named: "TestImgs.bundle/0_select")))

        movices.append(YXJCellData(title: "内地剧", detailText: "2", defaultImage: UIImage(named: "TestImgs.bundle/4"), selectImage: UIImage(named: "TestImgs.bundle/4_select")))
        movices.append(YXJCellData(title: "港台剧", detailText: "3", defaultImage: UIImage(named: "TestImgs.bundle/3"), selectImage: UIImage(named: "TestImgs.bundle/3_select")))
        movices.append(YXJCellData(title: "英美剧", detailText: "4", defaultImage: UIImage(named: "TestImgs.bundle/2"), selectImage: UIImage(named: "TestImgs.bundle/2_select")))

        hostels.append(YXJCellData(title: "经济酒店", detailText: "5", defaultImage: UIImage(named: "TestImgs.bundle/5"), selectImage: UIImage(named: "TestImgs.bundle/5_select")))
        hostels.append(YXJCellData(title: "商务酒店", detailText: "4", defaultImage: UIImage(named: "TestImgs.bundle/4"), selectImage: UIImage(named: "TestImgs.bundle/4_select")))
        hostels.append(YXJCellData(title: "连锁酒店", detailText: "3", defaultImage: UIImage(named: "TestImgs.bundle/3"), selectImage: UIImage(named: "TestImgs.bundle/3_select")))
        hostels.append(YXJCellData(title: "度假酒店", detailText: "2", defaultImage: UIImage(named: "TestImgs.bundle/2"), selectImage: UIImage(named: "TestImgs.bundle/2_select")))
        hostels.append(YXJCellData(title: "公寓酒店", detailText: "1", defaultImage: UIImage(named: "TestImgs.bundle/1"), selectImage: UIImage(named: "TestImgs.bundle/1_select")))

        areas.append(YXJCellData(title: "全城", detailText: nil, defaultImage: UIImage(named: "TestImgs.bundle/5"), selectImage: UIImage(named: "TestImgs.bundle/5_select")))
        areas.append(YXJCellData(title: "芙蓉区", detailText: nil, defaultImage: UIImage(named: "TestImgs.bundle/4"), selectImage: UIImage(named: "TestImgs.bundle/4_select")))
        areas.append(YXJCellData(title: "雨花区", detailText: nil, defaultImage: UIImage(named: "TestImgs.bundle/3"), selectImage: UIImage(named: "TestImgs.bundle/3_select")))
        areas.append(YXJCellData(title: "天心区", detailText: nil, defaultImage: UIImage(named: "TestImgs.bundle/2"), selectImage: UIImage(named: "TestImgs.bundle/2_select")))
        areas.append(YXJCellData(title: "开福区", detailText: nil, defaultImage: UIImage(named: "TestImgs.bundle/1"), selectImage: UIImage(named: "TestImgs.bundle/1_select")))
        areas.append(YXJCellData(title: "岳麓区", detailText: nil, defaultImage: UIImage(named: "TestImgs.bundle/0"), selectImage: UIImage(named: "TestImgs.bundle/0_select")))

        sorts.append(YXJCellData(title: "默认排序", detailText: nil, defaultImage: nil, selectImage: nil))
        sorts.append(YXJCellData(title: "离我最近", detailText: nil, defaultImage: nil, selectImage: nil))
        sorts.append(YXJCellData(title: "好评优先", detailText: nil, defaultImage: nil, selectImage: nil))
        sorts.append(YXJCellData(title: "人气优先", detailText: nil, defaultImage: nil, selectImage: nil))
        sorts.append(YXJCellData(title: "最新发布", detailText: nil, defaultImage: nil, selectImage: nil))

        // 添加下拉菜单
        self.menu.delegate = self
        self.menu.dataSource = self

        self.menu.textColor = UIColor.blackColor()
        self.menu.textSelectedColor = UIColor.init(red: 69.0 / 255.0, green: 198 / 255.0, blue: 190 / 255.0, alpha: 1)
        self.view.addSubview(menu)

        // 创建menu 第一次显示 不会调用点击代理，可以用这个手动调用
        menu.selectDefalutIndexPath()
    }

    // MARK:右键点击事件
    func menuReloadData() {
        self.classifys.removeAll()
        classifys.append(YXJCellData(title: "今日新单", detailText: "2", defaultImage: UIImage(named: "1"), selectImage: UIImage(named: "1_select")))
        classifys.append(YXJCellData(title: "电影", detailText: "3", defaultImage: UIImage(named: "2"), selectImage: UIImage(named: "2_select")))
        classifys.append(YXJCellData(title: "酒店", detailText: "4", defaultImage: UIImage(named: "3"), selectImage: UIImage(named: "3_select")))
        self.menu.reloadData()
    }
    // MARK:按钮事件
    func selectIndexPathAction(sender: AnyObject) {
        self.menu.selectIndexPath(YXJIndexPath(col: 0, row: 2, item: 2))
    }

    // MARK:YXJDropDownMenuDelegate
    func numberOfColumnsInMenu(menu: YXJDropDownMenu!) -> Int {
        return 3
    }
    func menu(menu: YXJDropDownMenu!, numberOfRowsInColumn column: Int) -> Int {
        if (column == 0) {
            return self.classifys.count
        } else if (column == 1) {
            return self.areas.count
        } else {
            return self.sorts.count
        }
    }
    func menu(menu: YXJDropDownMenu!, configRowAtIndexPath indexPath: YXJIndexPath!) -> YXJCellData! {
        if (indexPath.column == 0) {
            return self.classifys[indexPath.row]
        } else if (indexPath.column == 1) {
            return self.areas[indexPath.row]
        } else {
            return self.sorts[indexPath.row]
        }
    }
    func menu(menu: YXJDropDownMenu!, numberOfItemsInRow row: Int, column: Int) -> Int {
        if (column == 0) {
            if (row == 0) {
                return self.cates.count
            } else if (row == 2) {
                return self.movices.count
            } else if (row == 3) {
                return self.hostels.count
            }
        }
        return 0
    }
    func menu(menu: YXJDropDownMenu!, configItemsInRowAtIndexPath indexPath: YXJIndexPath!) -> YXJCellData! {
        if (indexPath.column == 0) {
            if (indexPath.row == 0) {
                return cates[indexPath.item]
            } else if (indexPath.row == 2) {
                return movices[indexPath.item]
            } else if (indexPath.row == 3) {
                return hostels[indexPath.item]
            }

        }
        return nil
    }
    func menu(menu: YXJDropDownMenu!, didSelectRowAtIndexPath indexPath: YXJIndexPath!) {
        if (indexPath.item >= 0) {
            print("点击了 \(indexPath.column) - \(indexPath.row) - indexPath.item 项目")
        } else {
            print("点击了 \(indexPath.column) - \(indexPath.row) 项目")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

	}
    
## 极致框架
* EasySwift是从2014年开始打造的贯穿整个Swift开发的整套解决方案，只为最简单，最高效，最全面，高扩展性，囊括最前沿的架构，思想在其中[EasySwift](https://github.com/stubbornnessness/EasySwift)

## License
EasyEmoji is licensed under the Apache License, Version 2.0 License. For more information, please see the LICENSE file.

