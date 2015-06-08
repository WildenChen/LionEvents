//
//  TestViewController.swift
//  SwiftSimpleProject
//
//  Created by wilden on 2015/6/4.
//  Copyright (c) 2015年 Lion Infomation Technology Co.,Ltd. Wilden. All rights reserved.
//

import UIKit
import LionEvents
class TestViewController: UIViewController {
    private var mLionEventsButton:UIButton = UIButton()
    private var mAppleNotificationButton:UIButton = UIButton()
    private var mModel:Model = Model()
    private var mResultLabel:UILabel = UILabel()
    private var mContainer:UIView = UIView()
    private var mDate:NSDate!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        let _boardWidth:CGFloat = 10.0
        let _buttonHeight:CGFloat = 60.0
        let _buttonWidth:CGFloat = (self.view.frame.width - _boardWidth * 3.0) / 2.0
        
        mLionEventsButton.frame = CGRectMake(_boardWidth, self.view.frame.height - _boardWidth - _buttonHeight, _buttonWidth, _buttonHeight)
        mLionEventsButton.backgroundColor = UIColor.redColor()
        mLionEventsButton.setTitle("Lion Events", forState: UIControlState.Normal)
        self.view.addSubview(mLionEventsButton)
        
        mAppleNotificationButton.frame = CGRectMake(_boardWidth * 2.0 + _buttonWidth, self.view.frame.height - _boardWidth - _buttonHeight, _buttonWidth, _buttonHeight)
        mAppleNotificationButton.backgroundColor = UIColor.redColor()
        mAppleNotificationButton.setTitle("Apple Notification", forState: UIControlState.Normal)
        self.view.addSubview(mAppleNotificationButton)
        
        mResultLabel.frame = CGRectMake(_boardWidth, mLionEventsButton.frame.origin.y - 40.0, self.view.frame.width - _boardWidth * 2.0, 40.0)
        mResultLabel.text = "\(mModel.index)"
        mResultLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(mResultLabel)
        
        mContainer.frame = CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height - mResultLabel.frame.origin.y)
        self.view.addSubview(mContainer)
        
        mModel.addEventListener(Model.ADD, aHandler:doLNEvent)
//        mModel.addEventListener(Model.ADD, aHandler:onModelChangeHandler)
//        mModel.addEventListener(Model.DEC, aHandler:onModelChangeHandler)
//        
        mLionEventsButton.addEventListener(LNButtonEvents.TOUCH_UP_INSIDE, aHandler: onLionEventHandler)
        mAppleNotificationButton.addEventListener(LNButtonEvents.TOUCH_UP_INSIDE, aHandler: onAppleNotificationHandler)
//        
        //mModel.index++
        mDate = NSDate()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("recordDuringSeconds"), name: "change", object: nil)
    }
    
    private func onLionEventHandler(){
        doLNEvent()
        doAppleNotice()
    }
    
    private func onAppleNotificationHandler(){
        doAppleNotice()
    }
    
    private func createAppleNotify(){
        NSNotificationCenter.defaultCenter().postNotificationName("change", object: nil)
    }
    
    
    func doLNEvent(){
        if mModel.index < 5000 {
            //println("mModel.index:\(mModel.index)")
            var _view:TestView = TestView()
            _view.backgroundColor = UIColor.grayColor()
            _view.layer.borderColor = UIColor.whiteColor().CGColor
            _view.layer.borderWidth = 1.0
            var _x:CGFloat = CGFloat(mModel.index % 60) * 5.0
            var _y:CGFloat = CGFloat(mModel.index / 60) * 5.0
            _view.frame = CGRectMake(_x, _y, 5.0, 5.0)
            mContainer.addSubview(_view)
            _view.addEventListener(TestView.ADDED, aHandler: { () -> Void in
                self.mModel.index++
            })
        }else{
            let _currentDate:NSDate = NSDate()
            let _result:Double = _currentDate.timeIntervalSinceDate(mDate)
            println("doLNEvent:\(_result)")
        }
    }
    
    private var mNoticyTotla:Int = 0
    func doAppleNotice(){
        if mNoticyTotla < 5000 {
            //println("mModel.index:\(mModel.index)")
            var _view:TestView = TestView()
            _view.backgroundColor = UIColor.grayColor()
            _view.layer.borderColor = UIColor.whiteColor().CGColor
            _view.layer.borderWidth = 1.0
            var _x:CGFloat = CGFloat(mNoticyTotla % 60) * 5.0
            var _y:CGFloat = CGFloat(mNoticyTotla / 60) * 5.0
            _view.frame = CGRectMake(_x, _y, 5.0, 5.0)
            mContainer.addSubview(_view)
            
            _view.addEventListener(TestView.ADDED, aHandler: { () -> Void in
                self.mNoticyTotla++
                NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("doAppleNotice"), name: "apple_added", object: _view)
            })
            
            //NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("doAppleNotice"), name: "apple_added", object: _view)
        }else{
            let _currentDate:NSDate = NSDate()
            let _result:Double = _currentDate.timeIntervalSinceDate(mDate)
            println("doAppleNotice:\(_result)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class TestView: UIView {
    static let ADDED:String = "added"
    override func layoutSubviews() {
        self.dispatchEvent(TestView.ADDED)
        NSNotificationCenter.defaultCenter().postNotificationName("apple_added", object: self)
    }
}
