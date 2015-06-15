//
//  MainButton.swift
//  LionEventsExample
//
//  Created by wilden on 2015/6/12.
//  Copyright (c) 2015年 Lion Infomation Technology Co.,Ltd. All rights reserved.
//

import UIKit
import LionEvents
class MainButton: LNView {

    private var mTitle:UILabel = UILabel()
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        mTitle.frame = CGRectMake(0, 0, rect.width, 20.0)
        mTitle.textColor = UIColor.whiteColor()
        mTitle.text = "AAAAAAA"
        mTitle.textAlignment = NSTextAlignment.Right
        self.addSubview(mTitle)
        
    }


}
