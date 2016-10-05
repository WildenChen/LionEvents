//
//  MainViewController.swift
//  SwiftSimpleProject
//
//  Created by wilden on 2015/5/26.
//  Copyright (c) 2015年 Lion Infomation Technology Co.,Ltd. Wilden. All rights reserved.
//

import UIKit
import LionEvents
class MainViewController: UIViewController {
    fileprivate var mAddbutton:LNButton = LNButton()
    fileprivate var mDecbutton:LNButton = LNButton()
    
    fileprivate var mModel:Model? = Model()
    fileprivate var mResultLabel:UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let _boardWidth:CGFloat = 10.0
        let _buttonHeight:CGFloat = 60.0
        let _buttonWidth:CGFloat = (self.view.frame.width - _boardWidth * 3.0) / 2.0
        
        mAddbutton.frame = CGRect(x: _boardWidth, y: self.view.frame.height - _boardWidth - _buttonHeight, width: _buttonWidth, height: _buttonHeight)
        mAddbutton.addEventListener(LNButtonEvents.TOUCH_UP_INSIDE, onAddDecButtonHandler)
        mAddbutton.backgroundColor = UIColor.red
        mAddbutton.setTitle("+1", for: UIControlState.normal)
        self.view.addSubview(mAddbutton)
        
        mDecbutton.frame = CGRect(x: _boardWidth * 2.0 + _buttonWidth, y: self.view.frame.height - _boardWidth - _buttonHeight, width: _buttonWidth, height: _buttonHeight)
        mDecbutton.addEventListener(LNButtonEvents.TOUCH_UP_INSIDE, onAddDecButtonHandler)
        mDecbutton.backgroundColor = UIColor.red
        mDecbutton.setTitle("-1", for: UIControlState.normal)
        self.view.addSubview(mDecbutton)
        
        mResultLabel.frame = CGRect(x: _boardWidth, y: mAddbutton.frame.origin.y - 40.0, width: self.view.frame.width - _boardWidth * 2.0, height: 40.0)
        mResultLabel.text = "\(mModel!.index)"
        mResultLabel.textAlignment = NSTextAlignment.center
        self.view.addSubview(mResultLabel)
        
        //mModel?.addEventListener(addEventListener
        
        mModel?.addEventListener(Model.ADD, onModelChangeHandler)
        mModel?.addEventListener(Model.DEC, onModelChangeHandler)
        
        
        let _mainButton:MainButton = MainButton()
        _mainButton.backgroundColor = UIColor.red
        _mainButton.frame = CGRect(x: 10, y: 90, width: self.view.frame.width - 20, height: 100)
        //_mainButton.addEventListener(LNTouchEvents.TOUCH_UP_INSIDE, onMainButtonHandler)
        self.view.addSubview(_mainButton)
        
        let _sceondButton:LNView = LNView()
        _sceondButton.backgroundColor = UIColor.yellow
        _sceondButton.frame = CGRect(x: 20, y: 20, width: _mainButton.frame.width - 40, height: _mainButton.frame.height - 40)
        _mainButton.addSubview(_sceondButton)
        
        let _tButton:LNView = LNView()
        _tButton.backgroundColor = UIColor.green
        _tButton.frame = CGRect(x: 30, y: 50, width: _sceondButton.frame.width - 40, height: _sceondButton.frame.height - 30)
        _sceondButton.addSubview(_tButton)
        
        
        
        //var _eventHandler:(aEvent:Event) -> () = onAddDecButtonHandler
        //_eventHandler()
        //var _handlers:[(aEvent:Event) -> ()] = [(aEvent:Event) -> ()]()
//        _handlers.append(onAddDecButtonHandler)
//        _handlers.append(onModelChangeHandler)
        
        
    }
    
    private func onModelChangeHandler(_ e:Event){
        print("onModelChangeHandler")
        
        mResultLabel.text = "\(mModel!.index)"
        let _vo:ModelVO? = e.information as? ModelVO
        print("e:\(_vo)")
        
        //mModel?.removeEventListener(Model.ADD)
        //mModel?.removeEventListener(Model.DEC)
        
        //mModel = nil
    }
    
    fileprivate func onAddDecButtonHandler(_ aEvent:Event){
        let _currentTarget:UIButton = aEvent.currentTarget as! UIButton
        if _currentTarget == mAddbutton {
            mModel?.index = mModel!.index + 1
        }else if _currentTarget == mDecbutton{
            mModel?.index = mModel!.index - 1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func onMainButtonHandler(_ e:Event){
        print("e:Type = \(e.type)")
        if let _target:LNView = e.target as? LNView {
            print("target:\(_target.frame.origin.x)")
        }
        
        if let _currentTarget:UIView = e.currentTarget as? UIView {
            print("currentTarget:\(_currentTarget.frame.origin.x)")
            _currentTarget.removeEventListener(LNTouchEvents.TOUCH_UP_INSIDE.rawValue)
            _currentTarget.removeFromSuperview()
        }
        
    }
    
}
