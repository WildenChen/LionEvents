# LionEvents
LionEvents is a Framework which mimic the event mechanism in Adobe Flash Acrionscript 3.0.

The great advantages are no Selector and no private function with prefix @obj.

With LionEvents, you can make more efficient encapsulation, and reduce the degree of coupling.

LionEvents provide an event mechanism which is more efficient than NSNotification. The feature is very suitable for developing custom interactive UI to integrate with your code structure.

created for Swift 1.2 using Xcode 6.3.2.
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
pod 'LionEvents', :git => 'https://github.com/wilden0424/LionEvents.git'
```

## Usage
The feature: loose coupling of LionEvents event mechanism, make you focus on programming, and avoid the crash which results from "Selector not found". You can Add / Remove your custom events or event handlers arbitrarily.

The main class of LionEvents is EventDispatcher.
Just inherit EventDispatcher to implement the whole event mechanism.

Another way is to extend NSObject with EventDispatcher, we had done it with UIButton and several common UIKit components, (e.g., UIButton, UISwitch).

### 1: Add EventListener ###

For common UIKit components (e.g., UIButton, UISwitch), we can register events with the following way:

```swift
let _button:UIButton = UIButton(frame: CGRectMake(0, 0, 50, 30))
_button.addEventListener(LNButtonEvents.TOUCH_UP_INSIDE, onButtonHandler)        _button.addEventListener(LNButtonEvents.TOUCH_UP_OUTSIDE, onButtonHandler)
_button.addEventListener(LNButtonEvents.TOUCH_DOWN, onButtonHandler)
```

With the setting, the touch event: LNButtonEvents.TOUCH_UP_INSIDE / TOUCH_UP_OUTSIDE / TOUCH_DOWN will trigger the event handler onButtonHandler.

### 2: CallBack or Handler ###

The event handler can take no parameter or one LNEvent parameter.
LNEvent has some useful properties.

Like this:
```swift
private func onButtonHandler(){
    println("LNButton has Event!")
}
```

or

```swift
private func onButtonHandler(e:LNEvent){
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
mModel.addEventListener(Model.ADD, { (aEvent:LNEvent) -> Void in
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
                dispatchEvent(Model.ADD)
            }else if value < mIndex {
                mIndex = value
                dispatchEvent(Model.DEC)
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

class ModelObject: NSObject {
    static let ADD:String = "model_add"
    static let DEC:String = "model_dec"

    private var mIndex:Int = 0
    var index:Int{
        set(value){
            if value > mIndex {
                mIndex = value
                dispatchEvent(Model.ADD)
            }else if value < mIndex {
                mIndex = value
                dispatchEvent(Model.DEC)
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

private func onModelChangeHandler(aEvent:LNEvent){
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
___

# LionEvents

LionEvents 是一個仿照 Adobe Flash Acrionscript 3.0 事件流機制的一個 Framework。

他最大的好處在於不需要再透過 Selector 來寫事件，而且 func 也不用設定 private 還需要加上 @obj。

對於程式碼的封裝可以做更好的應用以外，還可以大幅度將地程式碼的耦合性。

提供了一種比 NSNotification 還要快速的事件機制，而且更適合 自訂 UI 上的互動開發，更容易整合與架構程式碼。

created for Swift 1.2 using Xcode 6.3.2.

## Features

- 更容易在各類別之間作訊息通知的傳遞。
- 不需要再使用 Selector 接字串來尋找 func。
- 大量降低程式的耦合性。
- 讓你的程式碼看起來更優雅。
- 比原本 Apple 內建的 NSNotifiction 還要快(不成熟的測試)。
- 可以對指定的 Callback  做事件刪除，不用一次就要刪除該事件全部的 Callback。
- 在多執行緒下也可以正常使用(未測試)。
- 可以對一個實體做多個事件函數註冊，也可以對一個實體對一個事件作多個函數註冊，執行完全正常。

## Installation
iOS 7 Project：
```
直接把<LionEvents>資料夾放到專案裡即可。
```

pod:

```ruby
pod 'LionEvents'
```

```ruby
pod 'LionEvents', :git => 'https://github.com/wilden0424/LionEvents.git'
```

## Usage
由於事件廣播的特性，鬆耦合可以讓我們完全專心開發我們的程式碼。甚至也繞過了 Selector 這種找不到函數就強退的情況。也可以自由的添加刪除要觸發的事件與功能。

整個事件流程的實踐，主要是靠 EventDispatcher 這個類別。
可以直接繼承 EventDispatcher 來完成事件流程。

另一種類則是基於 EventDispatcher 事件機制，來擴充 NSObject 的事件流程。我們也擴充了 UIButton 等幾個 UIKit 的 Components。

### 1: 加入偵聽事件 ###

如果是針對於 UIButton 或是幾個我們有擴充的 UIKit 的 UI 元件，我們可以使用如下的方式對物件作事件註冊。

```swift
let _button:UIButton = UIButton(frame: CGRectMake(0, 0, 50, 30))
_button.addEventListener(LNButtonEvents.TOUCH_UP_INSIDE, onButtonHandler)        _button.addEventListener(LNButtonEvents.TOUCH_UP_OUTSIDE, onButtonHandler)
_button.addEventListener(LNButtonEvents.TOUCH_DOWN, onButtonHandler)
```

此時，上面三個事件 LNButtonEvents.TOUCH_UP_INSIDE，TOUCH_UP_OUTSIDE，TOUCH_DOWN 都會觸發 onButtonHandler 這個函數。

### 2: CallBack or Handler ###

事件的回傳 func，可以帶有 LNEvent  的參數，也可以不接任何值的函數。

```swift
private func onButtonHandler(){
    println("LNButton has Event!")
}
```

或是

```swift
private func onButtonHandler(e:LNEvent){
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

當然也可以使用閉包
```swift
mModel.addEventListener(Model.ADD, { (aEvent:LNEvent) -> Void in
    println("\(aEvent.type),\(aEvent.target)")
})
```

### 3:自定義事件  ###

想要寫一個完全自定義的事件，可以選擇繼承 EventDispatcher 或是 NSObject：

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
                dispatchEvent(Model.ADD)
            }else if value < mIndex {
                mIndex = value
                dispatchEvent(Model.DEC)
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

如果是繼承自 NSObject 的 Class，則已經擴充了事件流的方法了。
```swift
import UIKit

class ModelObject: NSObject {
    static let ADD:String = "model_add"
    static let DEC:String = "model_dec"

    private var mIndex:Int = 0
    var index:Int{
        set(value){
            if value > mIndex {
                mIndex = value
                dispatchEvent(Model.ADD)
            }else if value < mIndex {
                mIndex = value
                dispatchEvent(Model.DEC)
            }
        }
        get{
            return mIndex
        }
    }
}
```


不過如果情況允許的話，建議最好繼承 EventDispatcher，會比較省效能。


### 4:Remove EventListener 移除事件  ###

事件的移除和 ActionScript 3.0 有一些差異。
因為 Swift 本身對於 func 並沒有指針，所以要對一個事件的指定函數做事件移除時，必須要這樣做：

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

也可以對一個事件下的函數一次性移除。

Remove event listeners of the same name from the instance
```swift
_btn.removeEventListener(LNButtonEvents.TOUCH_DOWN)
_btn.removeEventListener(LNButtonEvents.TOUCH_UP_INSIDE)
_btn.removeEventListener(LNButtonEvents.TOUCH_UP_OUTSIDE)
```

也可以一次移除全部事件函數。

Remove all event listeners from the instance
```swift
_btn.removeEventListener(nil)
```
如果是 UIKit 的擴充，可能還會有如下的 func 可以用：
```swift
_btn.removeAllEventListener()
```



### 5:注意事項  ###

LionEvents 雖然幾乎實踐了 ActionScript 3.0 的事件流程，然而也要注意他擁有會被重複註冊事件的特性。

```swift
let _model:Model = Model()
_model.addEventListener(Model.ADD, onModelChangeHandler)
_model.addEventListener(Model.ADD, onModelChangeHandler)
_model.addEventListener(Model.ADD, onModelChangeHandler)

_model.index++

private func onModelChangeHandler(aEvent:LNEvent){
    println("model change!")
}
```

結果
```swift
model change!
model change!
model change!
```
觸發一次事件會跑三次執行結果，因為被註冊了三次。

### 6:未完成與 Bug   ###
- 還沒有完整測試過若對單一實體一直不停的刪除與廣播事件會出現意外狀況。
- 並沒有完整實踐 ActionScript 的事件冒泡功能。遺憾！
- 由於 Swift 的 func 沒有指針，要對一個函數移除偵聽事件，只能另外使用 EventListener 這個類別實體才做刪除的動作。
- 只有粗略的做過效能測試。


### License
LionEvents is released under a BSD License. See LICENSE file for details.

Develop by Lion Information Technology Co.,Ltd.