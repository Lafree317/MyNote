//
//  DetailTableViewController.swift
//  轩辕记账本
//
//  Created by huchunyuan on 16/1/9.
//  Copyright © 2016年 huchunyuan. All rights reserved.
//

import UIKit

class DetailTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,DetailCellDelegagte {
    var cellArr = NSMutableArray()
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // 需要先调用init方法
        PathHandle.shareSingleOne
        
        self.tableview .registerNib(UINib.init(nibName: "DetailCell", bundle: nil), forCellReuseIdentifier:kDetailCell)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return PathHandle.shareSingleOne.allKeys.count
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return PathHandle.shareSingleOne.passSectionBackTheRows(section).count
    }


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kDetailCell, forIndexPath: indexPath) as! DetailCell
        cell.textfiled.placeholder = "\(indexPath.row)"
        
        let model = PathHandle.shareSingleOne.passIndexPathBackTheModel(indexPath)
        cell.title.text = model.title
        cell.delegate = self
        // 将cell添加到cell数组中
        cellArr.addObject(cell)

        

        return cell
    }
    // cell的代理方法
    func endEditingPassTextField(field: UITextField) {
        for  i in 0..<cellArr.count - 1{
            // 遍历cell数组
            let cell =  cellArr[i] as! DetailCell
            
            if cell.textfiled == field{
                // 找到当前相同的下一个cell 开始编辑
                let cell2 =  cellArr[i+1] as! DetailCell
                cell2.textfiled.becomeFirstResponder()
            }
        }
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        // 添加区尾
        let footer = UIView(frame: CGRectMake(0,0,100,30))
        let button = UIButton(type: UIButtonType.System)
        button.addTarget(self, action: Selector("buttonClick:"), forControlEvents: UIControlEvents.TouchDown)
        button.frame = CGRectMake(0, 0, 100, 30);
        button.setTitle("加一项", forState: UIControlState.Normal)
        button.tag = 1000+section

        footer.addSubview(button)
        return footer
    }
    func buttonClick(button:UIButton){

        PathHandle.shareSingleOne.addSection(button.tag-1000)
        self.detailReloadData()
    }
    // reloadData时清空cell数组
    func detailReloadData(){
        self.cellArr = NSMutableArray()
        self.tableview.reloadData()
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
