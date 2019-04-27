//
//  ViewController.swift
//  PromptTest
//
//  Created by 韦烽传 on 2019/4/27.
//  Copyright © 2019 韦烽传. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        testGIFPrompt()
    }
    
    /**
     测试文字提示
     */
    func testTitlePrompt() {
        
        /// 文字提示
        Prompt.title("呵呵", milliseconds: 2000, isBackground: true, sup: view, location: view.center)
    }
    
    /**
     测试加载提示
     */
    func testLoadPrompt() {
        
        /// 加载提示
        let load = Prompt.load("正在加载...", timeInterval: 1, repeats: 2, isBackground: true, sup: view, location: view.center)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10)) {
            
            load.close()
        }
    }

    /**
     测试GIF提示
     */
    func testGIFPrompt() {
        
        /// GIF提示
        if let path = Bundle.main.path(forResource: "test", ofType: "gif") {
            
            do {
                
                let data = try Data.init(contentsOf: URL.init(fileURLWithPath: path))
                let gif = Prompt.gif(data, isBackground: true, sup: view, location: view.center)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10)) {
                    
                    gif.close()
                }
                
            } catch {
                
                print(error)
            }
        }
    }

}

