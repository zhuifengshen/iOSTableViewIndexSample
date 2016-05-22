//
//  ViewController.swift
//  TableViewSample
//
//  Created by 张楚昭 on 16/5/17.
//  Copyright © 2016年 tianxing. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    //资源文件数据
    var dictData:NSDictionary!
    //小组名集合
    var listGroupName:NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //隐藏系统状态栏
        self.prefersStatusBarHidden()
        // Do any additional setup after loading the view, typically from a nib.
        let plistPath = NSBundle.mainBundle().pathForResource("team_dictionary", ofType: "plist")
        //获取属性列表文件中的全部数据
        self.dictData = NSDictionary(contentsOfFile: plistPath!)
        let tempList = self.dictData.allKeys as NSArray
        //对keys进行排序，字典本身乱序
        print(tempList)
        self.listGroupName = tempList.sortedArrayUsingSelector(#selector(NSString.compare(_:)))
        print(listGroupName)
    }
    
    //实现隐藏系统状态栏方法，返回true隐藏，返回false显示
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UITableViewDataSource 协议方法
    
    //返回某个节中的行数
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        //按照节索引从小组名中获得组名
        let groupName = self.listGroupName[section] as! String
        //将组名作为Key，从字典中取出球队数组集合
        let groupTeams = self.dictData[groupName] as! NSArray
        return groupTeams.count
    }
    
    //为表视图单元格提供数据
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cellIdentifier = "CellIdentifier"
//        纯代码重用单元格
        var cell:UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)  //.Default .Subtitle .Value1 .Value2 单元格四种样式
        }
//        视图中指定重用单元格
//        let cell:UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        //获得选择的节
        let section = indexPath.section
        //获得选择节中选中的行索引
        let row = indexPath.row
        //按照节索引从小组名中获得组名
        let groupName = self.listGroupName[section] as! String
        //将组名作为key,从字典中取出球队数组集合
        let groupTeam = self.dictData[groupName] as! NSArray
        //获取球队名作为列表项名
        cell.textLabel?.text = groupTeam[row] as? String
        return cell
    }
    
    /**
     表视图分节时，需提供节的数目
     
     - parameter tableView: TableView对象
     
     - returns: 节的个数
     */
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.listGroupName.count
    }
    
    /**
     表视图分节时，需提供每个节头的标题名称
     
     - parameter tableView: TableView对象
     - parameter section:   当前指向的节
     
     - returns: 节的标题
     */
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.listGroupName[section] as? String
    }
    
    /**
     为表视图提供索引
     
     - parameter tableView: TableView对象
     
     - returns: 索引数组
     */
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        let tempIndex = NSMutableArray(capacity: self.listGroupName.count)
        for item in self.listGroupName{
            let title = item.substringToIndex(1) as String
            tempIndex.addObject(title)
        }
        let reslutIndex = NSArray(array: tempIndex)
        return reslutIndex as? [String]
    }
}

