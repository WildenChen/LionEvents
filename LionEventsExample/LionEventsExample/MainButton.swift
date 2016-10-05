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

    fileprivate var mTitle:UILabel = UILabel()
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        mTitle.frame = CGRect(x: 0, y: 0, width: rect.width, height: 20.0)
        mTitle.textColor = UIColor.white
        mTitle.text = "AAAAAAA"
        mTitle.textAlignment = NSTextAlignment.right
        self.addSubview(mTitle)
        
    }

    deinit{
        print("MainButton.deinit")
    }
}
