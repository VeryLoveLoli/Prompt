//
//  Prompt.swift
//  PromptTest
//
//  Created by 韦烽传 on 2019/4/27.
//  Copyright © 2019 韦烽传. All rights reserved.
//

import Foundation
import UIKit

/**
 提示
 */
open class Prompt {
    
    /// 背景
    public let background = UIView.init()
    /// 内容
    public let content = UIView.init()
    /// 提示文本
    public let title = UILabel.init()
    /// 指示器
    public let activity = UIActivityIndicatorView.init(style: .white)
    /// GIF
    public let gif = UIImageView.init()
    /// 加载前缀标题
    var prefix = ""
    /// 加载后缀标题
    var suffix = ""
    /// 动态标题
    public var dynamic = "" {
        
        didSet {
            
            DispatchQueue.main.async {
                
                self.title.text = self.prefix + self.dynamic + self.suffix
            }
        }
    }
    
    public init() {
        
        background.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        gif.backgroundColor = UIColor.clear
        
        content.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        content.layer.cornerRadius = 8
        content.layer.masksToBounds = true
        
        title.backgroundColor = UIColor.clear
        title.font = UIFont.systemFont(ofSize: 14)
        title.textAlignment = .center
        title.textColor = UIColor.white
        title.numberOfLines = 0
        
        content.addSubview(title)
        content.addSubview(activity)
        
        background.translatesAutoresizingMaskIntoConstraints = false
        content.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        content.translatesAutoresizingMaskIntoConstraints = false
        activity.translatesAutoresizingMaskIntoConstraints = false
        gif.translatesAutoresizingMaskIntoConstraints = false
    }
    
    /**
     文字提示
     
     - parameter    title:          文字
     - parameter    milliseconds:   显示时间
     - parameter    isBackground:   是否显示背景（用于阻止用户点击）
     - parameter    sup:            添加到的视图
     - parameter    location:       在视图中的位置
     */
    @discardableResult public static func title(_ title: String, milliseconds: Int, isBackground: Bool, sup: UIView, location: CGPoint) -> Prompt {
        
        let prompt = Prompt.init()
        prompt.activity.isHidden = true
        prompt.title.text = title
        prompt.background.isHidden = !isBackground
        
        sup.addSubview(prompt.background)
        sup.addSubview(prompt.content)
        
        sup.addConstraints([NSLayoutConstraint.init(item: prompt.background, attribute: .left, relatedBy: .equal, toItem: sup, attribute: .left, multiplier: 1, constant: 0),
                                          NSLayoutConstraint.init(item: prompt.background, attribute: .right, relatedBy: .equal, toItem: sup, attribute: .right, multiplier: 1, constant: 0),
                                          NSLayoutConstraint.init(item: prompt.background, attribute: .top, relatedBy: .equal, toItem: sup, attribute: .top, multiplier: 1, constant: 0),
                                          NSLayoutConstraint.init(item: prompt.background, attribute: .bottom, relatedBy: .equal, toItem: sup, attribute: .bottom, multiplier: 1, constant: 0)])
        
        prompt.content.addConstraints([NSLayoutConstraint.init(item: prompt.title, attribute: .left, relatedBy: .equal, toItem: prompt.content, attribute: .left, multiplier: 1, constant: 20),
                                       NSLayoutConstraint.init(item: prompt.title, attribute: .right, relatedBy: .equal, toItem: prompt.content, attribute: .right, multiplier: 1, constant: -20),
                                       NSLayoutConstraint.init(item: prompt.title, attribute: .top, relatedBy: .equal, toItem: prompt.content, attribute: .top, multiplier: 1, constant: 20),
                                       NSLayoutConstraint.init(item: prompt.title, attribute: .bottom, relatedBy: .equal, toItem: prompt.content, attribute: .bottom, multiplier: 1, constant: -20)])
        
        sup.addConstraints([NSLayoutConstraint.init(item: prompt.content, attribute: .left, relatedBy: .greaterThanOrEqual, toItem: sup, attribute: .left, multiplier: 1, constant: 20),
                            NSLayoutConstraint.init(item: prompt.content, attribute: .centerX, relatedBy: .equal, toItem: sup, attribute: .centerX, multiplier: location.x/sup.center.x, constant: 0),
                            NSLayoutConstraint.init(item: prompt.content, attribute: .centerY, relatedBy: .equal, toItem: sup, attribute: .centerY, multiplier: location.y/sup.center.y, constant: 0)])
        
        prompt.background.alpha = 0
        prompt.content.alpha = 0
        prompt.content.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.25, animations: {
            
            prompt.background.alpha = 1
            prompt.content.alpha = 1
            prompt.content.transform = CGAffineTransform.init(scaleX: 1, y: 1)
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(milliseconds)) {
            
            prompt.close()
        }
        
        return prompt
    }
    
