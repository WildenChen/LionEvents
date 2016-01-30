//
//  ModelObject.swift
//  LionEventsExample
//
//  Created by wilden on 2015/6/8.
//  Copyright (c) 2015年 Lion Infomation Technology Co.,Ltd. All rights reserved.
//

import UIKit
import LionEvents
class ModelObject: NSObject {
    static let ADD:String = "model_add"
    static let DEC:String = "model_dec"
    
    private var mIndex:Int = 0
    var index:Int{
        set(value){
            if value > mIndex {
                mIndex = value
                let _event:Event = Event(aType: Model.ADD, aBubbles: false)
                dispatchEvent(_event)
            }else if value < mIndex {
                mIndex = value
                let _event:Event = Event(aType: Model.ADD, aBubbles: false)
                dispatchEvent(_event)
            }
        }
        get{
            return mIndex
        }
    }
}
