//
//  EventDispatcher.swift
//  SwiftSimpleProject
//
//  Created by wilden on 2015/6/4.
//  Copyright (c) 2015年 Lion Infomation Technology Co.,Ltd. Wilden. All rights reserved.
//

import Foundation
public class EventDispatcher {
    public static var allEventDispatchers:[Int:EventDispatcher] = [Int:EventDispatcher]()
    
    private var mListeners:[String:[EventListener]] = [String:[EventListener]]()
    public var currentTarget:Any?
    
    public init(){
        
    }
    
    public func addEventListener(aEventName:String, _ aHandler:()->Void) -> EventListener {
        let _newListener:EventListener = EventListener(aHandler: aHandler)
        var _newListeners:[EventListener] = (mListeners[aEventName] == nil) ? [] : mListeners[aEventName]!
        _newListeners.append(_newListener)
        mListeners.updateValue(_newListeners, forKey: aEventName)
        return _newListener
    }
    
    public func addEventListener(aEventName:String, _ aHandler:(aEvent:LNEvent)->Void) -> EventListener {
        let _newListener:EventListener = EventListener(aHandler: aHandler)
        var _newListeners:[EventListener] = (mListeners[aEventName] == nil) ? [] : mListeners[aEventName]!
        _newListeners.append(_newListener)
        mListeners.updateValue(_newListeners, forKey: aEventName)
        return _newListener
    }
    
    public func removeEventListener(aEventName:String, aListener:EventListener){
        if let _listeners:[EventListener] = mListeners[aEventName] {
            var _nowListeners:[EventListener] = _listeners
            //if let _index:Int = _nowListeners.indexOf(aListener){
            if let _index:Int = find(_nowListeners, aListener){
                _nowListeners.removeAtIndex(_index)
            }
            
            if _nowListeners.count == 0 {   //!hasEventListener(aEventName)
                mListeners.removeValueForKey(aEventName)
            }else{
                mListeners.updateValue(_nowListeners, forKey: aEventName)
            }
        }
    }
    
    public func removeEventListener(aEventName:String?){
        if aEventName == nil {
            mListeners.removeAll(keepCapacity: false)
        }else{
            if let _listeners:[EventListener] = mListeners[aEventName!] {
                var _newListeners:[EventListener] = _listeners
                _newListeners.removeAll(keepCapacity: false)
            }
            mListeners.removeValueForKey(aEventName!)
        }
    }
    
    public func dispatchEvent(aEventName:String, _ aInformation:Any? = nil) -> Bool{
        var _result:Bool = false
        if let _listeners:[EventListener] = mListeners[aEventName]{
            for _listener in _listeners {
                if let _handler:() -> Void = _listener.handler {
                    _handler()
                    _result = true
                }else if let _handler:(aEvent:LNEvent) -> Void = _listener.eventHandler{
                    let _currentTarget:Any = (self.currentTarget == nil) ? self : currentTarget!
                    let _event:LNEvent = LNEvent(aTarget: self, aCurrentTarget: _currentTarget, aType: aEventName, aInformation: aInformation)
                    _handler(aEvent: _event)
                    _result = true
                }
            }
        }
        return _result
    }
    
    public func hasEventListener(aEventName:String) -> Bool {
        var _result:Bool = false
        if let _listeners:[EventListener] = mListeners[aEventName] {
            _result = (_listeners.count != 0) ? true : false
        }
        return _result
    }
}

public class EventListener:NSObject {
    public let handler:(() -> Void)?
    public let eventHandler:((aEvent:LNEvent) -> ())?
    
    public init(aHandler:() -> Void) {
        self.handler = aHandler
        self.eventHandler = nil
    }
    
    public init(aHandler:(aEvent:LNEvent) -> Void) {
        self.handler = nil
        self.eventHandler = aHandler
    }
}

public class LNEvent {
    public let target:Any
    public let currentTarget:Any
    public let type:String
    public var information:Any?
    //let bubbles:Bool
    //let cancelable:Bool
    //let eventPhase:UInt
    public init(aTarget:Any, aCurrentTarget:Any, aType:String, aInformation:Any? = nil){
        target = aTarget
        currentTarget = aCurrentTarget
        type = aType
        information = aInformation
    }
}