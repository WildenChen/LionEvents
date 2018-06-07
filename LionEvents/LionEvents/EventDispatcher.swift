//
//  EventDispatcher.swift
//  LionEvents
//
//  Created by wilden on 2015/6/4.
//  Copyright (c) 2015年 Lion Infomation Technology Co.,Ltd. Wilden. All rights reserved.
//

import Foundation
open class EventDispatcher {
    private var mListeners:[String:[EventListener]]
    public var listener:[String:[EventListener]]{
        return mListeners
    }
    
    public init(){
        mListeners = [String:[EventListener]]()
    }
    
    deinit{
        mListeners.removeAll()
    }
    
    @discardableResult open func addEventListener(_ aEventName:String, _ aHandler:@escaping () -> Void) -> EventListener {
        let _newListener:EventListener = EventListener(aHandler: aHandler)
        var _newListeners:[EventListener] = (mListeners[aEventName] == nil) ? [EventListener]() : mListeners[aEventName]!
        _newListeners.append(_newListener)
        mListeners.updateValue(_newListeners, forKey: aEventName)
        return _newListener
    }
    
    @discardableResult open func addEventListener(_ aEventName:String, _ aHandler:@escaping (_ aEvent:Event) -> Void) -> EventListener {
        let _id = aHandler
        print("addEventListener:\(_id)")
        let _newListener:EventListener = EventListener(aHandler: aHandler)
        var _newListeners:[EventListener] = (mListeners[aEventName] == nil) ? [EventListener]() : mListeners[aEventName]!
        _newListeners.append(_newListener)
        mListeners.updateValue(_newListeners, forKey: aEventName)
        return _newListener
    }
    
    //    open func removeEventListener(_ aEventName:String, aHanlder:Selector){
    //        if let _listeners:[EventListener] = mListeners[aEventName] {
    //            var _nowListeners:[EventListener] = _listeners
    //            for (_index, _listener) in _nowListeners.enumerated() {
    //                if _listener.atHandler == aHanlder {
    //                    _nowListeners.remove(at: _index)
    //                }
    //            }
    //
    //            if _nowListeners.count == 0 {
    //                mListeners.removeValue(forKey: aEventName)
    //            }else{
    //                mListeners.updateValue(_nowListeners, forKey: aEventName)
    //            }
    //        }
    //    }
    
    open func removeEventListener(_ aEventName:String, aListener:EventListener){
        if let _listeners:[EventListener] = mListeners[aEventName] {
            var _nowListeners:[EventListener] = _listeners
            if let _index:Int = _nowListeners.index(of: aListener)   {
                _nowListeners.remove(at: _index)
            }
            
            if _nowListeners.count == 0 {
                mListeners.removeValue(forKey: aEventName)
            }else{
                mListeners.updateValue(_nowListeners, forKey: aEventName)
            }
        }
    }
    
    open func removeEventListener(_ aEventName:String?){
        if aEventName == nil {
            mListeners.removeAll(keepingCapacity: false)
        }else{
            if let _listeners:[EventListener] = mListeners[aEventName!] {
                var _newListeners:[EventListener] = _listeners
                _newListeners.removeAll(keepingCapacity: false)
            }
            mListeners.removeValue(forKey: aEventName!)
        }
    }
    
    @discardableResult open func dispatchEvent(_ aEvent:Event) -> Bool {
        var _result:Bool = false
        if let _listeners:[EventListener] = mListeners[aEvent.type]{
            for _listener in _listeners {
                if let _handler:() -> Void = _listener.handler {
                    _handler()
                    _result = true
                }else if let _handler:(_ aEvent:Event) -> Void = _listener.eventHandler{
                    if aEvent.currentTarget == nil {
                        aEvent.setCurrentTarget(self)
                    }
                    
                    if aEvent.target == nil {
                        aEvent.setTarget(self)
                    }
                    _handler(aEvent)
                    _result = true
                }
            }
        }
        return _result
    }
    
    open func hasEventListener(_ aEventName:String) -> Bool {
        var _result:Bool = false
        if let _listeners:[EventListener] = mListeners[aEventName] {
            _result = (_listeners.count != 0) ? true : false
        }
        return _result
    }
    
    func hasEventListeners() -> Bool {
        return (mListeners.count > 0)
    }
}
