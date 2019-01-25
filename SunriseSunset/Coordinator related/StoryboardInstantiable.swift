//
//  StoryboardInstantiable.swift
//  SunriseSunset
//
//  Created by Kolos on 1/25/19.
//  Copyright © 2019 Kolos. All rights reserved.
//

import Foundation
import UIKit

protocol StoryboardInstantiable: NSObjectProtocol {
    static func instantiateViewController<T>(_ bundle: Bundle?) -> T
    static var defaultFileName: String { get }
}

extension StoryboardInstantiable where Self: UIViewController {
    
    static var defaultFileName: String {
        // swiftlint:disable:next force_unwrapping
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }
    
    static func instantiateViewController<T>(_ bundle: Bundle? = nil) -> T {
        let fileName = defaultFileName
        let sb = UIStoryboard(name: fileName, bundle: bundle)
        // swiftlint:disable:next force_cast
        return sb.instantiateInitialViewController() as! T
    }
}
