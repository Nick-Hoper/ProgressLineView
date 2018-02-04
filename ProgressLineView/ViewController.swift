//
//  ViewController.swift
//  ProgressLineView
//
//  Created by Nick-Hoper on 2018/1/31.
//  Copyright © 2018年 Nick-Hoper. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    
    var progressV:ProgressLineView!
    
    var progressV2:ProgressLineView2!
    
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var testView: ProgressLine!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //1、没有标签的进度条 swift 4.0
        progressV = ProgressLineView.init(frame: CGRect.init(x: 0, y: 100, width: self.view.frame.size.width, height: 30), dataArr: ["1","2","3","4","5"])
        self.view.addSubview(progressV)
        
        
        //2、添加手势的进度条 swift 4.0
        self.testView.dataArray = ["1","2","3","4","5"]
        self.testView.delegate = self

        //3、添加标签的进度条  object - c
        progressV2 = ProgressLineView2.init(frame: CGRect.init(x: 0, y: 380, width: self.view.frame.size.width, height: 60), titles: ["0%","25%","50%","75%","100%"])
        self.view.addSubview(progressV2)
        
        
        
    }

       //1、没有标签的进度条 上一步
    @IBAction func lastStep(_ sender: Any) {
        
         progressV.index = progressV.index - 1
    }
    
       //1、没有标签的进度条 下一步
    @IBAction func nextStep(_ sender: Any) {
        
         progressV.index = progressV.index + 1
    }
    
     //3、添加标签的进度条 上一步
    @IBAction func clickPer(_ sender: Any) {
        
        let step = progressV2.stepIndex - 1
        progressV2.setStep(step, animation: true)

    }
    
     //3、添加标签的进度条 下一步
    @IBAction func clickNext(_ sender: Any) {
        
        let step = progressV2.stepIndex + 1

       progressV2.setStep(step, animation: true)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
///MARK: - 实现手势点击的协议方法 //2、添加手势的进度条
extension  ViewController: ProgressLineDelegate {
    
    func progressValue(index:Int) {
        print("index=\(index)")
        
        var indextemp  = index
        
        let dataArr = ["0%","25%","50%","75%","100%"]
        
        
        if index < 0
        {
            indextemp = 0
        }
        
        if index > dataArr.count
        {
            indextemp = dataArr.count - 1
        }
        
        
        self.rateLabel.text = dataArr[indextemp]
        
    }
}

