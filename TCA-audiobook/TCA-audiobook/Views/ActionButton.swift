//
//  ActionButton.swift
//  TCA-audiobook
//
//  Created by Anton Yereshchenko on 24.12.2023.
//

import SwiftUI

struct ActionButton: View {
    
    var systemName: String
    var onDidClick: (() -> Void)?
    
    var body: some View {
        contentView
    }
}

private extension ActionButton {
    var contentView: some View {
        Button {
            onDidClick?()
        } label: {
            Image(systemName: systemName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color.brandActionTint)
        }
    }
}
