
//
//  ViewController.swift
//  EasyDropDownMenuTest
//
//  Created by yuanxiaojun on 16/6/19.
//  Copyright © 2016年 袁晓钧. All rights reserved.
//

import UIKit
import EasyDropDownMenu

class ViewController: UIViewController, YXJDropDownMenuDelegate, YXJDropDownMenuDataSource {

    var classifys = [YXJCellData]()
    var cates = [YXJCellData]()
    var movices = [YXJCellData]()
    var hostels = [YXJCellData]()
    var areas = [YXJCellData]()
    var sorts = [YXJCellData]()

    var menu = YXJDropDownMenu.init(origin: CGPoint.init(x: 0, y: 64), andHeight: 44)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title:"重新加载", style:UIBarButtonItemStyle.plain, target:self, action:#selector(ViewController.menuReloadData))

        classifys.append(YXJCellData(title: "美食", detailText: "1", defaultImage: UIImage(named: "TestImgs.bundle/0"), select: UIImage(named: "TestImgs.bundle/0_select")))
        classifys.append(YXJCellData(title: "今日新单", detailText: "2", defaultImage: UIImage(named: "TestImgs.bundle/1"), select: UIImage(named: "TestImgs.bundle/1_select")))
        classifys.append(YXJCellData(title: "电影", detailText: "3", defaultImage: UIImage(named: "TestImgs.bundle/2"), select: UIImage(named: "TestImgs.bundle/2_select")))
        classifys.append(YXJCellData(title: "酒店", detailText: "4", defaultImage: UIImage(named: "TestImgs.bundle/3"), select: UIImage(named: "TestImgs.bundle/3_select")))

        cates.append(YXJCellData(title: "自助餐", detailText: "1", defaultImage: UIImage(named: "TestImgs.bundle/5"), select: UIImage(named: "TestImgs.bundle/5_select")))
        cates.append(YXJCellData(title: "快餐", detailText: "2", defaultImage: UIImage(named: "TestImgs.bundle/4"), select: UIImage(named: "TestImgs.bundle/4_select")))
        cates.append(YXJCellData(title: "火锅", detailText: "3", defaultImage: UIImage(named: "TestImgs.bundle/3"), select: UIImage(named: "TestImgs.bundle/3_select")))
        cates.append(YXJCellData(title: "日韩料理", detailText: "4", defaultImage: UIImage(named: "TestImgs.bundle/2"), select: UIImage(named: "TestImgs.bundle/2_select")))
        cates.append(YXJCellData(title: "西餐", detailText: "5", defaultImage: UIImage(named: "TestImgs.bundle/1"), select: UIImage(named: "TestImgs.bundle/1_select")))
        cates.append(YXJCellData(title: "烧烤小吃", detailText: "6", defaultImage: UIImage(named: "TestImgs.bundle/0"), select: UIImage(named: "TestImgs.bundle/0_select")))

        movices.append(YXJCellData(title: "内地剧", detailText: "2", defaultImage: UIImage(named: "TestImgs.bundle/4"), select: UIImage(named: "TestImgs.bundle/4_select")))
        movices.append(YXJCellData(title: "港台剧", detailText: "3", defaultImage: UIImage(named: "TestImgs.bundle/3"), select: UIImage(named: "TestImgs.bundle/3_select")))
        movices.append(YXJCellData(title: "英美剧", detailText: "4", defaultImage: UIImage(named: "TestImgs.bundle/2"), select: UIImage(named: "TestImgs.bundle/2_select")))

        hostels.append(YXJCellData(title: "经济酒店", detailText: "5", defaultImage: UIImage(named: "TestImgs.bundle/5"), select: UIImage(named: "TestImgs.bundle/5_select")))
        hostels.append(YXJCellData(title: "商务酒店", detailText: "4", defaultImage: UIImage(named: "TestImgs.bundle/4"), select: UIImage(named: "TestImgs.bundle/4_select")))
        hostels.append(YXJCellData(title: "连锁酒店", detailText: "3", defaultImage: UIImage(named: "TestImgs.bundle/3"), select: UIImage(named: "TestImgs.bundle/3_select")))
        hostels.append(YXJCellData(title: "度假酒店", detailText: "2", defaultImage: UIImage(named: "TestImgs.bundle/2"), select: UIImage(named: "TestImgs.bundle/2_select")))
        hostels.append(YXJCellData(title: "公寓酒店", detailText: "1", defaultImage: UIImage(named: "TestImgs.bundle/1"), select: UIImage(named: "TestImgs.bundle/1_select")))

