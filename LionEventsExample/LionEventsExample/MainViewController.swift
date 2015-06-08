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
    private var mAddbutton:UIButton = UIButton()
    private var mDecbutton:UIButton = UIButton()
    private var mModel:Model = Model()
    private var mResultLabel:UILabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        let _boardWidth:CGFloat = 10.0
        let _buttonHeight:CGFloat = 60.0
        let _buttonWidth:CGFloat = (self.view.frame.width - _boardWidth * 3.0) / 2.0
        
        mAddbutton.frame = CGRectMake(_boardWidth, self.view.frame.height - _boardWidth - _buttonHeight, _buttonWidth, _buttonHeight)
        mAddbutton.addEventListener(LNButtonEvents.TOUCH_UP_INSIDE, aHandler: onAddDecButtonHandler)
        mAddbutton.backgroundColor = UIColor.redColor()
        mAddbutton.setTitle("+1", forState: UIControlState.Normal)
        self.view.addSubview(mAddbutton)
        
        mDecbutton.frame = CGRectMake(_boardWidth * 2.0 + _buttonWidth, self.view.frame.height - _boardWidth - _buttonHeight, _buttonWidth, _buttonHeight)
        mDecbutton.addEventListener(LNButtonEvents.TOUCH_UP_INSIDE, aHandler: onAddDecButtonHandler)
        mDecbutton.backgroundColor = UIColor.redColor()
        mDecbutton.setTitle("-1", forState: UIControlState.Normal)
        self.view.addSubview(mDecbutton)
        
        mResultLabel.frame = CGRectMake(_boardWidth, mAddbutton.frame.origin.y - 40.0, self.view.frame.width - _boardWidth * 2.0, 40.0)
        mResultLabel.text = "\(mModel.index)"
        mResultLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(mResultLabel)
        
        mModel.addEventListener(Model.ADD, aHandler:onModelChangeHandler)
        mModel.addEventListener(Model.DEC, aHandler:onModelChangeHandler)
        
        mModel.addEventListener(Model.ADD, aHandler: { (aEvent:LNEvent) -> Void in
            println("\(aEvent.type),\(aEvent.target)")
        })
    }
    
    private func onModelChangeHandler(){
        mResultLabel.text = "\(mModel.index)"
    }
    
    private func onAddDecButtonHandler(aEvent:LNEvent){
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
