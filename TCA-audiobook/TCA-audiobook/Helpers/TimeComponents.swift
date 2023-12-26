//
//  TimeComponents.swift
//  TCA-audiobook
//
//  Created by Anton Yereshchenko on 25.12.2023.
//

import Foundation

struct TimeComponents: Equatable {
    var hours: Int
    var minutes: Int
    var seconds: Int
    
    init(seconds: TimeInterval) {
        self.hours = (Int(seconds) / 3600)
        self.minutes = (Int(seconds) % 3600) / 60
        self.seconds = (Int(seconds) % 3600) % 60
    }
}

extension TimeComponents: CustomStringConvertible {
    static func pretty(seconds: TimeInterval) -> String {
        return TimeComponents(seconds: seconds).description
    }
    
    var description: String {
        return hours != .zero ?
        "\(String.numberFormat(hours)):\(String.numberFormat(minutes)):\(String.numberFormat(seconds))" :
        "\(String.numberFormat(minutes)):\(String.numberFormat(seconds))"
    }
    
    var pretty: String {
        return description
    }
}

extension String {
    static func numberFormat(_ number: Int) -> Self {
        return String(format: "%02d", number)
    }
    
    static func numberFormat(_ number: Float) -> Self {
        return String(format: "%g", number)
    }
}
