//
//  UI + extensions.swift
//  SunriseSunset
//
//  Created by Kolos on 1/25/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable
    var radius: Float {
        set {
            layer.cornerRadius = CGFloat(newValue)
            layer.masksToBounds = true
        }
        get {
            return Float(layer.cornerRadius)
        }
    }
}


extension UINavigationController {
    open override var shouldAutorotate: Bool {
        return false
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
}
