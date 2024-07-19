//
//  ScreenTapHandler.swift
//  TCA-audiobook
//
//  Created by Anton Yereshchenko on 24.12.2023.
//

import UIKit.UIScreen

struct ScreenTapHandler {
    static func handleTap(
        in point: CGPoint,
        with screenBounds: CGRect = UIScreen.main.bounds,
        onTap: ((Location) -> Void)? = nil
    ) {
        if point.x <= screenBounds.width / 2 &&
            point.y <= screenBounds.height / 2 {
            onTap?(.topLeft)
        }
        else
        if point.x >= screenBounds.width / 2 &&
            point.y <= screenBounds.height / 2 {
            onTap?(.topRight)
        }
        else
        if point.x >= screenBounds.width / 2 &&
            point.y >= screenBounds.height / 2 {
            onTap?(.bottomRight)
        }
        else
        if point.x <= screenBounds.width / 2 &&
            point.y >= screenBounds.height / 2 {
            onTap?(.bottomLeft)
        }
    }
}

extension ScreenTapHandler {
    enum Location {
        case topLeft
        case topRight
        case bottomRight
        case bottomLeft
    }
}
