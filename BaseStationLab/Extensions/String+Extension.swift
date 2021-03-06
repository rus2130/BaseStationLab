//
//  StringExtension.swift
//  Base Station
//
//  Created by Ruslan Duda on 07.01.2022.
//

import Foundation

extension String {
    func toDate() -> Date {
        let formatter = Date.formatter
        formatter.dateFormat = "dd.mm.yyyy"
        return formatter.date(from: self) ?? Date() 
    }
}

extension RangeReplaceableCollection where Self: StringProtocol {
    var digits: Self {
        return filter(("0"..."9").contains)
    }
}
