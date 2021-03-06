//
//  PicScrollVIew.swift
//  Spider
//
//  Created by ooatuoo on 16/8/13.
//  Copyright © 2016年 oOatuo. All rights reserved.
//

import UIKit

class PicScrollView: UIScrollView {
    
    init(pageCount: Int) {
        super.init(frame: CGRect(x: 0, y: kPicThumbH, width: kScreenWidth, height: kPicDetailH))
        
        contentSize = CGSize(width: CGFloat(pageCount) * kScreenWidth, height: kPicDetailH)
        
        backgroundColor = SpiderConfig.Color.BackgroundDark
        alwaysBounceVertical = false
        isPagingEnabled   = true
        bounces         = false
    }
    
    /** 侧滑冲突处理 */
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let popRect = CGRect(x: 0, y: 0, width: kEdgePopGesWidth, height: kPicDetailH)
        let xPoint = CGPoint(x: point.x.truncatingRemainder(dividingBy: kScreenWidth), y: point.y)
        
        if isScrollEnabled && popRect.contains(xPoint) {
            for subView in subviews {
                if subView.contain(point) {
                    let point = self.convert(point, to: subView)
                    for view in subView.subviews {
                        if view.contain(point) {
                            return view
                        }
                    }
                }
            }
            
            return superview
        } else {
            return super.hitTest(point, with: event)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
