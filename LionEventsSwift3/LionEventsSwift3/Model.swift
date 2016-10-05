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
    
    override init() {
        
    }
    
    fileprivate var mIndex:Int = 0
    var index:Int{
        set(value){
            if value > mIndex {
                mIndex = value
                let _event:Event = Event(aType: Model.ADD, aBubbles: false)
                //var _dic:[String:Int] = [String:Int]()
                //_dic["index"] = mIndex
                let _vo = ModelVO(aName: "hihi",aID: "\(mIndex)")
                _event.information = _vo
                dispatchEvent(_event)
                print("Model.index:\(Model.ADD)")
            }else if value < mIndex {
                mIndex = value
                let _event:Event = Event(aType: Model.DEC, aBubbles: false)
                //var _dic:[String:Int] = [String:Int]()
                //_dic["index"] = mIndex
                let _vo = ModelVO(aName: "ddd",aID: "\(mIndex)")
                _event.information = _vo
                dispatchEvent(_event)
                print("Model.index:\(Model.DEC)")
            }
        }
        get{
            return mIndex
        }
    }
    
    deinit{
        print("Model.deinit")
    }
    
}

class ModelVO {
    var name:String
    var id:String
    init(aName:String,aID:String){
        self.name = aName
        self.id = aID
    }
}
