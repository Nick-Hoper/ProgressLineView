//
//  ProgressLine.swift
//  ProgressLineView
//   2、手势点击的进度条
//  Created by Nick-Hoper on 2018/1/31.
//  Copyright © 2018年 Nick-Hoper. All rights reserved.
//

import UIKit


public protocol ProgressLineDelegate:class{
    
    func progressValue(index:Int)
    
}

class ProgressLine: UIView {

    /// 未完成
    var lineUndoView:UIView = UIView()
    /// 已完成
    var lineDoneView:UIView = UIView()
    //未完成的点
    var undoArray:[UIView] = [UIView]()
    //数据数组
   // var dataArray:[String] = [String]()
    //标志位
    var markI:UILabel = UILabel.init()
    
    //代理者
    open weak var delegate: ProgressLineDelegate?
    
    
    /// 数据数组
    @IBInspectable public var dataArray: [String] = ["1","2","3","4","5"] {
        didSet {
        
            self.setNeedsLayout()
           
        }
    }
    
    
    ///当前的索引
    var index:Int = 0
    
    
    var perWidth: CGFloat = 0
    
    var starX: CGFloat = 0

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }
    
    func setupUI()
    {
        
        //添加手势
        let signdebtsViewTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        self.addGestureRecognizer(signdebtsViewTap)
        
        //未完成线段绘制
        lineUndoView.backgroundColor = UIColor.lightGray
        self.addSubview(lineUndoView)
        
        //已经完成的初始化
        lineDoneView.backgroundColor = UIColor.red
        self.addSubview(lineDoneView)
        
        //未完成点的绘制
        for _ in 0 ..< 5{

            let circleV = UIView.init(frame: CGRect.init(x: 0 , y: 0, width: 13, height: 13))
            circleV.backgroundColor = UIColor.lightGray
            circleV.layer.cornerRadius = 13 / 2
            self.addSubview(circleV)
            self.undoArray.append(circleV)
            
        }

        //创建标志位，主要用于加重点的颜色
         markI = UILabel.init(frame: CGRect.init(x: 0 , y: 0, width: 23, height: 23))
        markI.backgroundColor = UIColor.red
        markI.textAlignment = .center
        markI.layer.cornerRadius = 25 / 2
        markI.layer.masksToBounds = true
        self.addSubview(markI)
        
       
        
    }
    
    /// 布局子视图
    public override func layoutSubviews() {
        super.layoutSubviews()
    
        
        self.starX = self.frame.origin.x
        
        perWidth = self.frame.size.width / CGFloat (dataArray.count)
        
        lineUndoView.frame  =  CGRect.init(x: 0, y: 0, width: self.frame.size.width - perWidth, height: 3)
        lineUndoView.center = CGPoint.init(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        
         let startX = lineUndoView.frame.origin.x
        
        for i in 0 ..< dataArray.count{
            
            let cricle = self.undoArray[i]
            cricle.center = CGPoint.init(x: CGFloat(i) * perWidth + startX, y: lineUndoView.center.y)
        }
        
        self.setIndex()
       
       
    }
    
    
    func setIndex()
    {
        
        //如果超出标签，则不做操作
        guard index >=  0 && index < self.dataArray.count else {
            return
        }
        
        
        let circleVx = self.undoArray[index]
        
        ///设置标志位的位置
        markI.center = CGPoint.init(x: circleVx.center.x, y: circleVx.center.y)
        
        //每个的宽度
        let per_W = self.frame.size.width / CGFloat (self.dataArray.count)
        
        //重新设置 完成视图的frame
        self.lineDoneView.frame = CGRect.init(x: lineUndoView.frame.origin.x, y: lineUndoView.frame.origin.y, width: per_W * CGFloat (index), height: self.lineUndoView.frame.size.height)
        
    
        
        //设置圆点的颜色
        for i in 0 ..< self.undoArray.count{//重置颜色
            
            let circleV = self.undoArray[i]
            if i <= index {
                //已经完成，设置为红色
                circleV.backgroundColor = UIColor.red
            }else{
                //还未完成的，设置为灰色
                circleV.backgroundColor = UIColor.lightGray
            }

        }
    }
    
    // 点击进度条后执行的  手势事件
    @objc func tapAction(tap : UITapGestureRecognizer)
    {
        let touchPoint: CGPoint = tap.location(in: self)
        
        print("touchPoint=\(touchPoint.x)")
        
        let indextemp = Int(round((touchPoint.x - self.perWidth/2)/self.perWidth))
        
        self.index = indextemp
        
        print("self.index=\(self.index),starX=\(starX),self.perWidth=\(self.perWidth)")
 
        self.setNeedsLayout()


        //            // 进度条改变了 出发代理执行代理事件  让用的地方可以相应的改变  比如音频视频的播放进度调整
         self.delegate?.progressValue(index:indextemp)
    }

}




