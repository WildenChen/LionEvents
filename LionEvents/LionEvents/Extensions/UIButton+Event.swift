//
//  UIButton+Event.swift
//  SwiftSimpleProject
//
//  Created by wilden on 2015/6/1.
//  Copyright (c) 2015年 Lion Infomation Technology Co.,Ltd. Wilden. All rights reserved.
//

import Foundation
import UIKit

public enum LNButtonEvents:String{
    case TOUCH_CANCEL       = "touch_canel"
    case TOUCH_DOWN         = "touch_down"
    case TOUCH_DOWN_REPEAT  = "touch_down_repeat"
    case TOUCH_DRAG_ENTER   = "touch_drag_enter"
    case TOUCH_DRAG_EXIT    = "touch_drag_exit"
    case TOUCH_DRAG_INSIDE  = "touch_drag_inside"
    case TOUCH_DRAG_OUTSIDE = "touch_drag_outside"
    case TOUCH_UP_OUTSIDE   = "touch_up_outside"
    case TOUCH_UP_INSIDE    = "touch_up_inside"
    case ALL_TOUCH_EVENTS   = "all_touch_events"
}

extension UIButton {
    public func addEventListener(aEventType:LNButtonEvents, _ aHandler: () -> Void) -> EventListener{
        switch aEventType {
        case LNButtonEvents.TOUCH_CANCEL:
            self.addTarget(self, action: Selector("onTouchCanel:"), forControlEvents: UIControlEvents.TouchCancel)
        case LNButtonEvents.TOUCH_DOWN:
            self.addTarget(self, action: Selector("onTouchDown:"), forControlEvents: UIControlEvents.TouchDown)
        case LNButtonEvents.TOUCH_DOWN_REPEAT:
            self.addTarget(self, action: Selector("onTouchDownRepeat:"), forControlEvents: UIControlEvents.TouchDownRepeat)
        case LNButtonEvents.TOUCH_DRAG_ENTER:
            self.addTarget(self, action: Selector("onTouchDragEnter:"), forControlEvents: UIControlEvents.TouchDragEnter)
        case LNButtonEvents.TOUCH_DRAG_EXIT:
            self.addTarget(self, action: Selector("onTouchDragExit:"), forControlEvents: UIControlEvents.TouchDragExit)
        case LNButtonEvents.TOUCH_DRAG_INSIDE:
            self.addTarget(self, action: Selector("onTouchDragInside:"), forControlEvents: UIControlEvents.TouchDragInside)
        case LNButtonEvents.TOUCH_DRAG_OUTSIDE:
            self.addTarget(self, action: Selector("onTouchDragOutside:"), forControlEvents: UIControlEvents.TouchDragOutside)
        case LNButtonEvents.TOUCH_UP_OUTSIDE:
            self.addTarget(self, action: Selector("onTouchUpOutside:"), forControlEvents: UIControlEvents.TouchUpOutside)
        case LNButtonEvents.TOUCH_UP_INSIDE:
            self.addTarget(self, action: Selector("onTouchUpInside:"), forControlEvents: UIControlEvents.TouchUpInside)
        case LNButtonEvents.ALL_TOUCH_EVENTS:
            self.addTarget(self, action: Selector("onAllTouchEvents:"), forControlEvents: UIControlEvents.AllTouchEvents)
        }
        
        let _eventType:String = aEventType.rawValue
        let _listener:EventListener = self.addEventListener(_eventType, aHandler)
        return _listener
    }
    
    public func addEventListener(aEventType:LNButtonEvents, _ aHandler: (aEvent: LNEvent) -> Void) -> EventListener{
        switch aEventType {
        case LNButtonEvents.TOUCH_CANCEL:
            self.addTarget(self, action: Selector("onTouchCanel:"), forControlEvents: UIControlEvents.TouchCancel)
        case LNButtonEvents.TOUCH_DOWN:
            self.addTarget(self, action: Selector("onTouchDown:"), forControlEvents: UIControlEvents.TouchDown)
        case LNButtonEvents.TOUCH_DOWN_REPEAT:
            self.addTarget(self, action: Selector("onTouchDownRepeat:"), forControlEvents: UIControlEvents.TouchDownRepeat)
        case LNButtonEvents.TOUCH_DRAG_ENTER:
            self.addTarget(self, action: Selector("onTouchDragEnter:"), forControlEvents: UIControlEvents.TouchDragEnter)
        case LNButtonEvents.TOUCH_DRAG_EXIT:
            self.addTarget(self, action: Selector("onTouchDragExit:"), forControlEvents: UIControlEvents.TouchDragExit)
        case LNButtonEvents.TOUCH_DRAG_INSIDE:
            self.addTarget(self, action: Selector("onTouchDragInside:"), forControlEvents: UIControlEvents.TouchDragInside)
        case LNButtonEvents.TOUCH_DRAG_OUTSIDE:
            self.addTarget(self, action: Selector("onTouchDragOutside:"), forControlEvents: UIControlEvents.TouchDragOutside)
        case LNButtonEvents.TOUCH_UP_OUTSIDE:
            self.addTarget(self, action: Selector("onTouchUpOutside:"), forControlEvents: UIControlEvents.TouchUpOutside)
        case LNButtonEvents.TOUCH_UP_INSIDE:
            self.addTarget(self, action: Selector("onTouchUpInside:"), forControlEvents: UIControlEvents.TouchUpInside)
        case LNButtonEvents.ALL_TOUCH_EVENTS:
            self.addTarget(self, action: Selector("onAllTouchEvents:"), forControlEvents: UIControlEvents.AllTouchEvents)
        }
        
        let _eventType:String = aEventType.rawValue
        let _listener:EventListener = self.addEventListener(_eventType, aHandler)
        return _listener
    }
    
    
    @objc private func onTouchCanel(aSender:UIButton){
        self.dispatchEvent(LNButtonEvents.TOUCH_CANCEL.rawValue)
    }
    
