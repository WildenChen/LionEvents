//
//  NSObject+Event.swift
//  LionEvents
//
//  Created by wilden on 2015/6/1.
//  Copyright (c) 2015年 Lion Infomation Technology Co.,Ltd. Wilden. All rights reserved.
//
import UIKit
import Foundation

extension NSObject {
    public static var allEventDispatchers:[Int:EventDispatcher] = [Int:EventDispatcher]()
    
    public func addEventListener(aEventName:String, _ aHandler:()->Void) -> EventListener{
        var _newListener:EventListener?
        if let _eventDispatcher:EventDispatcher = NSObject.allEventDispatchers[self.hash] {
            _newListener = _eventDispatcher.addEventListener(aEventName, aHandler)
        }else{
            let _eventDispatcher:EventDispatcher = EventDispatcher()
            _newListener = _eventDispatcher.addEventListener(aEventName, aHandler)
            NSObject.allEventDispatchers.updateValue(_eventDispatcher, forKey: self.hash)
        }
        return _newListener!
    }
    
    public func addEventListener(aEventName:String, _ aHandler:(aEvent:Event)->Void) -> EventListener{
        var _newListener:EventListener?
        if let _eventDispatcher:EventDispatcher = NSObject.allEventDispatchers[self.hash] {
            _newListener = _eventDispatcher.addEventListener(aEventName, aHandler)
        }else{
            let _eventDispatcher:EventDispatcher = EventDispatcher()
            _newListener = _eventDispatcher.addEventListener(aEventName, aHandler)
            NSObject.allEventDispatchers.updateValue(_eventDispatcher, forKey: self.hash)
        }
        return _newListener!
    }
    
    public func removeEventListener(aEventName:String, _ aListener:EventListener){
        if let _eventDispatcher:EventDispatcher = NSObject.allEventDispatchers[self.hash] {
            _eventDispatcher.removeEventListener(aEventName, aListener: aListener)
        }
    }
    
    public func removeEventListener(aEventName:String?){
        if let _eventDispatcher:EventDispatcher = NSObject.allEventDispatchers[self.hash] {
            _eventDispatcher.removeEventListener(aEventName)
            if !_eventDispatcher.hasEventListeners() {
                NSObject.allEventDispatchers.removeValueForKey(self.hash)
            }
        }
    }
    
    public func dispatchEvent(aEvent:Event) -> Bool {
        var _result:Bool = false
        if aEvent.bubbles && self is UIView {
            let _view:UIView = self as! UIView
            if let _parent:UIView = _view.superview {
                if aEvent.target == nil {
                    aEvent.setTarget(self)
                }
                _parent.dispatchEvent(aEvent)
            }
        }
        if let _eventDispatcher:EventDispatcher = NSObject.allEventDispatchers[self.hash] {
            aEvent.setCurrentTarget(self)
            _result = _eventDispatcher.dispatchEvent(aEvent)
        }
        return _result
    }
    
    public func hasEventListener(aEventName:String) -> Bool {
        var _result:Bool = false
        if let _eventDispatcher:EventDispatcher = NSObject.allEventDispatchers[self.hash] {
            _result = _eventDispatcher.hasEventListener(aEventName)
        }
        return _result
    }
}