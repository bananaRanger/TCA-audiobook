//
//  SwiftUISlider.swift
//  TCA-audiobook
//
//  Created by Anton Yereshchenko on 24.12.2023.
//

import SwiftUI

struct SwiftUISlider: UIViewRepresentable {
    
    @Binding var value: Double
        
    var thumbDiameter: CGFloat = 14
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        slider.value = Float(value)
        
        let thumbView = UIView()
        thumbView.backgroundColor = slider.tintColor
        thumbView.layer.masksToBounds = false
        thumbView.frame = CGRect(x: 0, y: thumbDiameter / 2, width: thumbDiameter, height: thumbDiameter)
        thumbView.layer.cornerRadius = CGFloat(thumbDiameter / 2)

        let imageRenderer = UIGraphicsImageRenderer(bounds: thumbView.bounds)
        let thumbImage = imageRenderer.image { rendererContext in
            thumbView.layer.render(in: rendererContext.cgContext)
        }
        slider.setThumbImage(thumbImage, for: .normal)
        
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged(_:)),
            for: .valueChanged
        )
        
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(self.value)
    }
    
    func makeCoordinator() -> SwiftUISlider.Coordinator {
        Coordinator(value: $value)
    }
}

extension SwiftUISlider {
    final class Coordinator: NSObject {
        var value: Binding<Double>
        
        init(value: Binding<Double>) {
            self.value = value
        }
        
        @objc func valueChanged(_ sender: UISlider) {
            self.value.wrappedValue = Double(sender.value)
        }
    }
}

#Preview {
    SwiftUISlider(
        value: .constant(0.5)
    )
}
