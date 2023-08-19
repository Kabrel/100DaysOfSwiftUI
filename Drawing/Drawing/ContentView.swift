//
//  ContentView.swift
//  Drawing
//
//  Created by Константин Шутов on 17.08.2023.
//

import SwiftUI

struct Arrows: Shape {
    var thickness = 1.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        
        return path
    }
}

struct ColorCyclingRectangle: View {
    @State private var colorOffset = 0
    
    var body: some View {
        Rectangle()
            .fill(LinearGradient(gradient: Gradient(colors: [.purple, .cyan]), startPoint: .leading, endPoint: .trailing))
            .frame(width: 200, height: 200)
            .offset(x: CGFloat(colorOffset))
            .animation(Animation.linear(duration: 2).repeatForever())
            .onAppear {
                self.colorOffset = Int.random(in: 0...200)
            }
    }
}

struct ContentView: View {
    @State private var thickness = 1.0
    
    var animatableData: Double {
        get { thickness}
        set { thickness = newValue}
    }
    
    var body: some View {
        VStack {
            Arrows(thickness: thickness)
                .stroke(.red, style: StrokeStyle(lineWidth: animatableData, lineCap: .round, lineJoin: .round))
                .frame(width: 300, height: 300)
                .onTapGesture {
                    withAnimation {
                        thickness = Double.random(in: 1...40)
                    }
                }
            ColorCyclingRectangle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