    @objc private func onTouchDown(aSender:UIButton){
        self.dispatchEvent(LNButtonEvents.TOUCH_DOWN.rawValue)
    }
    
    @objc private func onTouchDownRepeat(aSender:UIButton){
        self.dispatchEvent(LNButtonEvents.TOUCH_DOWN_REPEAT.rawValue)
    }
    
    @objc private func onTouchDragEnter(aSender:UIButton){
        self.dispatchEvent(LNButtonEvents.TOUCH_DRAG_ENTER.rawValue)
    }
    
    @objc private func onTouchDragExit(aSender:UIButton){
        self.dispatchEvent(LNButtonEvents.TOUCH_DRAG_EXIT.rawValue)
    }
    
    @objc private func onTouchDragInside(aSender:UIButton){
        self.dispatchEvent(LNButtonEvents.TOUCH_DRAG_INSIDE.rawValue)
    }
    
    @objc private func onTouchDragOutside(aSender:UIButton){
        self.dispatchEvent(LNButtonEvents.TOUCH_DRAG_OUTSIDE.rawValue)
    }
    
    @objc private func onTouchUpOutside(aSender:UIButton){
        self.dispatchEvent(LNButtonEvents.TOUCH_UP_OUTSIDE.rawValue)
    }
    
    @objc private func onTouchUpInside(aSender:UIButton){
        self.dispatchEvent(LNButtonEvents.TOUCH_UP_INSIDE.rawValue)
    }
    
    @objc private func onAllTouchEvents(aSender:UIButton){
        self.dispatchEvent(LNButtonEvents.ALL_TOUCH_EVENTS.rawValue)
    }
    
    public func removeAllEventListener(){
        self.removeEventListener(nil)
        self.removeTarget(self, action: Selector("onTouchCanel:"), forControlEvents: UIControlEvents.TouchCancel)
        self.removeTarget(self, action: Selector("onTouchDown:"), forControlEvents: UIControlEvents.TouchDown)
        self.removeTarget(self, action: Selector("onTouchDownRepeat:"), forControlEvents: UIControlEvents.TouchDownRepeat)
        self.removeTarget(self, action: Selector("onTouchDragEnter:"), forControlEvents: UIControlEvents.TouchDragEnter)
        self.removeTarget(self, action: Selector("onTouchDragExit:"), forControlEvents: UIControlEvents.TouchDragExit)
        self.removeTarget(self, action: Selector("onTouchDragInside:"), forControlEvents: UIControlEvents.TouchDragInside)
        self.removeTarget(self, action: Selector("onTouchDragOutside:"), forControlEvents: UIControlEvents.TouchDragOutside)
        self.removeTarget(self, action: Selector("onTouchUpOutside:"), forControlEvents: UIControlEvents.TouchUpOutside)
        self.removeTarget(self, action: Selector("onTouchUpInside:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.removeTarget(self, action: Selector("onAllTouchEvents:"), forControlEvents: UIControlEvents.AllTouchEvents)
    }
    
    public func removeEventListener(aEventType:LNButtonEvents, aListener:EventListener){
        let _eventType:String = aEventType.rawValue
        self.removeEventListener(_eventType, aListener: aListener)
        //println("\(!hasEventListener(_eventType) )")
        if !hasEventListener(_eventType) {
            self.removeEventListener(_eventType)
        }
    }
    
    public func removeEventListener(aEventType:LNButtonEvents){
        let _eventType:String = aEventType.rawValue
        self.removeEventListener(_eventType)
        switch aEventType {
        case LNButtonEvents.TOUCH_CANCEL:
            self.removeTarget(self, action: Selector("onTouchCanel:"), forControlEvents: UIControlEvents.TouchCancel)
        case LNButtonEvents.TOUCH_DOWN:
            self.removeTarget(self, action: Selector("onTouchDown:"), forControlEvents: UIControlEvents.TouchDown)
        case LNButtonEvents.TOUCH_DOWN_REPEAT:
            self.removeTarget(self, action: Selector("onTouchDownRepeat:"), forControlEvents: UIControlEvents.TouchDownRepeat)
        case LNButtonEvents.TOUCH_DRAG_ENTER:
            self.removeTarget(self, action: Selector("onTouchDragEnter:"), forControlEvents: UIControlEvents.TouchDragEnter)
        case LNButtonEvents.TOUCH_DRAG_EXIT:
            self.removeTarget(self, action: Selector("onTouchDragExit:"), forControlEvents: UIControlEvents.TouchDragExit)
        case LNButtonEvents.TOUCH_DRAG_INSIDE:
            self.removeTarget(self, action: Selector("onTouchDragInside:"), forControlEvents: UIControlEvents.TouchDragInside)
        case LNButtonEvents.TOUCH_DRAG_OUTSIDE:
            self.removeTarget(self, action: Selector("onTouchDragOutside:"), forControlEvents: UIControlEvents.TouchDragOutside)
        case LNButtonEvents.TOUCH_UP_OUTSIDE:
            self.removeTarget(self, action: Selector("onTouchUpOutside:"), forControlEvents: UIControlEvents.TouchUpOutside)
        case LNButtonEvents.TOUCH_UP_INSIDE:
            self.removeTarget(self, action: Selector("onTouchUpInside:"), forControlEvents: UIControlEvents.TouchUpInside)
        case LNButtonEvents.ALL_TOUCH_EVENTS:
            self.removeTarget(self, action: Selector("onAllTouchEvents:"), forControlEvents: UIControlEvents.AllTouchEvents)
        }
    }
    
}