//
//  EventListener.swift
//  LionEvents
//
//  Created by wilden on 2016/5/23.
//  Copyright © 2016年 Lion Infomation Technology Co.,Ltd. All rights reserved.
//

public class EventListener:NSObject {
    public let handler:(() -> Void)?
    public let eventHandler:((aEvent:Event) -> ())?
    
    public init(aHandler:() -> Void) {
        self.handler = aHandler
        self.eventHandler = nil
        super.init()
    }
    
    public init(aHandler:(aEvent:Event) -> Void) {
        self.handler = nil
        self.eventHandler = aHandler
        super.init()
    }
}