//
//  ViewController.swift
//  YXJSwipeTableViewCell
//
//  Created by yuanxiaojun on 16/8/9.
//  Copyright © 2016年 袁晓钧. All rights reserved.
//

import UIKit
import YXJSwipeTableViewCell

class ViewController: UITableViewController, YXJSwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK:table
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        weak var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ViewControllerCell
        cell!.label!.text = "\((indexPath as NSIndexPath).row)"

        cell!.setRightUtilityButtons(rightButtons() as [AnyObject], withButtonWidth: (cell?.frame.size.height)!)
        cell!.delegate = self

        return cell!
    }

    // MAKR:- YXJSwipeTableViewDelegate
    func rightButtons() -> NSMutableArray {
        let rightUtilityButtons = NSMutableArray()

        rightUtilityButtons.yxj_addUtilityButton(with: UIColor.red, title: "取消关注", titleColor: UIColor.white, font: UIFont.systemFont(ofSize: 15), normalIcon: UIImage(named: "course_noFollow"), selectedIcon: UIImage(named: "course_noFollow"), position: .top, space: 4)

        return rightUtilityButtons
    }
    func swipeableTableViewCell(_ cell: YXJSwipeTableViewCell!, didTriggerRightUtilityButtonWith index: Int) {
        print(">>>>>>>> \(index)")
        cell.hideUtilityButtons(animated: true)
    }
    func swipeableTableViewCellShouldHideUtilityButtons(onSwipe cell: YXJSwipeTableViewCell!) -> Bool {
        return true
    }
    func swipeableTableViewCell(_ cell: YXJSwipeTableViewCell!, canSwipeTo state: YXJSwipeCellState) -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

