//
//  BlobShape.swift
//  EcoStep1
//
//  Created by Федор on 18.12.2021.
//

import SwiftUI
import UIKit




struct MyCustomShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: width, y: 0.31959*height))
        path.addCurve(to: CGPoint(x: 0.51667*width, y: 0.99914*height), control1: CGPoint(x: width, y: 0.5943*height), control2: CGPoint(x: 0.80201*width, y: 0.99914*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.50172*height), control1: CGPoint(x: 0.23132*width, y: 0.99914*height), control2: CGPoint(x: 0, y: 0.77644*height))
        path.addCurve(to: CGPoint(x: 0.51667*width, y: 0.0043*height), control1: CGPoint(x: 0.36667*width, y: 0.20533*height), control2: CGPoint(x: 0.23132*width, y: 0.0043*height))
        path.addCurve(to: CGPoint(x: width, y: 0.31959*height), control1: CGPoint(x: 0.80201*width, y: 0.0043*height), control2: CGPoint(x: width, y: 0.04487*height))
        path.closeSubpath()
        return path
    }
}

