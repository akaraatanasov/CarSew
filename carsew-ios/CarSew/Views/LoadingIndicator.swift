//
//  LoadingIndicator.swift
//  CarSew
//
//  Created by Alexander Karaatanasov on 27.05.19.
//  Copyright © 2019 Alexander Karaatanasov. All rights reserved.
//

import UIKit

class LoadingIndicator: UIView {
    
    // MARK: - Constants
    
    private let width: CGFloat = 50.0
    private let height: CGFloat = 50.0
    
    // MARK: - Vars
    
    private var parentView: UIView!
    
    // MARK: - Inits
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        let indicatorFrame = CGRect(x: frame.midX - (width / 2),
                                    y: frame.midY - (height / 2),
                                    width: width, height: height)
        
        super.init(frame: indicatorFrame)
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let circleRadius = width / 2
        let circlePath = UIBezierPath(arcCenter: center,
                                      radius: circleRadius,
                                      startAngle: CGFloat.pi,
                                      endAngle: CGFloat.pi / 2,
                                      clockwise: true)
        
        let semiCircleLayer = CAShapeLayer()
        semiCircleLayer.path = circlePath.cgPath
        semiCircleLayer.lineWidth = 8
        semiCircleLayer.strokeColor = UIColor.lightGray.cgColor
        semiCircleLayer.fillColor = UIColor.clear.cgColor
        
        layer.addSublayer(semiCircleLayer)
    }
    
    // MARK: - Public
    
    func show(from view: UIView) {
        parentView = view
        
        parentView.addSubview(self)
        rotate(view: self)
        
        addDarkBackground(on: parentView)
    }
    
    func hide() {
        removeFromSuperview()
        
        removeDarkBackground(from: parentView)
    }
    
    // MARK: - Private
    
    private func addDarkBackground(on view: UIView) {
        view.isUserInteractionEnabled = false
        
        view.alpha = 0.5
    }
    
    private func removeDarkBackground(from view: UIView) {
        view.isUserInteractionEnabled = true
        view.alpha = 1.0
    }
    
    private func rotate(view: UIView, rotationDuration: Double = 1.0, animationDuration: Double = 300.0) {
        let duration = animationDuration * 2
        
        recursiveRotation(targetView: view, rotationDuration: rotationDuration, duration: duration)
    }
    
    private func recursiveRotation(targetView: UIView, rotationDuration: Double = 1.0, duration: Double = 300.0) {
        let animationDuration = duration - 1
        
        UIView.animate(withDuration: rotationDuration / 2, delay: 0.0, options: .curveLinear, animations: {
            targetView.transform = targetView.transform.rotated(by: CGFloat.pi)
        }) { finished in
            if animationDuration != 0 {
                self.recursiveRotation(targetView: targetView, rotationDuration: rotationDuration, duration: animationDuration)
            } else {
//                print("Finished rotating!")
            }
        }
    }
    
}
