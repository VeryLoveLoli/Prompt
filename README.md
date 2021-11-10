# Prompt

`Swift` `iOS` `Prompt`

* 文字提示
* 加载提示
* GIF提示

## Integration

### Xcode
    File -> Swift Packages -> Add Package dependency

### CocoaPods

[GitHub Prompt](https://github.com/VeryLoveLoli/Prompt)

## Usage

### Initialization

```swift
    
    let view = UIView()
    
    /// 视图文字提示
    view.promptTitle("呵呵")
    /// 窗口文字提示
    Prompt.keyWindow?.promptTitle("呵呵")
    
    /// 视图加载提示
    let vLoad = view.promptLoad()
    /// 窗口加载提示
    let kwLoad = Prompt.keyWindow?.promptLoad()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
        
        /// 关闭加载提示
        vLoad.close()
        /// 关闭加载提示
        kwLoad?.close()
    }
    
    let images = [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!]
    
    /// 视图GIF提示
    let vGIF = view.promptGIF(images, duration: 2)
    /// 窗口GIF提示
    let kwGIF = Prompt.keyWindow?.promptGIF(images, duration: 2)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
        
        /// 关闭GIF提示
        vGIF.close()
        /// 关闭GIF提示
        kwGIF?.close()
    }
```
