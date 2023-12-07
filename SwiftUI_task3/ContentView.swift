//
//  ContentView.swift
//  SwiftUI_task3
//
//  Created by Evgenii Mikhailov on 05.12.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var offset = 0.0
    @State var scale = CGSize(width: 0, height: 0)
    @State var scale2 = CGSize(width: 1, height: 1)
    @State var opacity1 = 0.0
    @State var opacity2 = 1.0
    let imageSize = 24.0
    let spacing = 0.0
    @State var anchor: UnitPoint = .leading
    @State var isDisabled = false

    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) {
                self.offset = imageSize + spacing
                self.scale = CGSize(width: 1, height: 1)
            }
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) {
                self.scale2 = CGSize(width: 0, height: 0)
                self.opacity2 = 0
                self.opacity1 = 1
            }
            isDisabled = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.offset = 0
                self.scale = CGSize(width: 0, height: 0)
                self.scale2 = CGSize(width: 1, height: 1)
                self.opacity2 = 1
                self.opacity1 = 0
                self.anchor = .leading
                isDisabled = false
            }
        }) {
            HStack(spacing: spacing) {
                Image("play")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(Color.blue)
                    .frame(width: imageSize, height: imageSize)
                    .offset(x: self.offset)
                    .scaleEffect(CGSize(width: 1.0, height: 1.0))
                    .overlay {
                        Image("play")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundStyle(Color.blue)
                            .frame(width: imageSize, height: imageSize)
                            .scaleEffect(scale, anchor: anchor)
                            .opacity(opacity1)
                    }
                Image("play")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(Color.blue)
                    .frame(width: imageSize, height: imageSize)
                    .scaleEffect(scale2, anchor: .trailing)
                    .opacity(opacity2)
            }
        }

        .disabled(isDisabled)
        .buttonStyle(NoTapAnimationStyle())

    }
}

struct NoTapAnimationStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .contentShape(Rectangle())
            .onTapGesture(perform: configuration.trigger)
    }
}

#Preview {
    ContentView()
}
