//
//  LNButton.swift
//  LionActions
//
//  Created by wilden on 2015/6/12.
//  Copyright (c) 2015年 Lion Infomation Technology Co.,Ltd. All rights reserved.
//

import UIKit

public typealias LNButtonEvents = LNTouchEvents

open class LNButton: UIButton {
    private var mIsTouchInside:Bool = true
    override open var isTouchInside:Bool{
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
        super.init(frame: CGRect.zero)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let _event:Event = Event(aType: LNButtonEvents.TOUCH_DOWN.rawValue, aBubbles: true)
        self.dispatchEvent(_event)
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        let _touch:UITouch = touches.first! 
        let _touchendPoint:CGPoint = _touch.location(in: self)
        if _touchendPoint.x < 0 || _touchendPoint.x > self.bounds.width || _touchendPoint.y < 0 || _touchendPoint.y > self.bounds.height {
            let _event:Event = Event(aType: LNButtonEvents.TOUCH_UP_OUTSIDE.rawValue, aBubbles: true)
            dispatchEvent(_event)
        }else {
            let _event:Event = Event(aType: LNButtonEvents.TOUCH_UP_INSIDE.rawValue, aBubbles: true)
            dispatchEvent(_event)
        }
        
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let _touch:UITouch = touches.first! 
        let _touchendPoint:CGPoint = _touch.location(in: self)
        let _event:Event = Event(aType: LNButtonEvents.TOUCH_MOVE.rawValue, aBubbles: true)
        dispatchEvent(_event)
        if _touchendPoint.x < 0 || _touchendPoint.x > self.bounds.width || _touchendPoint.y < 0 || _touchendPoint.y > self.bounds.height {
            self.isTouchInside = false
        }else{
            self.isTouchInside = true
        }
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        let _event:Event = Event(aType: LNButtonEvents.TOUCH_CANCEL.rawValue, aBubbles: true)
        dispatchEvent(_event)
    }
    
    @discardableResult open func addEventListener(_ aEventType: LNButtonEvents, _ aHandler:@escaping () -> Void) -> EventListener {
        return self.addEventListener(aEventType.rawValue, aHandler)
    }
    
    @discardableResult open func addEventListener(_ aEventType: LNButtonEvents, _ aHandler:@escaping (_ aEvent: Event) -> Void) -> EventListener {
        return self.addEventListener(aEventType.rawValue, aHandler)
    }
    
    open func removeEventListener(_ aEventType: LNButtonEvents){
        self.removeEventListener(aEventType.rawValue)
    }
    
    open func removeEventListener(_ aEventType:LNButtonEvents, aListener:EventListener){
        let _eventType:String = aEventType.rawValue
        self.removeEventListener(_eventType, aListener)
        if !hasEventListener(_eventType) {
            self.removeEventListener(_eventType)
        }
    }
    
    @objc open func removeAllEventListener(){
        self.removeEventListener(nil)
    }
}
