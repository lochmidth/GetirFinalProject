//
//  UIColor+Ext.swift
//  GetirFinalProject
//
//  Created by Alphan Ogün on 9.04.2024.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
    
    static let getirPurple = rgb(red: 93, green: 62, blue: 188)
    static let getirGray = rgb(red: 242, green: 240, blue: 250)
    
    
}
