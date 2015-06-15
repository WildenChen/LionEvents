//
//  LNButton.swift
//  LionActions
//
//  Created by wilden on 2015/6/12.
//  Copyright (c) 2015年 Lion Infomation Technology Co.,Ltd. All rights reserved.
//

import UIKit
import LionEvents

public typealias LNButtonEvents = LNTouchEvents

public class LNButton: UIButton {
    private var mIsTouchInside:Bool = true
    override public var touchInside:Bool{
        set(value){
            if mIsTouchInside != value {
                mIsTouchInside = value
                if mIsTouchInside {
                    let _event:Event = Event(aType: LNButtonEvents.TOUCH_ROLL_OVER.rawValue, aBubbles: true)
                    dispatchEvent(_event)
                }else{
                    let _event:Event = Event(aType: LNButtonEvents.TOUCH_ROLL_OUT.rawValue, aBubbles: true)
                    dispatchEvent(_event)
                }
            }
        }
        get{
            return mIsTouchInside
        }
    }
    
    public init(){
        super.init(frame: CGRectZero)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let _touch:UITouch = touches.first! as! UITouch
        let _event:Event = Event(aType: LNButtonEvents.TOUCH_DOWN.rawValue, aBubbles: true)
        self.dispatchEvent(_event)
    }
    
    override public func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        let _touch:UITouch = touches.first! as! UITouch
        let _touchendPoint:CGPoint = _touch.locationInView(self)
        if _touchendPoint.x < 0 || _touchendPoint.x > self.bounds.width || _touchendPoint.y < 0 || _touchendPoint.y > self.bounds.height {
            let _event:Event = Event(aType: LNButtonEvents.TOUCH_UP_OUTSIDE.rawValue, aBubbles: true)
            dispatchEvent(_event)
        }else {
            let _event:Event = Event(aType: LNButtonEvents.TOUCH_UP_INSIDE.rawValue, aBubbles: true)
            dispatchEvent(_event)
        }
        
    }
    
    override public func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        let _touch:UITouch = touches.first! as! UITouch
        let _touchendPoint:CGPoint = _touch.locationInView(self)
        let _event:Event = Event(aType: LNButtonEvents.TOUCH_MOVE.rawValue, aBubbles: true)
        dispatchEvent(_event)
        if _touchendPoint.x < 0 || _touchendPoint.x > self.bounds.width || _touchendPoint.y < 0 || _touchendPoint.y > self.bounds.height {
            self.touchInside = false
        }else{
            self.touchInside = true
        }
    }
    
    override public func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        let _event:Event = Event(aType: LNButtonEvents.TOUCH_CANCEL.rawValue, aBubbles: true)
        dispatchEvent(_event)
    }
    
    public func addEventListener(aEventType: LNButtonEvents, _ aHandler: () -> Void) -> EventListener {
        return self.addEventListener(aEventType.rawValue, aHandler)
    }
    
    public func addEventListener(aEventType: LNButtonEvents, _ aHandler: (aEvent: Event) -> Void) -> EventListener {
        return self.addEventListener(aEventType.rawValue, aHandler)
    }
    
    public func removeEventListener(aEventType: LNButtonEvents){
        self.removeEventListener(aEventType.rawValue)
    }
    
    public func removeEventListener(aEventType:LNButtonEvents, aListener:EventListener){
        let _eventType:String = aEventType.rawValue
        self.removeEventListener(_eventType, aListener: aListener)
        if !hasEventListener(_eventType) {
            self.removeEventListener(_eventType)
        }
    }
    
    public func removeAllEventListener(){
        self.removeEventListener(nil)
    }
}
