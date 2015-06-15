# LionEvents

LionEvents 是一個仿照 Adobe Flash Acrionscript 3.0 事件流機制的一個 Framework。

[README ENG](README.md)

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

如果是針對於 LNButton 或是 LNView 元件，我們可以使用如下的方式對物件作事件註冊。

```swift
let _button:LNButton = LNButton(frame: CGRectMake(0, 0, 50, 30))
_button.addEventListener(LNButtonEvents.TOUCH_UP_INSIDE, onButtonHandler)        _button.addEventListener(LNButtonEvents.TOUCH_UP_OUTSIDE, onButtonHandler)
_button.addEventListener(LNButtonEvents.TOUCH_DOWN, onButtonHandler)
```

此時，上面三個事件 LNButtonEvents.TOUCH_UP_INSIDE，TOUCH_UP_OUTSIDE，TOUCH_DOWN 都會觸發 onButtonHandler 這個函數。

### 2: CallBack or Handler ###

事件的回傳 func，可以帶有 Event  的參數，也可以不接任何值的函數。

```swift
private func onButtonHandler(){
    println("LNButton has Event!")
}
```

或是

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

當然也可以使用閉包
```swift
mModel.addEventListener(Model.ADD, { (aEvent:Event) -> Void in
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

如果是繼承自 NSObject 的 Class，則已經擴充了事件流的方法了。
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

private func onModelChangeHandler(aEvent:Event){
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
- 由於 Swift 的 func 沒有指針，要對一個函數移除偵聽事件，只能另外使用 EventListener 這個類別實體才做刪除的動作。
- 只有粗略的做過效能測試。


### License
LionEvents is released under a BSD License. See LICENSE file for details.

Develop by Lion Information Technology Co.,Ltd.
