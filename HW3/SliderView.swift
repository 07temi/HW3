//
//  SliderView.swift
//  HW3
//
//  Created by Артем Черненко on 26.02.2022.
//

//Не понял как функцию computeScore разместить. В итоге в двух местах, потому что результат не получается вернуть в contentView. Хотя считаю что подсчету результата не место в слайдере, а с другой стороны ну и пусть считает сразу при движении бегунка, тем более прозрачность моментально регулируется. Короче запутался окончательно((  

import SwiftUI

struct SliderView: UIViewRepresentable {
    
    @Binding var currentValue: Float
    @Binding var targetValue: Int
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        
        slider.value = 0
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.addTarget(context.coordinator,
                         action: #selector(Coordinator.didChangeDone),
                         for: .valueChanged
        )
        
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        let score = computeScore(targetValue, currentValue)
        uiView.value = currentValue
        uiView.thumbTintColor = UIColor(red: 1,
                                        green: 0,
                                        blue: 0,
                                        alpha: CGFloat(Double(score) / 100))
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(value: $currentValue)
    }
}

extension SliderView {
   
    private func computeScore(_ target: Int, _ current: Float) -> Int {
        let difference = abs(target - lround(Double(current)))
        return 100 - difference
    }
    
    class Coordinator: NSObject {
        @Binding var value: Float
        
        init(value: Binding<Float>) {
            self._value = value
        }

        @objc func didChangeDone(_ sender: UISlider) {
            value = sender.value
        }
    }
}
