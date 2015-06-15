//
//  Event.swift
//  LionEvents
//
//  Created by wilden on 2015/6/10.
//  Copyright (c) 2015年 Lion Infomation Technology Co.,Ltd. All rights reserved.
//

import Foundation

public class Event:Printable {
    
    private var mTarget:Any?
    public var target:Any? {
        return mTarget
    }
    
    private var mCurrentTarget:Any?
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
    
    
    public var description:String {
        return self.toString()
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
        return "\(_stdlib_getDemangledTypeName(self)) type=\(mType) bubbles=\(mBubbles)"
    }
    
    func setTarget(aTarget:Any){
        mTarget = aTarget
    }
    
    func setCurrentTarget(aCurrentTarget:Any) {
        mCurrentTarget = aCurrentTarget
    }
    
    
}