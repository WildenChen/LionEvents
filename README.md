# LionEvents
LionEvents is a Framework which mimic the event mechanism in Adobe Flash Acrionscript 3.0.

[中文說明](README_CHT.md)

The great advantages are no Selector and no private function with prefix @obj.

With LionEvents, you can make more efficient encapsulation, and reduce the degree of coupling.

LionEvents provide an event mechanism which is more efficient than NSNotification. The feature is very suitable for developing custom interactive UI to integrate with your code structure.



created for Swift 2.0 using Xcode 7.0.1.
develop by Lion Information Technology Co.,Ltd.

## Features

- More easy to pass events among classes.
- No Selector string to set function name.
- Reduce the degree of coupling.
- Make your code more elegant.
- More efficient than NSNotifiction. (immature test)
- Delete a specific event handler registered to an event or delete all the event handlers related to an event.
- Running well in multi-thread environments. (not tested)
- Register an event handler to an object or register event handlers related to one event to an object

## Installation
iOS 7 Project：
```
drag <LionEvents> folder to your project.
```

pod:
```ruby
pod 'LionEvents', '0.10.0'
```

Swift 4 Project：
```
drag <LionEvents> folder to your project.
```

pod:
```ruby
pod 'LionEvents', '0.10.1'
```

## Usage
The feature: loose coupling of LionEvents event mechanism, make you focus on programming, and avoid the crash which results from "Selector not found". You can Add / Remove your custom events or event handlers arbitrarily.

The main class of LionEvents is EventDispatcher.
Just inherit EventDispatcher to implement the whole event mechanism.

Another way is to extend NSObject with EventDispatcher, we had done it with UIButton and several common UIKit components, (e.g., UIButton, UISwitch).

### 1: Add EventListener ###

For common UIKit components (e.g., LNButton, LNView), we can register events with the following way:

```swift
let _button:LNButton = LNButton(frame: CGRectMake(0, 0, 50, 30))
_button.addEventListener(LNButtonEvents.TOUCH_UP_INSIDE, onButtonHandler)        _button.addEventListener(LNButtonEvents.TOUCH_UP_OUTSIDE, onButtonHandler)
_button.addEventListener(LNButtonEvents.TOUCH_DOWN, onButtonHandler)
```

With the setting, the touch event: LNButtonEvents.TOUCH_UP_INSIDE / TOUCH_UP_OUTSIDE / TOUCH_DOWN will trigger the event handler onButtonHandler.

### 2: CallBack or Handler ###

The event handler can take no parameter or one Event parameter.
LNEvent has some useful properties.

Like this:
```swift
private func onButtonHandler(){
    println("LNButton has Event!")
}
```

or

```swift
private func onButtonHandler(e:Event){
    switch e.type {
    case LNButtonEvents.TOUCH_DOWN.rawValue:
        println("\(e.type)")
    case LNButtonEvents.TOUCH_UP_INSIDE.rawValue:
        println("\(e.type)")
    case LNButtonEvents.TOUCH_UP_OUTSIDE.rawValue:
        println("\(e.type)")
    default:
        break
       }
    let _dispatcher:EventDispatcher = e.target as! EventDispatcher
    let _btn:UIButton = e.currentTarget as! UIButton
    // remove Listener by EventType
    _btn.removeEventListener(LNButtonEvents.TOUCH_DOWN)
    _btn.removeEventListener(LNButtonEvents.TOUCH_UP_INSIDE)
    _btn.removeEventListener(LNButtonEvents.TOUCH_UP_OUTSIDE)

    // or
    _btn.removeAllEventListener()
}
```

We can also use the closure: (Wow!)

```swift
mModel.addEventListener(Model.ADD, { (aEvent:Event) -> Void in
    println("\(aEvent.type),\(aEvent.target)")
})
```

### 3:Custom Events  ###

If you want to customize your own events, just inherit EventDispatcher or NSObject.

