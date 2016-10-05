//
//  Event.swift
//  LionEvents
//
//  Created by wilden on 2015/6/10.
//  Copyright (c) 2015年 Lion Infomation Technology Co.,Ltd. All rights reserved.
//

import Foundation

open class Event:CustomStringConvertible {
    //public static let CHANGE    :String = "event_change"
    //public static let COMPLETE  :String = "event_complete"
    //public static let ERROR     :String = "event_error"
    
    private weak var mTarget:AnyObject?
    open var target:Any? {
        return mTarget
    }
    
    private weak var mCurrentTarget:AnyObject?
    open var currentTarget:Any? {
        return mCurrentTarget
    }
    
    private var mType:String
    open var type:String {
        return mType
    }
    
    private var mBubbles:Bool
    open var bubbles:Bool {
        return mBubbles
    }
    
    private var mStopsPropagation:Bool = false
    var stopsPropagation:Bool {
        return mStopsPropagation
    }
    
    private var mStopsImmediatePropagation:Bool = false
    var stopsImmediatePropagation:Bool {
        return mStopsImmediatePropagation
    }
    
    open var information:Any?
    
    public init(aType:String,aBubbles:Bool = true) {
        mType = aType
        mBubbles = aBubbles
    }
    
    open func stopPropagation() {
        mStopsPropagation = true
    }
    
    open func stopImmediatePropagation() {
        mStopsImmediatePropagation = true
        mStopsPropagation = true
    }
    
    open func toString() -> String {
        return "\(type(of: self)) type=\(mType) bubbles=\(mBubbles)"
    }
    
    open func setTarget(_ aTarget:AnyObject){
        mTarget = aTarget
    }
    
    open func setCurrentTarget(_ aCurrentTarget:AnyObject) {
        mCurrentTarget = aCurrentTarget
    }
    
    open var description:String {
        return self.toString()
    }
    
//    var className:String {
//        return NSStringFromClass(self.dynamicType).componentsSeparatedByString(".").last! as String
//    }
    
    deinit{
        //print("event deinit")
        mTarget = nil
        mCurrentTarget = nil
        information = nil
    }
}
