//
//  LNView.swift
//  LionActions
//
//  Created by wilden on 2015/6/12.
//  Copyright (c) 2015年 Lion Infomation Technology Co.,Ltd. All rights reserved.
//

import UIKit

public enum LNTouchEvents:String{
    case TOUCH_CANCEL       = "touch_canel"
    case TOUCH_DOWN         = "touch_down"
    case TOUCH_UP_OUTSIDE   = "touch_up_outside"
    case TOUCH_UP_INSIDE    = "touch_up_inside"
    case TOUCH_MOVE         = "touch_move"
    case TOUCH_ROLL_OVER    = "touch_roll_over"
    case TOUCH_ROLL_OUT     = "touch_roll_out"
}

open class LNView: UIView {
    private var mIsTouchInside:Bool = true
    open var touchInside:Bool{
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
            self.dispatchEvent(_event)
        }else {
            let _event:Event = Event(aType: LNButtonEvents.TOUCH_UP_INSIDE.rawValue, aBubbles: true)
            self.dispatchEvent(_event)
        }
        
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let _touch:UITouch = touches.first!
        let _touchendPoint:CGPoint = _touch.location(in: self)
        let _event:Event = Event(aType: LNButtonEvents.TOUCH_MOVE.rawValue, aBubbles: true)
        self.dispatchEvent(_event)
        // print("\(_event.type)")
        if _touchendPoint.x < 0 || _touchendPoint.x > self.bounds.width || _touchendPoint.y < 0 || _touchendPoint.y > self.bounds.height {
            self.touchInside = false
        }else{
            self.touchInside = true
        }
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        let _event:Event = Event(aType: LNButtonEvents.TOUCH_CANCEL.rawValue, aBubbles: true)
        dispatchEvent(_event)
    }
    
    @discardableResult open func addTEventListener(_ aEventType: LNButtonEvents, _ aHandler:@escaping () -> Void) -> EventListener {
        let _eventType:String = aEventType.rawValue
        return self.addEventListener(_eventType, aHandler)
    }
    
    @discardableResult open func addTEventListener(_ aEventType: LNButtonEvents, _ aHandler:@escaping (_ aEvent: Event) -> Void) -> EventListener {
        let _eventType:String = aEventType.rawValue
        return self.addEventListener(_eventType, aHandler)
    }
    
}
