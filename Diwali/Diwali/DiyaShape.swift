//
//  DiyaShape.swift
//  Diwali
//
//  Created by Brinda Davda on 22/10/24.
//

import SwiftUI

struct DiyaShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Bowl (diya base)
        path.move(to: CGPoint(x: rect.minX, y: rect.midY)) // Starting point
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY), // End point
                          control: CGPoint(x: rect.midX, y: rect.maxY)) // Control point to make a bowl curve
        
        // Connecting back the bottom of the diya
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))

        return path
    }
}

struct FlameShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Flame shape (teardrop or flame-like)
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY)) // Bottom tip of the flame
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.midY),
                          control: CGPoint(x: rect.midX - rect.width * 0.2, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.maxY),
                          control: CGPoint(x: rect.midX + rect.width * 0.2, y: rect.minY))

        return path
    }
}

struct FlickeringFlameView: View {
    @State private var flicker = false
    
    var body: some View {
        FlameShape()
            .fill(LinearGradient(gradient: Gradient(colors: [.yellow, .red]),
                                 startPoint: .top,
                                 endPoint: .bottom))
            .frame(width: 50, height: 50)
            .offset(y: -25)
            .opacity(flicker ? 1.0 : 0.7) // Flickering by changing opacity
            .scaleEffect(flicker ? 1.0 : 0.95) // Slight change in size
            .animation(Animation.easeInOut(duration: 0.3).repeatForever(), value: flicker)
            .shadow(color: .yellow, radius: 20)
            .onAppear {
                flicker.toggle() // Start the flickering effect
            }
    }
}

struct DiyaView: View {
    var body: some View {
        ZStack {
            // Diya base
            DiyaShape()
                .fill(Color.random())
                .frame(width: 50, height: 50)
                .shadow(color: .orange, radius: 10)
            
            // Flickering flame on top of the diya
            FlickeringFlameView()
        }
    }
}

struct DiyaShape_Previews: PreviewProvider {
    static var previews: some View {
      DiyaView()
    }
}
