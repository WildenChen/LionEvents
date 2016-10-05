//
//  ViewController.swift
//  LionEventsSwift3
//
//  Created by wilden on 2016/10/5.
//  Copyright © 2016年 Lion Infomation Technology Co.,Ltd. All rights reserved.
//

import UIKit
import LionEvents
class ViewController: UIViewController {

    private var mAddbutton:LNButton = LNButton()
    private var mDecbutton:LNButton = LNButton()
    
    private var mModel:Model? = Model()
    private var mResultLabel:UILabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _boardWidth:CGFloat = 10.0
        let _buttonHeight:CGFloat = 60.0
        let _buttonWidth:CGFloat = (self.view.frame.width - _boardWidth * 3.0) / 2.0
        
        mAddbutton.frame = CGRect(x: _boardWidth, y: self.view.frame.height - _boardWidth - _buttonHeight, width: _buttonWidth, height: _buttonHeight)
        //mAddbutton.addEventListener(LNButtonEvents.TOUCH_UP_INSIDE, onAddDecButtonHandler)
        mAddbutton.backgroundColor = UIColor.red
        mAddbutton.setTitle("+1", for: UIControlState.normal)
        //mAddbutton.addTarget(self, action: Selector("onChangeHandler:"), for: UIControlEvents.touchUpInside)
        mAddbutton.addTarget(self, action: #selector(ViewController.onChangeHandler(aButton:)), for: .touchDown)

        self.view.addSubview(mAddbutton)
        
        mDecbutton.frame = CGRect(x: _boardWidth * 2.0 + _buttonWidth, y: self.view.frame.height - _boardWidth - _buttonHeight, width: _buttonWidth, height: _buttonHeight)
        mDecbutton.addEventListener(LNTouchEvents.TOUCH_UP_INSIDE, onAddDecButtonHandler)
        mDecbutton.backgroundColor = UIColor.red
        mDecbutton.setTitle("-1", for: UIControlState.normal)
        self.view.addSubview(mDecbutton)
        
        mResultLabel.frame = CGRect(x: _boardWidth, y: mAddbutton.frame.origin.y - 40.0, width: self.view.frame.width - _boardWidth * 2.0, height: 40.0)
        mResultLabel.text = "\(mModel!.index)"
        mResultLabel.textAlignment = NSTextAlignment.center
        self.view.addSubview(mResultLabel)
        
        mModel?.addEventListener(Model.ADD, onModelChangeHandler)
        mModel?.addEventListener(Model.DEC, onModelChangeHandler)
        

        doSomeThings(1)
        doSomeThings("Hello!!")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    private func doSomeThings(_ aIndex:Int){
        print("doSomeThings int:\(aIndex)")
    }
    
    private func doSomeThings(_ aText:String){
        print("doSomeThings text:\(aText)")
    }
    
    
    
    private func onAddDecButtonHandler(_ aEvent:Event){
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
    
    func onChangeHandler(aButton:UIButton){
        print("onChange:\(LNButtonEvents.TOUCH_UP_INSIDE.rawValue)")
        mModel?.index = mModel!.index + 1
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

}

