//
//  UIAplicationExtensions.swift
//  Base Station
//
//  Created by Ruslan Duda on 12.12.2021.
//

import Foundation
import UIKit
import SwiftUI

extension UIApplication {
    static var statusBarHeight: CGFloat {
        let window = shared.windows.filter { $0.isKeyWindow }.first
        return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
}
struct ScreenUtils {
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    static var statusBarHeight: CGFloat {
        return UIApplication.statusBarHeight
    }
}