        areas.append(YXJCellData(title: "全城", detailText: nil, defaultImage: UIImage(named: "TestImgs.bundle/5"), select: UIImage(named: "TestImgs.bundle/5_select")))
        areas.append(YXJCellData(title: "芙蓉区", detailText: nil, defaultImage: UIImage(named: "TestImgs.bundle/4"), select: UIImage(named: "TestImgs.bundle/4_select")))
        areas.append(YXJCellData(title: "雨花区", detailText: nil, defaultImage: UIImage(named: "TestImgs.bundle/3"), select: UIImage(named: "TestImgs.bundle/3_select")))
        areas.append(YXJCellData(title: "天心区", detailText: nil, defaultImage: UIImage(named: "TestImgs.bundle/2"), select: UIImage(named: "TestImgs.bundle/2_select")))
        areas.append(YXJCellData(title: "开福区", detailText: nil, defaultImage: UIImage(named: "TestImgs.bundle/1"), select: UIImage(named: "TestImgs.bundle/1_select")))
        areas.append(YXJCellData(title: "岳麓区", detailText: nil, defaultImage: UIImage(named: "TestImgs.bundle/0"), select: UIImage(named: "TestImgs.bundle/0_select")))

        sorts.append(YXJCellData(title: "默认排序", detailText: nil, defaultImage: nil, select: nil))
        sorts.append(YXJCellData(title: "离我最近", detailText: nil, defaultImage: nil, select: nil))
        sorts.append(YXJCellData(title: "好评优先", detailText: nil, defaultImage: nil, select: nil))
        sorts.append(YXJCellData(title: "人气优先", detailText: nil, defaultImage: nil, select: nil))
        sorts.append(YXJCellData(title: "最新发布", detailText: nil, defaultImage: nil, select: nil))

        // 添加下拉菜单
        self.menu?.delegate = self
        self.menu?.dataSource = self

        self.menu?.textColor = UIColor.black
        self.menu?.textSelectedColor = UIColor.init(red: 69.0 / 255.0, green: 198 / 255.0, blue: 190 / 255.0, alpha: 1)
        self.view.addSubview(menu!)

        // 创建menu 第一次显示 不会调用点击代理，可以用这个手动调用
        menu?.selectDefalutIndexPath()
    }

    // MARK:右键点击事件
    func menuReloadData() {
        self.classifys.removeAll()
        classifys.append(YXJCellData(title: "今日新单", detailText: "2", defaultImage: UIImage(named: "1"), select: UIImage(named: "1_select")))
        classifys.append(YXJCellData(title: "电影", detailText: "3", defaultImage: UIImage(named: "2"), select: UIImage(named: "2_select")))
        classifys.append(YXJCellData(title: "酒店", detailText: "4", defaultImage: UIImage(named: "3"), select: UIImage(named: "3_select")))
        self.menu?.reloadData()
    }
    // MARK:按钮事件
    func selectIndexPathAction(_ sender: AnyObject) {
        self.menu?.select(YXJIndexPath(col: 0, row: 2, item: 2))
    }

    // MARK:YXJDropDownMenuDelegate
    func numberOfColumns(in menu: YXJDropDownMenu!) -> Int {
        return 3
    }
    func menu(_ menu: YXJDropDownMenu!, numberOfRowsInColumn column: Int) -> Int {
        if (column == 0) {
            return self.classifys.count
        } else if (column == 1) {
            return self.areas.count
        } else {
            return self.sorts.count
        }
    }
    func menu(_ menu: YXJDropDownMenu!, configRowAt indexPath: YXJIndexPath!) -> YXJCellData! {
        if (indexPath.column == 0) {
            return self.classifys[indexPath.row]
        } else if (indexPath.column == 1) {
            return self.areas[indexPath.row]
        } else {
            return self.sorts[indexPath.row]
        }
    }
    func menu(_ menu: YXJDropDownMenu!, numberOfItemsInRow row: Int, column: Int) -> Int {
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
    func menu(_ menu: YXJDropDownMenu!, configItemsInRowAt indexPath: YXJIndexPath!) -> YXJCellData! {
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
    func menu(_ menu: YXJDropDownMenu!, didSelectRowAt indexPath: YXJIndexPath!) {
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

