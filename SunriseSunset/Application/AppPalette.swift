//
//  AppPalette.swift
//  SunriseSunset
//
//  Created by Kolos on 1/27/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import Foundation
import UIKit

final class Palette {
    
    private static let paletteArray = ["#a7a5c6", "#8797b2", "#6d8a96", "#5d707f", "#66ced6", "#8e98a7"]
    
    static let palette: Palette = {
        return Palette(palettArray: paletteArray)
    }()
    
    let tint: UIColor
    let background: UIColor
    let contrast: UIColor
    let blanc: UIColor
    let textMain: UIColor
    
    init(palettArray: [String]) {
        contrast = UIColor(hexString: palettArray[5])
        tint = UIColor.white
        background = UIColor(hexString: palettArray[3])
        textMain = UIColor(hexString: palettArray[4])
        blanc = UIColor(hexString: palettArray[2])
        
    }
    
}
