//
//  DetailCell.swift
//  轩辕记账本
//
//  Created by huchunyuan on 16/1/9.
//  Copyright © 2016年 huchunyuan. All rights reserved.
//

import UIKit

protocol DetailCellDelegagte{
    func endEditingPassTextField(field:UITextField)
}


class DetailCell: UITableViewCell,UITextFieldDelegate {
    var delegate:DetailCellDelegagte?
    @IBOutlet weak var textfiled: UITextField!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // 当点击return时通知代理执行代理方法
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.textfiled.resignFirstResponder()
        delegate?.endEditingPassTextField(textField)
        return true
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
