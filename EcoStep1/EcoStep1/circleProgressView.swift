//
//  circleProgressView.swift
//  EcoStep1
//
//  Created by Федор on 27.12.2021.
//

import UIKit

class CircleProgressView: UIView{
    var labelValue = 0
    override func awakeFromNib() {
            super.awakeFromNib()
            setupView()
            label.text = "0 kg"
        }
    
    
        //MARK: Public
    
        public var lineWidth:CGFloat = 50 {
            didSet{
                foregroundLayer.lineWidth = lineWidth
   
                backgroundLayer.lineWidth = lineWidth - (0.20 * lineWidth)
            }
        }
    
        public var labelSize: CGFloat = 20 {
            didSet {
                label.font = UIFont.systemFont(ofSize: labelSize)
                label.sizeToFit()
                configLabel()
            }
        }
    
        public var safePercent: Int = 100 {
            didSet{
                setForegroundLayerColorForSafePercent()
            }
        }
    
        public func setProgress(to progressConstant: Double, withAnimation: Bool) {
    
            var progress: Double {
                get {
                     return progressConstant
                }
            }
    
            foregroundLayer.strokeEnd = CGFloat(progress)
    
            if withAnimation {
                let animation = CABasicAnimation(keyPath: "strokeEnd")
                animation.fromValue = 0
                animation.toValue = progress
                animation.duration = 2
                foregroundLayer.add(animation, forKey: "foregroundAnimation")
    
            }
    
            var currentTime:Double = 0
            let timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { (timer) in
                if currentTime >= 2{
                    timer.invalidate()
                } else {
                    currentTime += 0.05
                    let percent = currentTime
                    self.label.text = "\(Int(progress * percent)) kg"
                    self.labelValue = Int(progress*percent)
                    self.setForegroundLayerColorForSafePercent()
                    self.configLabel()
                }
            }
            timer.fire()
    
        }
    
    
    
    
        //MARK: Private
        private var label = UILabel()
        private let foregroundLayer = CAShapeLayer()
        private let backgroundLayer = CAShapeLayer()
        private var radius: CGFloat {
            get{
                if self.frame.width < self.frame.height { return (self.frame.width - lineWidth)/2 }
                else { return (self.frame.height - lineWidth)/2 }
            }
        }
    
        private var pathCenter: CGPoint{ get{ return self.convert(self.center, from:self.superview) } }
        private func makeBar(){
            self.layer.sublayers = nil
            drawBackgroundLayer()
            drawForegroundLayerRight()
        }
    
        private func drawBackgroundLayer(){
            let path = UIBezierPath(arcCenter: pathCenter, radius: self.radius, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
            self.backgroundLayer.path = path.cgPath
            self.backgroundLayer.strokeColor = UIColor.lightGray.cgColor
            self.backgroundLayer.lineWidth = lineWidth - (lineWidth * 20/100)
            self.backgroundLayer.fillColor = UIColor.clear.cgColor
            self.layer.addSublayer(backgroundLayer)
    
        }
    
        private func drawForegroundLayerRight(){
    
            let startAngle = (CGFloat.pi/2)
            let endAngleLeft = (2 * CGFloat.pi + startAngle)
            
    
            let path = UIBezierPath(arcCenter: pathCenter, radius: self.radius, startAngle: startAngle, endAngle: endAngleLeft, clockwise: true)
            
            
            foregroundLayer.lineCap = CAShapeLayerLineCap.round
            foregroundLayer.path = path.cgPath
            foregroundLayer.lineWidth = lineWidth
            foregroundLayer.fillColor = UIColor.clear.cgColor
            foregroundLayer.strokeColor = UIColor.red.cgColor
            foregroundLayer.strokeEnd = 0
    
            self.layer.addSublayer(foregroundLayer)
    
        }
        

    
        private func makeLabel(withText text: String) -> UILabel {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            label.text = text
            label.font = UIFont.systemFont(ofSize: labelSize)
            label.sizeToFit()
            label.center = pathCenter
            return label
        }
    
        private func configLabel(){
            label.sizeToFit()
            label.center = pathCenter
        }
    
        private func setForegroundLayerColorForSafePercent(){
            if labelValue <= 10 {
                self.foregroundLayer.strokeColor = UIColor.green.cgColor
            }
            else if labelValue > 10 && labelValue < 20 {
                self.foregroundLayer.strokeColor = UIColor.yellow.cgColor
            }
            else if labelValue > 20 && labelValue < 25{
                self.foregroundLayer.strokeColor = UIColor.orange.cgColor
            }
            else{
                self.foregroundLayer.strokeColor = UIColor.orange.cgColor
                
            }
        }
    
        private func setupView() {
            makeBar()
            self.addSubview(label)
        }
    
    
    
        //Layout Sublayers
        private var layoutDone = false
        override func layoutSublayers(of layer: CALayer) {
            if !layoutDone {
                let tempText = label.text
                setupView()
                label.text = tempText
                layoutDone = true
            }
        }
    
}
