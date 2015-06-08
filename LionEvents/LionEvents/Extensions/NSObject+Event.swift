//
//  NSObject+Event.swift
//  SwiftSimpleProject
//
//  Created by wilden on 2015/6/1.
//  Copyright (c) 2015年 Lion Infomation Technology Co.,Ltd. Wilden. All rights reserved.
//

import Foundation

extension NSObject {
    public func addEventListener(aEventName:String, aHandler:()->Void) -> EventListener{
        var _newListener:EventListener?
        if let _eventDispatcher:EventDispatcher = EventDispatcher.allEventDispatchers[self.hash] {
            _newListener = _eventDispatcher.addEventListener(aEventName, aHandler: aHandler)
        }else{
            let _eventDispatcher:EventDispatcher = EventDispatcher()
            _eventDispatcher.currentTarget = self
            _newListener = _eventDispatcher.addEventListener(aEventName, aHandler: aHandler)
            EventDispatcher.allEventDispatchers.updateValue(_eventDispatcher, forKey: self.hash)
        }
        return _newListener!
    }
    
    public func addEventListener(aEventName:String, aHandler:(aEvent:LNEvent)->Void) -> EventListener{
        var _newListener:EventListener?
        if let _eventDispatcher:EventDispatcher = EventDispatcher.allEventDispatchers[self.hash] {
            _newListener = _eventDispatcher.addEventListener(aEventName, aHandler: aHandler)
        }else{
            let _eventDispatcher:EventDispatcher = EventDispatcher()
            _eventDispatcher.currentTarget = self
            _newListener = _eventDispatcher.addEventListener(aEventName, aHandler: aHandler)
            EventDispatcher.allEventDispatchers.updateValue(_eventDispatcher, forKey: self.hash)
        }
        return _newListener!
    }
    
    public func removeEventListener(aEventName:String,aListener:EventListener){
        if let _eventDispatcher:EventDispatcher = EventDispatcher.allEventDispatchers[self.hash] {
            _eventDispatcher.removeEventListener(aEventName, aListener: aListener)
        }
    }
    
    public func removeEventListener(aEventName:String?){
        if let _eventDispatcher:EventDispatcher = EventDispatcher.allEventDispatchers[self.hash] {
            _eventDispatcher.removeEventListener(aEventName)
            EventDispatcher.allEventDispatchers.removeValueForKey(self.hash)
        }
    }
    
    public func dispatchEvent(aEventName:String,aInformation:Any? = nil) -> Bool{
        var _result:Bool = false
        if let _eventDispatcher:EventDispatcher = EventDispatcher.allEventDispatchers[self.hash] {
            _result = _eventDispatcher.dispatchEvent(aEventName, aInformation: aInformation)
        }
        return _result
    }
    
    public func hasEventListener(aEventName:String) -> Bool {
        var _result:Bool = false
        if let _eventDispatcher:EventDispatcher = EventDispatcher.allEventDispatchers[self.hash] {
            _result = _eventDispatcher.hasEventListener(aEventName)
        }
        return _result
    }
}