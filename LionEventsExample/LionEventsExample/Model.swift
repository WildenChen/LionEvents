//
//  Model.swift
//  SwiftSimpleProject
//
//  Created by wilden on 2015/6/2.
//  Copyright (c) 2015年 Lion Infomation Technology Co.,Ltd. Wilden. All rights reserved.
//

import Foundation
import LionEvents
class Model:EventDispatcher {
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