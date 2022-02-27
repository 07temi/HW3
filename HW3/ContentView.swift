//
//  ContentView.swift
//  HW3
//
//  Created by Артем Черненко on 26.02.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var currentValue: Float = 0
    @State private var targetValue = Int.random(in: 0...100)
    @State private var showScore = false
    
    var body: some View {
        VStack {
            HStack {
            Text("0")
            SliderView(currentValue: $currentValue, targetValue: $targetValue)
                .alert("Your score", isPresented: $showScore) {
                    Button("Ok", action: {} )
                } message: {
                    Text("\(computeScore())")
                }
            Text("100")
            }
            .padding()
            
            Text("Подвиньте слайдер как можно ближе к: \(targetValue)")
                .font(.system(size: 12))
                .padding()
            Button("Проверить") {
                showScore.toggle()
            }
            .padding()
            
            Button("Начать заново") {
                targetValue = Int.random(in: 0...100)
            }
        }
    }
}

extension ContentView {
    func computeScore() -> Int {
        let difference = abs(targetValue - lround(Double(currentValue)))
        return 100 - difference
    }
}
