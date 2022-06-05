//
//  DateExtension.swift
//  Base Station
//
//  Created by Ruslan Duda on 07.01.2022.
//

import Foundation

extension Date {
    static var formatter = DateFormatter()
    func toString() -> String {
        let formatter = Date.formatter
        formatter.dateFormat = "dd.mm.yyyy"
        return formatter.string(from: self)
    }
}
