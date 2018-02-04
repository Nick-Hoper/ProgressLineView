//
//  ProgressLineView.swift
//  ProgressLineView
//  1、没有标签的进度条
//  Created by Nick-Hoper on 2018/1/31.
//  Copyright © 2018年 Nick-Hoper. All rights reserved.
//

import UIKit


class ProgressLineView: UIView {
    /// 未完成
    var lineUndoView:UIView = UIView()
    /// 已完成
    var lineDoneView:UIView = UIView()
    //未完成的点
    var undoArray:[UIView] = [UIView]()
    //数据数组
    var dataArray:[String] = [String]()
    //标志位
     var markI:UILabel?
    
    ///当前的索引
    var index:Int!{
       
        didSet{
            
            //如果超出标签，则不做操作
            guard index! >=  0 && index! < self.dataArray.count else {
                return
            }
            
            //每个的宽度
            let per_W = self.frame.size.width / CGFloat (self.dataArray.count)
            
            //重新设置 完成视图的frame
            self.lineDoneView.frame = CGRect.init(x: lineUndoView.frame.origin.x, y: lineUndoView.frame.origin.y, width: per_W * CGFloat (index!), height: self.lineUndoView.frame.size.height)
            
            let circleVx = self.undoArray[index!]
            
            ///设置标志位的位置
            markI?.center = CGPoint.init(x: circleVx.center.x, y: circleVx.center.y)
            
            //设置圆点的颜色
            for i in 0 ..< self.undoArray.count{//重置颜色
                
                let circleV = self.undoArray[i]
                if i <= index! {
                    //已经完成，设置为红色
                    circleV.backgroundColor = UIColor.red
                }else{
                    //还未完成的，设置为灰色
                    circleV.backgroundColor = UIColor.lightGray
                }
                
            }
        }
    }
    

    init(frame:CGRect,dataArr:[String]) {
        
        super.init(frame: frame)
        
        //默认选择第一个
        index = 0
        
        //加载数据
        self.dataArray = dataArr

        //未完成线段绘制
        let line_W = frame.size.width - frame.size.width / CGFloat (dataArr.count)
        lineUndoView.frame  =  CGRect.init(x: 0, y: 0, width: line_W, height: 3)
        lineUndoView.center = CGPoint.init(x: self.center.x, y: self.frame.size.height / 2)
        lineUndoView.backgroundColor = UIColor.lightGray
        self.addSubview(lineUndoView)
        
        //未完成点的绘制
        let start_X = lineUndoView.frame.origin.x
        let Per_W = self.frame.size.width / CGFloat (dataArr.count)
        for i in 0 ..< dataArr.count{
            
            // (13 - 1.5 ) / 2 因为是 中心点  所以  center_y = 3/2 = 1.5  往上移 5.75位
            let circleV = UIView.init(frame: CGRect.init(x: start_X + Per_W * CGFloat(i) , y: lineUndoView.center.y -  5.75, width: 13, height: 13))
            circleV.backgroundColor = UIColor.lightGray
            circleV.layer.cornerRadius = 13 / 2
            self.addSubview(circleV)
            self.undoArray.append(circleV)
            
        }
        
        //创建标志位，主要用于加重点的颜色
        markI = UILabel.init(frame: CGRect.init(x: start_X , y: lineUndoView.center.y - 11.75, width: 25, height: 25))
        markI?.backgroundColor = UIColor.red
        markI?.textAlignment = .center
        markI?.layer.cornerRadius = 25 / 2
        markI?.layer.masksToBounds = true
        self.addSubview(markI!)
        
        //已经完成的初始化
        lineDoneView.frame = CGRect.zero
        lineDoneView.backgroundColor = UIColor.red
        self.addSubview(lineDoneView)
        
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

