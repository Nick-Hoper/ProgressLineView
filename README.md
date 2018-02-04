# ProgressLineView

>Swift4编写进度条组件

![test.jpg](https://github.com/Nick-Hoper/ProgressLineView/blob/master/test.jpg)


## Features

- 完美支持Swift4.0编译
- 支持代码添加，包含有下标说明以及没有下标说明
- 支持手势点击
- 集成使用简单，二次开发扩展强大


## Requirements

- iOS 9+
- Xcode 8+
- Swift 4.0+
- iPhone

## Example

        //1、没有标签的进度条 swift 4.0
        progressV = ProgressLineView.init(frame: CGRect.init(x: 0, y: 100, width: self.view.frame.size.width, height: 30), dataArr: ["1","2","3","4","5"])
        self.view.addSubview(progressV)
        
        
        //2、添加手势的进度条 swift 4.0
        self.testView.dataArray = ["1","2","3","4","5"]
        self.testView.delegate = self

        //3、添加标签的进度条  object - c
        progressV2 = ProgressLineView2.init(frame: CGRect.init(x: 0, y: 380, width: self.view.frame.size.width, height: 60), titles: ["0%","25%","50%","75%","100%"])
        self.view.addSubview(progressV2)
        

更详细集成方法，根据实际的例子请查看源代码中的demo



