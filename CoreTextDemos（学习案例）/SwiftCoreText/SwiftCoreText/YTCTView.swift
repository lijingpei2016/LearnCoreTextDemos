//
//  YTCTView.swift
//  SwiftCoreText
//
//  Created by aron on 2018/5/28.
//  Copyright © 2018年 aron. All rights reserved.
//

import UIKit
import CoreGraphics

class YTCTView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.cyan
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        // 绘图上下文CGContext
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return
        }
        
        // 笛卡尔坐标系翻转为屏幕坐标系
        ctx.translateBy(x: 0, y: bounds.size.height)
        ctx.scaleBy(x: 1.0, y: -1.0)
        
        // path用于创建CTFrame
        let path = CGMutablePath()
        path.addRect(self.bounds)
        
        let str = """
当你提供一个NSAttributedString创建一个CTFramesetter对象实例的时候，一个CTTypesetter的实例对象会自动为你创建用以管理你的字体。接下来你会在渲染文本的时候用到这个CTFramesetter去创建一个或者多个frame。

当你创建了一个frame，你可以为这个frame提供文本的一个subrange去渲染这段文本。Core Text会自动为文本的每一行创建一个CTLine，并为每个具有相同格式的字符创建一个CTRun。举个例子，Core Text只会创建一个CTRun用于同一行中的几个红色的单词，创建一个CTRun用于接下来的纯文本，创建一个CTRun用于粗体段落等等。Core Text创建会根据你提供的NSAttributedString中的属性创建CTRun。此外，上面说到的每一个CTRun对象都可以采用不同的属性，也就是说，你可以很好地控制字距、连字、宽度、高度等。

作者：又吉君的ruanpapa
链接：https://www.jianshu.com/p/f10dac7a0c9f
來源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
""";
        let attrStr = NSAttributedString(string: str, attributes: [NSAttributedStringKey.foregroundColor: UIColor.blue])
        
        
        // 创建CTFramesetter，从CTFramesetter中获取CTFrame
        // CTFramesetter包含了内容信息
        // CTFrame包含了path区块中的内容信息
        let frameSetter = CTFramesetterCreateWithAttributedString(attrStr)
        let frame = CTFramesetterCreateFrame(frameSetter, CFRange.init(location: 0, length: attrStr.length), path, nil)
        
        let fRange = CTFrameGetVisibleStringRange(frame)
        let subAttr = attrStr.attributedSubstring(from: NSRange.init(location: fRange.location, length: fRange.length))
        print("fRange = \(fRange)  subAttr = \(subAttr)")

        // 绘制
        CTFrameDraw(frame, ctx)
        
        // 释放资源
        
    }

}
