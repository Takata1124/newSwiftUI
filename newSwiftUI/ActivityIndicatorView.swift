//
//  ActivityIndicatorView.swift
//  newSwiftUI
//
//  Created by t032fj on 2024/08/07.
//

import SwiftUI

struct ActivityIndicatorView: View {
    
    @State var currentDegrees = 0.0
    
    let colorGradient = LinearGradient(gradient: Gradient(colors: [
        Color.red,
        Color.red.opacity(0.75),
        Color.red.opacity(0.5),
        Color.red.opacity(0.2),
        .clear]),startPoint: .leading, endPoint: .trailing)
    
    var body: some View {
        VStack {
            Circle()
                .trim(from: 0.0, to: 0.85)
                .stroke(colorGradient, style: StrokeStyle(lineWidth: 5))
                .frame(width: 40, height: 40)
                .rotationEffect(Angle(degrees: currentDegrees))
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
                        withAnimation {
                            self.currentDegrees += 10
                        }
                    }
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray.opacity(0.5))
    }
}

#Preview {
    ActivityIndicatorView()
}
