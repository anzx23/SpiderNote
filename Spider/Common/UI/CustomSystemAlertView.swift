//
//  CustomSystemAlertView.swift
//  Spider
//
//  Created by 童星 on 16/7/14.
//  Copyright © 2016年 oOatuo. All rights reserved.
//  仿照系统的alert样式

import UIKit
var clickButtonTypekey = "ClickButtonTypekey"

enum ClickButtonType:Int {
    case cancle = 0
    case sure = 1
    
}

extension UIButton{
    
    var clickButtonType:Int {
    
        get{
        
            return (objc_getAssociatedObject(self, &clickButtonTypekey) as! Int)
        }
        set(newValue){
        
            objc_setAssociatedObject(self, &clickButtonTypekey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
}

class CustomSystemAlertView: UIView {


    typealias clickAlertClosure = (_ index: Int) -> Void //声明闭包，点击按钮传值
    //把申明的闭包设置成属性
    var clickClosure: clickAlertClosure?
    
    let whiteView = UIView() //白色框
    let titleLabel = UILabel() //标题按钮
    let contentLabel = UILabel() //显示内容
    var title = "" //标题
    var content = "" //内容
    let cancelBtn = UIButton() //取消按钮
    let sureBtn = UIButton() //确定按钮
    let tap = UITapGestureRecognizer() //点击手势
    
    init(title: String?, message: String?, cancelButtonTitle: String?, sureButtonTitle: String?) {
        super.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        self.titleLabel.text = title
        self.contentLabel.text = message
        self.cancelBtn.setTitle(cancelButtonTitle, for: UIControlState())
        self.sureBtn.setTitle(sureButtonTitle, for: UIControlState())
        createAlertView()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:创建
    fileprivate func createAlertView() {
        //布局
        self.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        tap.addTarget(self, action: #selector(CustomSystemAlertView.dismiss))
        self.addGestureRecognizer(tap)
        //白底
        
        if titleLabel.text?.length == 0 || titleLabel.text == nil {
            
            whiteView.frame = CGRect(x: (kScreenWidth - 280) * 0.5, y: (kScreenHeight - 177) * 0.5, width: 280, height: 157)
        }else{
        
            
            whiteView.frame = CGRect(x: (kScreenWidth - 280) * 0.5, y: (kScreenHeight - 177) * 0.5, width: 280, height: 167)

        }
        whiteView.backgroundColor = UIColor.white
        whiteView.layer.cornerRadius = 5
        whiteView.clipsToBounds = true
        self.addSubview(whiteView)
        let width = whiteView.frame.size.width
        //标题
        if titleLabel.text?.length == 0 || titleLabel.text == nil {
            
            titleLabel.frame = CGRect(x: 0, y: 10, width: width, height: 10)


        }else{
        
            titleLabel.frame = CGRect(x: 0, y: 10, width: width, height: 30)

        }
        titleLabel.textColor = RGBCOLOR(66, g: 66, b: 66)
        titleLabel.font = UIFont.systemFont(ofSize: 19)
        titleLabel.textAlignment = .center
        whiteView.addSubview(titleLabel)
        //内容
        contentLabel.frame = CGRect(x: 24, y: titleLabel.frame.maxY + 5, width: width - 48, height: 60)
        contentLabel.numberOfLines = 0
        contentLabel.textColor = RGBCOLOR(66, g: 66, b: 66)
        contentLabel.textAlignment = .center
        contentLabel.font = UIFont.systemFont(ofSize: 17)
        whiteView.addSubview(contentLabel)
        //取消按钮
        let seperatorH = UIView.init(frame: CGRect(x: 0, y: contentLabel.frame.maxY + 9, width: whiteView.frame.width, height: 1))
        seperatorH.backgroundColor = RGBACOLOR(220, g: 220, b: 220, a: 0.7)
        whiteView.addSubview(seperatorH)
        
        var cancelBtnW: CGFloat
        var sureBtnW: CGFloat
        if cancelBtn.currentTitle == nil {
            cancelBtnW = 0
            sureBtnW = width
        }else if sureBtn.currentTitle == nil{
        
            cancelBtnW = width
            sureBtnW = 0
            
        }else{
        
            cancelBtnW = width / 2
            sureBtnW = width / 2
        }
        
        cancelBtn.frame = CGRect(x: 0, y: contentLabel.frame.maxY + 12, width: cancelBtnW, height: whiteView.frame.height - seperatorH.frame.maxY)
//        cancelBtn.backgroundColor = RGBCOLOR(234, g: 234, b: 234)
        cancelBtn.setTitleColor(RGBCOLORV(0x888888), for: UIControlState())
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        cancelBtn.layer.cornerRadius = 3
        cancelBtn.clipsToBounds = true
        cancelBtn.clickButtonType = ClickButtonType.cancle.rawValue
        cancelBtn.addTarget(self, action: #selector(clickBtnAction(_:)), for: .touchUpInside)
        whiteView.addSubview(cancelBtn)
        
        let seperatorV = UIView.init(frame: CGRect(x: cancelBtnW, y: contentLabel.frame.maxY + 9, width: 1, height: cancelBtn.frame.height))
        seperatorV.backgroundColor = RGBACOLOR(220, g: 220, b: 220, a: 0.7)
        whiteView.addSubview(seperatorV)
        //确认按钮
        sureBtn.frame = CGRect(x: cancelBtnW + 1 , y: contentLabel.frame.maxY + 12, width: sureBtnW, height: whiteView.frame.height - seperatorH.frame.maxY)
//        sureBtn.backgroundColor = RGBCOLOR(131, g: 149, b: 231)
        sureBtn.setTitleColor(RGBCOLORV(0xff5f5f), for: UIControlState())
        sureBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        sureBtn.layer.cornerRadius = 3
        sureBtn.clipsToBounds = true
        sureBtn.clickButtonType = ClickButtonType.sure.rawValue
        sureBtn.addTarget(self, action: #selector(clickBtnAction(_:)), for: .touchUpInside)
        whiteView.addSubview(sureBtn)
    }
    
    //MARK:按键的对应的方法
    func clickBtnAction(_ sender: UIButton) {
        if (clickClosure != nil) {
            clickClosure!(sender.clickButtonType)
        }
        dismiss()
    }
    //MARK:消失
    func dismiss() {
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.whiteView.alpha = 0
            self.alpha = 0
        }, completion: { (finish) -> Void in
            if finish {
                self.removeFromSuperview()
            }
        }) 
    }
    
    //为闭包设置调用函数
    func clickIndexClosure(_ closure:clickAlertClosure?){
        //将函数指针赋值给myClosure闭包
        clickClosure = closure
    }
    
    /** 指定视图实现方法 */
    func show() {
        let wind = UIApplication.shared.keyWindow
        self.alpha = 0
        wind?.addSubview(self)
        UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions(), animations: { 
            self.alpha = 1

        }) { (finshed:Bool) in
            
        }

    }

}