    /**
     加载提示
     
     - parameter    title:          文字
     - parameter    timeInterval:   动态显示的文字时间间隔
     - parameter    repeats:        动态显示的文字个数（小于或等于`title.count`，从后往前算）
     - parameter    dynamic:        最大长度动态字符串（不显示，需设置`dynamic`属性，`dynamic`字符串在`repeats`之前）
     - parameter    isBackground:   是否显示背景（用于阻止用户点击）
     - parameter    sup:            添加到的视图
     - parameter    location:       在视图中的位置
     */
    @discardableResult public static func load(_ title: String, timeInterval: TimeInterval, repeats: Int, dynamic: String, isBackground: Bool, sup: UIView, location: CGPoint) -> Prompt {
        
        let prompt = Prompt.init()
        
        prompt.activity.startAnimating()
        prompt.title.text = title
        prompt.background.isHidden = !isBackground
        
        sup.addSubview(prompt.background)
        sup.addSubview(prompt.content)
        
        sup.addConstraints([NSLayoutConstraint.init(item: prompt.background, attribute: .left, relatedBy: .equal, toItem: sup, attribute: .left, multiplier: 1, constant: 0),
                            NSLayoutConstraint.init(item: prompt.background, attribute: .right, relatedBy: .equal, toItem: sup, attribute: .right, multiplier: 1, constant: 0),
                            NSLayoutConstraint.init(item: prompt.background, attribute: .top, relatedBy: .equal, toItem: sup, attribute: .top, multiplier: 1, constant: 0),
                            NSLayoutConstraint.init(item: prompt.background, attribute: .bottom, relatedBy: .equal, toItem: sup, attribute: .bottom, multiplier: 1, constant: 0)])
        
        if !title.isEmpty || !dynamic.isEmpty {
            
            prompt.content.addConstraints([NSLayoutConstraint.init(item: prompt.activity, attribute: .left, relatedBy: .greaterThanOrEqual, toItem: prompt.content, attribute: .left, multiplier: 1, constant: 20),
                                           NSLayoutConstraint.init(item: prompt.activity, attribute: .centerX, relatedBy: .equal, toItem: prompt.content, attribute: .centerX, multiplier: sup.center.x/location.x, constant: 0),
                                           NSLayoutConstraint.init(item: prompt.activity, attribute: .top, relatedBy: .equal, toItem: prompt.content, attribute: .top, multiplier: 1, constant: 20),
                                           NSLayoutConstraint.init(item: prompt.activity, attribute: .bottom, relatedBy: .equal, toItem: prompt.title, attribute: .top, multiplier: 1, constant: -12)])
            
            prompt.content.addConstraints([NSLayoutConstraint.init(item: prompt.title, attribute: .left, relatedBy: .equal, toItem: prompt.content, attribute: .left, multiplier: 1, constant: 20),
                                           NSLayoutConstraint.init(item: prompt.title, attribute: .centerX, relatedBy: .equal, toItem: prompt.content, attribute: .centerX, multiplier: sup.center.x/location.x, constant: 0),
                                           NSLayoutConstraint.init(item: prompt.title, attribute: .bottom, relatedBy: .equal, toItem: prompt.content, attribute: .bottom, multiplier: 1, constant: -20)])
            
            let rect = (title+dynamic).boundingRect(with: CGSize.init(width: 0.8 * sup.frame.size.width, height: 0.8 * sup.frame.size.height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: prompt.title.font!], context: nil)
            
            prompt.title.addConstraints([NSLayoutConstraint.init(item: prompt.title, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: rect.size.width),
                                         NSLayoutConstraint.init(item: prompt.title, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: rect.size.height)])
        }
        else {
            
            prompt.content.addConstraints([NSLayoutConstraint.init(item: prompt.activity, attribute: .left, relatedBy: .equal, toItem: prompt.content, attribute: .left, multiplier: 1, constant: 20),
                                           NSLayoutConstraint.init(item: prompt.activity, attribute: .right, relatedBy: .equal, toItem: prompt.content, attribute: .right, multiplier: 1, constant: -20),
                                           NSLayoutConstraint.init(item: prompt.activity, attribute: .top, relatedBy: .equal, toItem: prompt.content, attribute: .top, multiplier: 1, constant: 20),
                                           NSLayoutConstraint.init(item: prompt.activity, attribute: .bottom, relatedBy: .equal, toItem: prompt.content, attribute: .bottom, multiplier: 1, constant: -20)])
        }
        
        sup.addConstraints([NSLayoutConstraint.init(item: prompt.content, attribute: .left, relatedBy: .greaterThanOrEqual, toItem: sup, attribute: .left, multiplier: 1, constant: 20),
                            NSLayoutConstraint.init(item: prompt.content, attribute: .centerX, relatedBy: .equal, toItem: sup, attribute: .centerX, multiplier: location.x/sup.center.x, constant: 0),
                            NSLayoutConstraint.init(item: prompt.content, attribute: .centerY, relatedBy: .equal, toItem: sup, attribute: .centerY, multiplier: location.y/sup.center.y, constant: 0)])
        
        prompt.background.alpha = 0
        prompt.content.alpha = 0
        prompt.content.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.25, animations: {
            
            prompt.background.alpha = 1
            prompt.content.alpha = 1
            prompt.content.transform = CGAffineTransform.init(scaleX: 1, y: 1)
        })
        
