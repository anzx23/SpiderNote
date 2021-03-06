//
//  SpiderAlert.swift
//  Spider
//
//  Created by ooatuoo on 16/6/13.
//  Copyright © 2016年 oOatuo. All rights reserved.
//

import UIKit

enum AlertType: String {
    case ShortRecord    = "录音时间过短哦!"
    case OnlyOnePic     = "至少保留一张图片哦!"
    case RecordTimeOut  = "录音时长不能超过 60s 哦!"
    case SaveCompleted  = "已保存"
}

final class SpiderAlert {
    // MARK: - Alert Controller
    class func alert(title: String, message: String?, dismissTitle: String, inViewController viewController: UIViewController?, withDismissAction dismissAction: (() -> Void)?) {
        
        DispatchQueue.main.async {
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let action: UIAlertAction = UIAlertAction(title: dismissTitle, style: .default) { action in
                if let dismissAction = dismissAction {
                    dismissAction()
                }
            }
            alertController.addAction(action)
            
            viewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    class func tellYou(message: String, inViewController viewController: UIViewController?) {
        DispatchQueue.main.async { 
            let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
            
            let action = UIAlertAction(title: "知道了", style: .default) { action in
                alertController.dismiss(animated: true, completion: nil)
            }
            alertController.addAction(action)
            
            viewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    class func confirmOrCancel(title: String, message: String, confirmTitle: String = "确定", cancelTitle: String = "取消", inViewController viewController: UIViewController?, withConfirmAction confirmAction: @escaping () -> Void, cancelAction: @escaping () -> Void = { }) {
        
        DispatchQueue.main.async {
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let cancelAction: UIAlertAction = UIAlertAction(title: cancelTitle, style: .cancel) { action in
                cancelAction()
            }
            alertController.addAction(cancelAction)
            
            let confirmAction: UIAlertAction = UIAlertAction(title: confirmTitle, style: .default) { action in
                confirmAction()
            }
            alertController.addAction(confirmAction)
            
            viewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: - Toast
    class func alert(type: AlertType, inView superview: UIView) {
        DispatchQueue.main.async(execute: {
            
            let alertLabel = UILabel()
            alertLabel.text = type.rawValue
            alertLabel.font = UIFont.systemFont(ofSize: 12)
            alertLabel.textColor = UIColor.white
            alertLabel.textAlignment = .center
            alertLabel.backgroundColor = UIColor(white: 0, alpha: 0.3)
            
            alertLabel.layer.cornerRadius = 4.0
            alertLabel.layer.masksToBounds = true
            alertLabel.isUserInteractionEnabled = true
            
            switch type {
                case .ShortRecord:
                    alertLabel.frame.size = CGSize(width: 100, height: 20)
                    alertLabel.center = CGPoint(x: superview.frame.width/2, y: superview.frame.height/2) // + 80
                case .RecordTimeOut:
                    alertLabel.frame.size = CGSize(width: 200, height: 20)
                    alertLabel.center = CGPoint(x: superview.frame.width/2, y: 2 + 10) // + 80

                case .OnlyOnePic, .SaveCompleted:
                    alertLabel.frame.size = CGSize(width: 120, height: 20)
                    alertLabel.center = CGPoint(x: superview.frame.width/2, y: superview.frame.height + 14)
            }
            
            let tap = UITapGestureRecognizer(target: alertLabel, action: #selector(alertLabel.removeFromSuperview))
            alertLabel.addGestureRecognizer(tap)
            superview.addSubview(alertLabel)
            
            delay(2.0, work: {
                alertLabel.removeFromSuperview()
            })
        })
    }
}
