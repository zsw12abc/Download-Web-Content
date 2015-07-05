//
//  ViewController.swift
//  Download Web Content
//
//  Created by Shaowei Zhang on 15/7/6.
//  Copyright © 2015年 Shaowei Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = NSURL(string: "https://www.google.com")
        
        //建立一个 task, returns 三个变量 data, response, error
        //queue
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!){
            //建立 closure
            (data, response, error) in
            if error == nil {
                //用 utf8解码数据
                let urlContent = NSString(data: data!, encoding: NSUTF8StringEncoding)
                //print("Start")
                //print(urlContent!)
                //print("end")
                
                /*因为这是一个 queue 所以会等待 queue 下载完所有的网页数据后才会展示
                所以会造成一定的延迟, 于是我们用 dispatch_async 去用 asynchronous program 让他们同时运行
                */
                dispatch_async(dispatch_get_main_queue()){
                    //wont run until the queue is completed, so delay happened
                    //如果baseURL为 nil 的话 没办法加载图片
                    self.webView.loadHTMLString(urlContent! as String, baseURL: url)
                }
            }
        }
        //run the task
        task?.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

