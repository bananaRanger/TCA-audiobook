//
//  ImageSegmentedControl.swift
//  TCA-audiobook
//
//  Created by Anton Yereshchenko on 27.12.2023.
//

import SwiftUI

struct ImageSegmentedControl: View {
    @Binding var preselectedIndex: Int
    @State private var shouldMoveToRight = false
    
    var images: [Image]
    let backgorundColor = Color.segmentBackground
    let tintColor = Color.segmentTint
    
    let height: CGFloat = 64
    let borderWidth: CGFloat = 2
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(images.indices, id:\.self) { index in
                let isSelected = preselectedIndex == index
                ZStack {
                    Rectangle()
                        .fill(backgorundColor)
                        .onTapGesture {
                            withAnimation(.easeOut) {
                                shouldMoveToRight = preselectedIndex < index
                                preselectedIndex = index
                            }
                        }
                }
                .overlay(
                    ZStack {
                        if isSelected {
                            Rectangle()
                                .fill(tintColor)
                                .cornerRadius(height / 2)
                                .padding(borderWidth)
                                .transition(.move(edge: shouldMoveToRight ? .leading : .trailing))
                        }
                        
                        images[index]
                            .resizable()
                            .frame(width: 22, height: 22)
                            .foregroundColor(isSelected ? .segmentSelectedItem : .segmentItem)
                    }
                )
            }
        }
        .frame(height: height)
        .frame(width: 130)
        .cornerRadius(height / 2)
        .overlay(
            RoundedRectangle(cornerRadius: height / 2)
                .stroke(.segmentBorder, lineWidth: borderWidth)
        )
    }
}
