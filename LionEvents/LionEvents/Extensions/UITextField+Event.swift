//
//  UITextField+Event.swift
//  SwiftSimpleProject
//
//  Created by KevinChang on 2015/6/3.
//  Copyright (c) 2015年 Lion Information Technology Co.,Ltd. KevinChang. All rights reserved.
//

import UIKit

public enum LNTextFieldEvents:String{
    case EDITING_CHANGED = "editing_changed"
}

//UITextFieldTextDidBeginEditingNotification
//UITextFieldTextDidChangeNotification
//UITextFieldTextDidEndEditingNotification
//UIKeyboardWillShowNotification
//UIKeyboardDidShowNotification
//UIKeyboardWillHideNotification
//UIKeyboardDidHideNotification

extension UITextField {
    public func addEventListener(aEventType:LNTextFieldEvents, aHandler: () -> Void) -> EventListener{
        switch aEventType {
        case LNTextFieldEvents.EDITING_CHANGED:
            self.addTarget(self, action: Selector("onEditingChangedEvents:"), forControlEvents: UIControlEvents.EditingChanged)
        default:
            break
        }
        
        let _eventType:String = aEventType.rawValue
        var _listener:EventListener = self.addEventListener(_eventType, aHandler: aHandler)
        return _listener
    }
    
    public func addEventListener(aEventType:LNTextFieldEvents, aHandler: (aEvent: LNEvent) -> Void) -> EventListener{
        switch aEventType {
        case LNTextFieldEvents.EDITING_CHANGED:
            self.addTarget(self, action: Selector("onEditingChangedEvents:"), forControlEvents: UIControlEvents.EditingChanged)
        default:
            break
        }
        
        let _eventType:String = aEventType.rawValue
        var _listener:EventListener = self.addEventListener(_eventType, aHandler: aHandler)
        return _listener
    }
    
    
    @objc private func onEditingChangedEvents(aSender:UITextField){
        self.dispatchEvent(LNTextFieldEvents.EDITING_CHANGED.rawValue)
    }
    
    public func removeEventListener(aEventType:LNTextFieldEvents,aListener:EventListener){
        let _eventType:String = aEventType.rawValue
        self.removeEventListener(_eventType, aListener: aListener)
        if !hasEventListener(_eventType) {
            self.removeEventListener(_eventType)
        }
    }
    
    public func removeAllEventListener(){
        self.removeEventListener(nil)
        self.removeTarget(self, action: Selector("onEditingChangedEvents:"), forControlEvents: UIControlEvents.EditingChanged)
    }
    
    public func removeEventListener(aEventType:LNTextFieldEvents){
        let _eventType:String? = aEventType.rawValue
        self.removeEventListener(_eventType)
    }
    
}
