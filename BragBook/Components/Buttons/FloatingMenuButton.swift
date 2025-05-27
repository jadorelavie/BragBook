//
//  FloatingMenuButton.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/17/25.
//

import SwiftUI

struct FloatingMenuButton: View {
    @Binding var selectedType: FeedItemType?
    @State private var isExpanded = false

    var body: some View {
        ZStack {
            if isExpanded {
                ForEach(FeedItemType.allCases.indices, id: \.self) { index in
                    let type = FeedItemType.allCases[index]
                    let angle = Angle(degrees: Double(index) * (360.0 / Double(FeedItemType.allCases.count)))
                    Button(action: {
                        selectedType = type
                        isExpanded = false
                    }) {
                        Image(systemName: type.iconName)
                            .foregroundColor(.white)
                            .padding()
                            .background(Circle().fill(Color.accentColor))
                    }
                    .offset(x: CGFloat(cos(angle.radians) * 80), y: CGFloat(sin(angle.radians) * 80))
                    .transition(.scale)
                }
            }

            Button(action: {
                selectedType = .entry
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .padding()
                    .background(Circle().fill(Color("PeacockGreen")))
                    .shadow(radius: 4)
            }
            .simultaneousGesture(LongPressGesture().onEnded { _ in
                withAnimation {
                    isExpanded.toggle()
                }
            })
            .accessibilityLabel("Add new entry")
            .accessibilityHint("Tap to add journal, long-press for more options")
        }
    }
}
