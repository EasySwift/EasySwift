# YXJSwipeTableViewCell
UITableViewCell左右滑动出现更多按钮，按钮高度自定义

## Join Us 
为了更好的完善EasySwift框架，希望更多对此框架有兴趣的朋友一起加入进来打造最好用最全面扩展最好的swift框架。
[EasySwift](https://github.com/stubbornnessness/EasySwift)官方QQ群：<mark>**542916901**</mark>

## Mark
先更新Github上的项目，所以最新的项目一定在[Github](https://github.com/stubbornnessness)上。

## Features
* 微信，qq首页右上角完全一样的菜单效果

### ScreenShot
![image](http://120.27.93.73/files/myPublicProject/YXJSwipeTableViewCell1.gif)

## System Requirements
iOS 8.0 or above

## Installation
### As a CocoaPods Dependency
Add the following to your Podfile:

	pod 'YXJSwipeTableViewCell'
	
## Version
**V0.0.1** ---- 2016-8-10

* 首次发版
	
## Example
	import UIKit
	import YXJSwipeTableViewCell
	
	class ViewController: UITableViewController, YXJSwipeTableViewCellDelegate {
	
	    override func viewDidLoad() {
	        super.viewDidLoad()
	    }
	
	    // MARK:table
	    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
	        return 80
	    }
	    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
	        return 10
	    }
	    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
	        weak var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? ViewControllerCell
	        cell!.label!.text = "\(indexPath.row)"
	
	        cell!.setRightUtilityButtons(rightButtons() as [AnyObject], withButtonWidth: (cell?.frame.size.height)!)
	        cell!.delegate = self
	
	        return cell!
	    }
	
	    // MAKR:- YXJSwipeTableViewDelegate
	    func rightButtons() -> NSMutableArray {
	        let rightUtilityButtons = NSMutableArray()
	
	        rightUtilityButtons.YXJ_addUtilityButtonWithColor(UIColor.redColor(), title: "取消关注", titleColor: UIColor.whiteColor(), font: UIFont.systemFontOfSize(15), normalIcon: UIImage(named: "course_noFollow"), selectedIcon: UIImage(named: "course_noFollow"), position: .Top, space: 4)
	
	        return rightUtilityButtons
	    }
	    func swipeableTableViewCell(cell: YXJSwipeTableViewCell!, didTriggerRightUtilityButtonWithIndex index: Int) {
	        print(">>>>>>>> \(index)")
	        cell.hideUtilityButtonsAnimated(true)
	    }
	    func swipeableTableViewCellShouldHideUtilityButtonsOnSwipe(cell: YXJSwipeTableViewCell!) -> Bool {
	        return true
	    }
	    func swipeableTableViewCell(cell: YXJSwipeTableViewCell!, canSwipeToState state: YXJSwipeCellState) -> Bool {
	        return true
	    }
	
	    override func didReceiveMemoryWarning() {
	        super.didReceiveMemoryWarning()
	    }
	}


    
## 极致框架
* EasySwift是从2014年开始打造的贯穿整个Swift开发的整套解决方案，只为最简单，最高效，最全面，高扩展性，囊括最前沿的架构，思想在其中[EasySwift](https://github.com/stubbornnessness/EasySwift)

## License
EasyEmoji is licensed under the Apache License, Version 2.0 License. For more information, please see the LICENSE file.

        
