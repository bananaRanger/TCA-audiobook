//
//  CaseIterable.swift
//  TCA-audiobook
//
//  Created by Anton Yereshchenko on 26.12.2023.
//

import Foundation

extension CaseIterable where Self: Equatable {
    var previous: Self? {
        let all = Array(Self.allCases)
        if let index = all.firstIndex(of: self) {
            let previous = all.index(before: index)
            return all[previous < all.startIndex ? all.index(before: all.endIndex) : previous]
        }
        return nil
    }
    
    var next: Self? {
        let all = Self.allCases
        if let index = all.firstIndex(of: self) {
            let next = all.index(after: index)
            return all[next == all.endIndex ? all.startIndex : next]
        }
        return nil
    }
}
