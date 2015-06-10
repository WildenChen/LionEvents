//
//  UISwitch+Event.swift
//  SwiftSimpleProject
//
//  Created by KevinChang on 2015/6/3.
//  Copyright (c) 2015年 Lion Information Technology Co.,Ltd. KevinChang. All rights reserved.
//

import UIKit

public enum LNSwitchEvents:String{
    case CHANGED = "value_changed"
}

extension UISwitch {
    public func addEventListener(aEventType:LNSwitchEvents, _ aHandler: () -> Void) -> EventListener{
        switch aEventType {
        case LNSwitchEvents.CHANGED:
            self.addTarget(self, action: Selector("onValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        }
        
        let _eventType:String = aEventType.rawValue
        let _listener:EventListener = self.addEventListener(_eventType, aHandler)
        return _listener
    }
    
    public func addEventListener(aEventType:LNSwitchEvents, _ aHandler: (aEvent: LNEvent) -> Void) -> EventListener{
        switch aEventType {
        case LNSwitchEvents.CHANGED:
            self.addTarget(self, action: Selector("onValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        }
        
        let _eventType:String = aEventType.rawValue
        let _listener:EventListener = self.addEventListener(_eventType, aHandler)
        return _listener
    }
    
    @objc private func onValueChanged(aSender:UISwitch){
        self.dispatchEvent(LNSwitchEvents.CHANGED.rawValue)
    }
    
    public func removeEventListener(aEventType:LNSwitchEvents, aListener:EventListener){
        let _eventType:String = aEventType.rawValue
        self.removeEventListener(_eventType, aListener: aListener)
        if !hasEventListener(_eventType) {
            self.removeEventListener(_eventType)
        }
    }
    
    public func removeAllEventListener(){
        self.removeEventListener(nil)
    }
    
    public func removeEventListener(aEventType:LNSwitchEvents){
        let _eventType:String? = aEventType.rawValue
        self.removeEventListener(_eventType)
    }
    
}
