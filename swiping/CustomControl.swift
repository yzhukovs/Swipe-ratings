//
//  CustomControl.swift
//  swiping
//
//  Created by Yvette Zhukovsky on 11/13/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import UIKit

class CustomControl: UIControl {
    var value: Int = 1
    var exValue: Int = 1
    
    private let componentDimension:CGFloat = 40.0
    private let componentCount: Int = 5
    private let componentActiveColor = UIColor.black
    private let componentInactiveColor = UIColor.blue
    
    required init?(coder aCoder: NSCoder){
        super.init(coder: aCoder)
        setup()
        
    }
    
    
    func setup(){
        
        for index in 1...5 {
            let x = CGFloat(index-1) * (componentDimension + 8.0)
            let label = UILabel(frame: CGRect(x: x, y: 0.0 , width: componentDimension, height: componentDimension))
            label.tag = index
            label.font = UIFont.boldSystemFont(ofSize: 32)
            label.text = "✯"
            label.textAlignment = .center
            label.textColor = index == 1 ? componentActiveColor : componentInactiveColor
            
            addSubview(label)
            labels.append(label)
            
        }
        
        
    }
    
    var labels = [UILabel]()
    
    override var intrinsicContentSize: CGSize {
        let componentsWidth = CGFloat(componentCount) * componentDimension
        let componentsSpacing = CGFloat(componentCount + 1) * 8.0
        let width = componentsWidth + componentsSpacing
        return CGSize(width: width, height: componentDimension)
    }
    
    
    
    
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        updateValue(at: touch)
        return true
    }
    
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        guard let touch = touch else {return}
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint) {
            updateValue(at: touch)
            sendActions(for: [.touchUpInside])
        } else {
            sendActions(for: .touchUpOutside)
            
        }
        
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint){
            sendActions(for: [.touchDragInside])
            updateValue(at: touch)
        } else {
            sendActions(for: [.touchDragOutside])
            
        }
        return true
    }
    
    
    override func cancelTracking(with event: UIEvent?) {
        sendActions(for: [.touchCancel])
    }
    
    
    func updateValue(at touch: UITouch){
        for label in labels {
            let touchPoint = touch.location(in: self)
            if exValue >= label.tag {
                label.textColor = componentActiveColor
            } else {
                label.textColor = componentInactiveColor
            }
            
            if label.frame.contains(touchPoint) {
                value = label.tag
                label.textColor = componentActiveColor
                label.performFlare()
                
            }
            //            else {
            //                label.textColor = componentInactiveColor
            //            }
            //
            if value != exValue {
                exValue = value
                sendActions(for: [.valueChanged])
            }
            
        }
    }
    
}




extension UIView {
    // "Flare view" animation sequence
    func performFlare() {
        func flare()   { transform = CGAffineTransform(scaleX: 1.6, y: 1.6) }
        func unflare() { transform = .identity }
        
        UIView.animate(withDuration: 0.3,
                       animations: { flare() },
                       completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
    }
}
