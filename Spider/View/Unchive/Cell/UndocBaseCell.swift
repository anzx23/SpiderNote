//
//  UndocBaseCell.swift
//  Spider
//
//  Created by ooatuoo on 16/8/19.
//  Copyright © 2016年 oOatuo. All rights reserved.
//

import UIKit

private let unChooseColor = UIColor.color(withHex: 0xf0eff0)
private let choosedColor  = UIColor.color(withHex: 0x5fb85e)

class UndocBaseCell: UICollectionViewCell {
    
    fileprivate var timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.color(withHex: 0xc1c1c1)
        label.backgroundColor = UIColor.color(withHex: 0xfafafa)
        label.layer.borderColor = UIColor.color(withHex: 0xf0f0f0).cgColor
        label.layer.borderWidth = 1.0
        return label
    }()
    
    fileprivate lazy var chooseView: UIView = {
        let view = UIView(frame: CGRect(x: kScreenWidth / 2 - 6 - 18, y: 0, w: 18, h: 18))
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.color(withHex: 0xf8f8f8).cgColor
        view.addSubview(self.chooseIndicator)
        return view
    }()
    
    fileprivate lazy var chooseIndicator: UIView = {
        let view = UIView(frame: CGRect(x: 4, y: 4, w: 10, h: 10))
        view.backgroundColor = unChooseColor
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        layer.borderWidth = 0.5
        layer.borderColor = SpiderConfig.Color.Line.cgColor
        
        contentView.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        timeLabel.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 40, height: 20))
            make.bottom.right.equalTo(contentView).offset(-8)
        }
    }
    
    func configureWithInfo(_ info: UndocBoxLayout, editing: Bool = false) {
        timeLabel.text = info.timeTamp
        contentView.bringSubview(toFront: timeLabel)
        
        if editing {
            
            if !chooseView.isDescendant(of: contentView) {
                contentView.addSubview(chooseView)
            }
            
            chooseIndicator.backgroundColor = info.selected ? choosedColor : unChooseColor
            contentView.alpha = info.selected ? 1 : 0.6
        
        } else {
            
            chooseView.removeFromSuperview()
            contentView.alpha = 1
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