        prompt.prefix = title
        prompt.suffix = ""
        
        if title.count >= repeats && repeats > 0 {
            
            let prefix_start = title.index(title.startIndex, offsetBy: 0)
            let prefix_end = title.index(title.endIndex, offsetBy: -repeats)
            
            prompt.prefix = String(title[prefix_start..<prefix_end])
            prompt.suffix = String(title[prefix_end..<title.endIndex])
            
            var i = repeats
            
            let timer = Timer.init(timeInterval: timeInterval, repeats: true, block: { (timer) in
                
                let end = title.index(title.endIndex, offsetBy: -i)
                
                prompt.suffix = String(title[prefix_end..<end])
                
                prompt.title.text = prompt.prefix + prompt.dynamic + prompt.suffix
                
                i -= 1
                
                if i < 0 {
                    
                    i = repeats
                }
                
                if prompt.content.superview == nil && timer.isValid {
                    
                    timer.invalidate()
                }
            })
            
            RunLoop.current.add(timer, forMode: .default)
        }
        
        prompt.title.text = prompt.prefix + prompt.dynamic + prompt.suffix
        
        return prompt
    }
    
    /**
     GIF提示
     
     - parameter    images:         动画图片列表
     - parameter    duration:       动画时间
     - parameter    isBackground:   是否显示背景（用于阻止用户点击）
     - parameter    sup:            添加到的视图
     - parameter    location:       在视图中的位置
     */
    @discardableResult public static func gif(_ images: [UIImage], duration: TimeInterval, isBackground: Bool, sup: UIView, location: CGPoint) -> Prompt {
        
        let prompt = Prompt.init()
        
        prompt.activity.isHidden = true
        prompt.title.isHidden = true
        prompt.content.isHidden = true
        prompt.background.isHidden = !isBackground
        
        sup.addSubview(prompt.background)
        sup.addSubview(prompt.gif)
        
        sup.addConstraints([NSLayoutConstraint.init(item: prompt.background, attribute: .left, relatedBy: .equal, toItem: sup, attribute: .left, multiplier: 1, constant: 0),
                            NSLayoutConstraint.init(item: prompt.background, attribute: .right, relatedBy: .equal, toItem: sup, attribute: .right, multiplier: 1, constant: 0),
                            NSLayoutConstraint.init(item: prompt.background, attribute: .top, relatedBy: .equal, toItem: sup, attribute: .top, multiplier: 1, constant: 0),
                            NSLayoutConstraint.init(item: prompt.background, attribute: .bottom, relatedBy: .equal, toItem: sup, attribute: .bottom, multiplier: 1, constant: 0)])
        
        prompt.gif.animationImages = images
        prompt.gif.animationDuration = duration
        
        if let image = images.first {
            
            prompt.gif.image = image
            
            sup.addConstraints([NSLayoutConstraint.init(item: prompt.gif, attribute: .centerX, relatedBy: .equal, toItem: sup, attribute: .centerX, multiplier: location.x/sup.center.x, constant: 0),
                                NSLayoutConstraint.init(item: prompt.gif, attribute: .centerY, relatedBy: .equal, toItem: sup, attribute: .centerY, multiplier: location.y/sup.center.y, constant: 0)])
            
            prompt.gif.addConstraints([NSLayoutConstraint.init(item: prompt.gif, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: image.size.width),
                                         NSLayoutConstraint.init(item: prompt.gif, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: image.size.height)])
        }
        
        prompt.background.alpha = 0
        prompt.gif.alpha = 0
        prompt.gif.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.25, animations: {
            
            prompt.background.alpha = 1
            prompt.gif.alpha = 1
            prompt.gif.transform = CGAffineTransform.init(scaleX: 1, y: 1)
        })
        
        prompt.gif.startAnimating()
        
        return prompt
    }
    
    /**
     关闭
     */
    open func close() {
        
        UIView.animate(withDuration: 0.25, animations: {
            
            self.background.alpha = 0
            self.content.alpha = 0
            self.content.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
            self.gif.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
            
        }) { (bool) in
            
            self.activity.stopAnimating()
            self.background.removeFromSuperview()
            self.content.removeFromSuperview()
            self.gif.removeFromSuperview()
        }
    }
}

public extension Prompt {
    
    /**
     存储提示避免多个提示
     */
    
    /// 文字提示
    static var title: Prompt?
    /// 加载提示
    static var load: Prompt?
    /// GIF提示
    static var gif: Prompt?
}

extension Prompt: Equatable {
    
    public static func == (lhs: Prompt, rhs: Prompt) -> Bool {
        
        lhs.content == rhs.content
    }
}

public extension Prompt {
    
    /// 关键窗口
    static var keyWindow: UIWindow? {
        
        if #available(iOS 15, *) {
            
            for scene in UIApplication.shared.connectedScenes {
                
                if let windowScene = scene as? UIWindowScene {
                    
                    for item in windowScene.windows {
                        
                        if item.isKeyWindow {
                            
                            return item
                        }
                    }
                }
            }
        }
        else if #available(iOS 13, *) {
            
            for item in UIApplication.shared.windows {
                
                if item.isKeyWindow {
                    
                    return item
                }
            }
        }
        else {
            
            return UIApplication.shared.keyWindow
        }
        
        return nil
    }
}
