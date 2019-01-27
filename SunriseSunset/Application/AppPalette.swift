//
//  AppPalette.swift
//  SunriseSunset
//
//  Created by Kolos on 1/27/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import Foundation
import UIKit

enum HexColor: String {
    case tint
    case correct
    case failure
    case background
    case contrast
    case blanc
}

final class Palette {
    
    static let paletteArray = ["#f18f01", "#048ba8", "#2e4057", "#99c24d", "#2f2d2e", "#8e98a7"]
    
    static let palette: Palette = {
        return Palette(palettArray: paletteArray)
    }()
    
    let tint: UIColor
    let correct: UIColor
    let failure: UIColor
    let background: UIColor
    let contrast: UIColor
    let blanc: UIColor
    let textMain: UIColor
    
    init(palettArray: [String]) {
        tint = UIColor(hexString: palettArray[0])
        correct = UIColor(hexString: palettArray[1])
        failure = UIColor(hexString: palettArray[2])
        background = UIColor(hexString: palettArray[3])
        contrast = UIColor(hexString: palettArray[4])
        blanc = UIColor.white
        textMain = contrast
    }
    
}
