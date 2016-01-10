//
//  PathHandle.swift
//  轩辕记账本
//
//  Created by huchunyuan on 16/1/10.
//  Copyright © 2016年 huchunyuan. All rights reserved.
//

import UIKit

class PathHandle: NSObject {
    //单例

    static let shareSingleOne = PathHandle()
    

    
    let dataDic = NSMutableDictionary()
    // 记录2个类型的个数
    var amain:Int = 1
    var body:Int = 1
    
    // 获得标准字典
    var basic = NSMutableDictionary()
    
    var allKeys = NSArray()
    
    override init() {
        super.init()
        self.takOutPathData()
    }
    // 通过indexPath获得model
    func passIndexPathBackTheModel(indexPath:NSIndexPath) -> CreatDetailModel{
        let sectionArr = passSectionBackTheRows(indexPath.section)
        return sectionArr[indexPath.row] as! CreatDetailModel
    }
    func addSection(section:NSInteger){
        // 获得key
        let str = allKeys[section] as! String
        // 获得基准数组
        let basicArr = basic.valueForKey(str) as! NSMutableArray
        // 创建新增的名字后缀
        var modelStr = String()
        // 按照区数+1
        if section == 0 {
            amain =  amain+1
            modelStr = "\(amain)"
        }else{
            body = body+1
            modelStr = "\(body)"
        }
        let newArr = NSMutableArray()
        for item in basicArr{
            // 为新model赋值
            let modelOld = item as! CreatDetailModel
            
            let modelNew = CreatDetailModel()
            
            modelNew.title = modelOld.title + modelStr
            modelNew.key = modelOld.key
            modelNew.keyBoard = modelOld.keyBoard
            
            newArr.addObject(modelNew)
            
            
        }
        
        // 将数组添加到字典中
        let arr = dataDic.valueForKey(allKeys[section] as! String) as! NSMutableArray
        arr.addObjectsFromArray(newArr as [AnyObject])
        dataDic .setValue(arr, forKey: str)
    }
    func passSectionBackTheRows(section:Int) -> NSArray{
        let sectionArr = dataDic.valueForKey(allKeys[section] as! String) as! NSArray
        return sectionArr
    }
    
    func takOutPathData(){
   

        let fileUrl = NSBundle.mainBundle().URLForResource("DetailList", withExtension: "plist")
        if let url = fileUrl {

            let Dic = NSDictionary(contentsOfURL: url)
            for (key,value) in Dic!{
                let valueArr:NSMutableArray! = []
                for dic in value as! NSArray {
                    let model = CreatDetailModel()
                    model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                    valueArr.addObject(model)
                }
                // 获得基准字典 copy数组
                basic.setValue(valueArr.mutableCopy(), forKeyPath: key as! String)
                // 总字典
                dataDic.setValue(valueArr, forKey: key as! String)
                
            }
        }

        allKeys = dataDic.allKeys
        // 排序allkeys
        allKeys = allKeys.sortedArrayUsingSelector(Selector("compare:"))
        print(allKeys)
    }
}
