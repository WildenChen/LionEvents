//
//  Event.swift
//  LionEvents
//
//  Created by wilden on 2015/6/10.
//  Copyright (c) 2015年 Lion Infomation Technology Co.,Ltd. All rights reserved.
//

import Foundation

public class Event:CustomStringConvertible {
    //public static let CHANGE    :String = "event_change"
    //public static let COMPLETE  :String = "event_complete"
    //public static let ERROR     :String = "event_error"
    
    private weak var mTarget:AnyObject?
    public var target:Any? {
        return mTarget
    }
    
    private weak var mCurrentTarget:AnyObject?
    public var currentTarget:Any? {
        return mCurrentTarget
    }
    
    private var mType:String
    public var type:String {
        return mType
    }
    
    private var mBubbles:Bool
    public var bubbles:Bool {
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
    
    public var information:Any?
    
    public init(aType:String,aBubbles:Bool = true) {
        mType = aType
        mBubbles = aBubbles
    }
    
    public func stopPropagation() {
        mStopsPropagation = true
    }
    
    public func stopImmediatePropagation() {
        mStopsImmediatePropagation = true
        mStopsPropagation = true
    }
    
    public func toString() -> String {
        return "\(self.dynamicType) type=\(mType) bubbles=\(mBubbles)"
    }
    
    public func setTarget(aTarget:AnyObject){
        mTarget = aTarget
    }
    
    public func setCurrentTarget(aCurrentTarget:AnyObject) {
        mCurrentTarget = aCurrentTarget
    }
    
    public var description:String {
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