Inherit EventDispatcher:
```swift
import Foundation
import LionEvents
class Model:EventDispatcher {
    static let ADD:String = "model_add"
    static let DEC:String = "model_dec"

    private var mIndex:Int = 0
    var index:Int{
        set(value){
            if value > mIndex {
                mIndex = value
                let _event:Event = Event(aType: Model.ADD, aBubbles: false)
                dispatchEvent(_event)
            }else if value < mIndex {
                mIndex = value
                let _event:Event = Event(aType: Model.ADD, aBubbles: false)
                dispatchEvent(_event)
            }
        }
        get{
            return mIndex
        }
    }

}
```

```swift
mModel.addEventListener(Model.ADD, onModelChangeHandler)
mModel.addEventListener(Model.DEC, onModelChangeHandler)
```

Inherit NSObject:
```swift
import UIKit
import LionEvents
class ModelObject: NSObject {
    static let ADD:String = "model_add"
    static let DEC:String = "model_dec"

    private var mIndex:Int = 0
    var index:Int{
        set(value){
            if value > mIndex {
                mIndex = value
                let _event:Event = Event(aType: Model.ADD, aBubbles: false)
                dispatchEvent(_event)
            }else if value < mIndex {
                mIndex = value
                let _event:Event = Event(aType: Model.ADD, aBubbles: false)
                dispatchEvent(_event)
            }
        }
        get{
            return mIndex
        }
    }
}
```

We recommend to inherit EventDispatcher, it can be executed more efficiently.


### 4:Remove EventListener  ###

There are some different points between LionEvents and ActionScript 3.0 when removing event listener.

Swift has no function pointer, so when removing a specific event listener, do it like this:

Remove one event listener of one event name from the instance
```swift
var mFirstButtonListener:EventListener?
let mButton:UIButton = UIButton(frame: CGRectMake(0, 0, 50, 30))
private func createMutilsEvents(){
    // if want to remove target listener handler
    mFirstButtonListener = mButton.addEventListener(LNButtonEvents.TOUCH_UP_INSIDE, onButtonFirstHandler)
    mButton.addEventListener(LNButtonEvents.TOUCH_UP_INSIDE, onButtonAlwaysHandler)
}

private func onButtonFirstHandler(){
    mButton.removeEventListener(LNButtonEvents.TOUCH_UP_INSIDE, aListener: mFirstButtonListener!)
}
```

or remove all the event listeners for one event:

Remove event listeners of the same name from the instance
```swift
_btn.removeEventListener(LNButtonEvents.TOUCH_DOWN)
_btn.removeEventListener(LNButtonEvents.TOUCH_UP_INSIDE)
_btn.removeEventListener(LNButtonEvents.TOUCH_UP_OUTSIDE)
```

or remove all the event listeners for every event:

Remove all event listeners from the instance
```swift
_btn.removeEventListener(nil)
```
When using common UIKit components, there is one more function for removing, just choose one function:
```swift
_btn.removeAllEventListener()
```



### 5:Announcements  ###

LionEvents implement the most part of ActionScript 3.0 event mechanism, and it alse has the feature of multiple event registration for the same event.

For instance:
```swift
let _model:Model = Model()
_model.addEventListener(Model.ADD, onModelChangeHandler)
_model.addEventListener(Model.ADD, onModelChangeHandler)
_model.addEventListener(Model.ADD, onModelChangeHandler)

_model.index++

private func onModelChangeHandler(aEvent:Event){
    println("model change!")
}
```

result:
```swift
model change!
model change!
model change!
```

the event Model.ADD was triggered one time, and the event handler was triggered tree times.

### 6:Todo list and Bug   ###
- Not tested for removing and adding EventListener repeatedly with the same instance.
- Not implemented the mechanism of ActionScript Event Bubbling. (What a pity!)
- Swift has no function pointer, so when trying to remove an EventListener, we must take the specific EventListener instance.
- Roughly tested for execution efficiency.


### License
LionEvents is released under a BSD License. See LICENSE file for details.

Develop by Lion Information Technology Co.,Ltd.
