//
//  AddLocationView.swift
//  SunriseSunset
//
//  Created by Kolos on 1/27/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import UIKit

class AddLocationView: UIView {

    
    override func draw(_ rect: CGRect) {
        
        Palette.palette.tint.setFill()
        let path = UIBezierPath(ovalIn: rect)
        path.lineWidth = CGFloat(5)
        path.fill()
        path.removeAllPoints()
        Palette.palette.background.setStroke()
        path.move(to: CGPoint(x: rect.width / 5, y: rect.height / 2))
        path.addLine(to: CGPoint(x: rect.width - rect.width / 5, y: rect.height / 2))
        path.move(to: CGPoint(x: rect.width / 2, y: rect.height / 5))
        path.addLine(to: CGPoint(x: rect.width / 2, y: rect.height - rect.height / 5))
        path.stroke()
    }
 

}
