//
//  NSObject+Event.swift
//  LionEvents
//
//  Created by wilden on 2015/6/1.
//  Copyright (c) 2015年 Lion Infomation Technology Co.,Ltd. Wilden. All rights reserved.
//
import UIKit
import Foundation

public extension NSObject {
    public static var allEventDispatchers:[Int:EventDispatcher] = [Int:EventDispatcher]()
    
    @discardableResult public func addEventListener(_ aEventName:String, _ aHandler:@escaping ()->Void) -> EventListener{
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
    
    @discardableResult public func addEventListener(_ aEventName:String, _ aHandler:@escaping (_ aEvent:Event)->Void) -> EventListener{
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
    
    public func removeEventListener(_ aEventName:String, _ aListener:EventListener){
        if let _eventDispatcher:EventDispatcher = NSObject.allEventDispatchers[self.hash] {
            _eventDispatcher.removeEventListener(aEventName, aListener: aListener)
        }
    }
    
    public func removeEventListener(_ aEventName:String?){
        if let _eventDispatcher:EventDispatcher = NSObject.allEventDispatchers[self.hash] {
            _eventDispatcher.removeEventListener(aEventName)
            if !_eventDispatcher.hasEventListeners() {
                NSObject.allEventDispatchers.removeValue(forKey: self.hash)
            }
        }
    }
    
    @discardableResult public func dispatchEvent(_ aEvent:Event) -> Bool {
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
    
    public func hasEventListener(_ aEventName:String) -> Bool {
        var _result:Bool = false
        if let _eventDispatcher:EventDispatcher = NSObject.allEventDispatchers[self.hash] {
            _result = _eventDispatcher.hasEventListener(aEventName)
        }
        return _result
    }
}
