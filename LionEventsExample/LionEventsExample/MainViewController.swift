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
    private var mAddbutton:LNButton = LNButton()
    private var mDecbutton:LNButton = LNButton()
    private var mModel:Model = Model()
    private var mResultLabel:UILabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        let _boardWidth:CGFloat = 10.0
        let _buttonHeight:CGFloat = 60.0
        let _buttonWidth:CGFloat = (self.view.frame.width - _boardWidth * 3.0) / 2.0
        
        mAddbutton.frame = CGRectMake(_boardWidth, self.view.frame.height - _boardWidth - _buttonHeight, _buttonWidth, _buttonHeight)
        mAddbutton.addEventListener(LNButtonEvents.TOUCH_UP_INSIDE, onAddDecButtonHandler)
        mAddbutton.backgroundColor = UIColor.redColor()
        mAddbutton.setTitle("+1", forState: UIControlState.Normal)
        self.view.addSubview(mAddbutton)
        
        mDecbutton.frame = CGRectMake(_boardWidth * 2.0 + _buttonWidth, self.view.frame.height - _boardWidth - _buttonHeight, _buttonWidth, _buttonHeight)
        mDecbutton.addEventListener(LNButtonEvents.TOUCH_UP_INSIDE, onAddDecButtonHandler)
        mDecbutton.backgroundColor = UIColor.redColor()
        mDecbutton.setTitle("-1", forState: UIControlState.Normal)
        self.view.addSubview(mDecbutton)
        
        mResultLabel.frame = CGRectMake(_boardWidth, mAddbutton.frame.origin.y - 40.0, self.view.frame.width - _boardWidth * 2.0, 40.0)
        mResultLabel.text = "\(mModel.index)"
        mResultLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(mResultLabel)
        
        mModel.addEventListener(Model.ADD, onModelChangeHandler)
        mModel.addEventListener(Model.DEC, onModelChangeHandler)
        
        
        let _mainButton:MainButton = MainButton()
        _mainButton.backgroundColor = UIColor.redColor()
        _mainButton.frame = CGRectMake(10, 90, self.view.frame.width - 20, 100)
        _mainButton.addEventListener(LNTouchEvents.TOUCH_UP_INSIDE, { (aEvent:Event) -> Void in
            println("\(aEvent.type)")
            if let _target:LNView = aEvent.target as? LNView {
                println("target:\(_target.frame.origin.x)")
            }
            
            if let _currentTarget:UIView = aEvent.currentTarget as? UIView {
                println("currentTarget:\(_currentTarget.frame.origin.x)")
            }
        })
        self.view.addSubview(_mainButton)
        
        let _sceondButton:LNView = LNView()
        _sceondButton.backgroundColor = UIColor.yellowColor()
        _sceondButton.frame = CGRectMake(20, 20, _mainButton.frame.width - 40, _mainButton.frame.height - 40)
        _mainButton.addSubview(_sceondButton)
        
        let _tButton:LNView = LNView()
        _tButton.backgroundColor = UIColor.greenColor()
        _tButton.frame = CGRectMake(30, 50, _sceondButton.frame.width - 40, _sceondButton.frame.height - 30)
        _sceondButton.addSubview(_tButton)
        
        
    }
    
    private func onModelChangeHandler(){
        mResultLabel.text = "\(mModel.index)"
    }
    
    private func onAddDecButtonHandler(aEvent:Event){
        let _currentTarget:UIButton = aEvent.currentTarget as! UIButton
        if _currentTarget == mAddbutton {
            mModel.index++
        }else if _currentTarget == mDecbutton{
            mModel.index--
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
