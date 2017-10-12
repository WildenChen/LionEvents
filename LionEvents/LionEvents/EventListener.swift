//
//  EventListener.swift
//  LionEvents
//
//  Created by wilden on 2016/5/23.
//  Copyright © 2016年 Lion Infomation Technology Co.,Ltd. All rights reserved.
//

open class EventListener:NSObject {
    @objc open let handler:(() -> Void)?
    open let eventHandler:((_ aEvent:Event) -> ())?
    
    @objc public init(aHandler:@escaping () -> Void) {
        self.handler = aHandler
        self.eventHandler = nil
        super.init()
    }
    
    public init(aHandler:@escaping (_ aEvent:Event) -> Void) {
        self.handler = nil
        self.eventHandler = aHandler
        super.init()
    }
}
