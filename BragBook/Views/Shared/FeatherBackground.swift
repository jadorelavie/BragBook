//
//  FeatherBackground 2.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 4/27/25.
//


//
//  FeatherBackground.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 4/27/25.
//

//  FeatherBackground.swift
//  BragBook
//
//  A reusable background that displays a full‑screen feather image with an optional
//  whimsical shimmer (“breathing”‑scale) effect.  Wrap any content in
//  `FeatherBackground { … }` to automatically layer it above the feather.
//
//  Created for Taryn by ChatGPT – April 2025
//
//  ----------------------------------------------------------------------
//  Usage Example
//  ----------------------------------------------------------------------
//  FeatherBackground {
//      NavigationSplitView {
//          ScrollView {
//              LazyVStack { /* cards */ }
//          }
//      }
//  }
//  ----------------------------------------------------------------------
//  Tweakable Constants
//  ─ shimmerDuration  : Seconds for the shimmer to cross the screen.
//  ─ shimmerOpacity   : Max opacity of the shimmer layer.
//  ─ featherOpacity   : Base opacity for light‑mode (dark mode will auto‑scale).
//  ----------------------------------------------------------------------

import SwiftUI

struct FeatherBackground<Content: View>: View {
    // MARK: ‑ Injected Content
    @ViewBuilder var content: () -> Content

    // MARK: ‑ Animation & Appearance Tunables
    private let shimmerDuration: Double  = 8      // seconds for one pass
    private let shimmerOpacity:  Double  = 0.30   // peak opacity of shimmer
    private let featherOpacity:  Double  = 0.30   // light‑mode base opacity
    private let breathingScale: CGFloat = 1.03    // subtle “breathing” scale
    private let breathingPeriod: Double = 12      // seconds per inhale/exhale

    // MARK: ‑ Environment
    @Environment(\.colorScheme) private var colorScheme

    // MARK: ‑ Body
    var body: some View {
        // Render user content normally, then apply feather and shimmer behind it
        content()
        
            .background(
                GeometryReader { proxy in
                    ZStack {
                        featherImage(size: proxy.size)
                        shimmer(size: proxy.size)
                    }
                    .ignoresSafeArea() // Ensure background covers full screen
                }
            )
    }

    // MARK: ‑ Private Helpers
    /// Background feather with adaptive opacity & breathing scale animation.
    @ViewBuilder
    private func featherImage(size: CGSize) -> some View {
        let effectiveOpacity = colorScheme == .dark ? featherOpacity * 0.5 : featherOpacity
        
        Image("featherBackground")
            .resizable()
            .scaledToFill()
            .frame(width: size.width * 1.2, height: size.height * 1.2) // Slightly oversize
            .offset(x: size.width * -0.1, y: size.height * -0.05) // Artistically nudge left and up
            
            .opacity(effectiveOpacity)
            .scaleEffect(breathingScaleEffect)
            .animation(.easeInOut(duration: breathingPeriod).repeatForever(autoreverses: true),
                       value: breathingScaleEffect)
            .rotationEffect(.degrees(featherRotation))
            .animation(.easeInOut(duration: 10).repeatForever(autoreverses: true),
                       value: featherRotation)
            .onAppear {
                featherRotation = 2 // animate tilt back and forth
            }
    }

    /// Animated shimmer overlay – a moving linear gradient masked over the feather.
    @ViewBuilder
    private func shimmer(size: CGSize) -> some View {
        TimelineView(.animation) { timeline in
            let progress = (timeline.date.timeIntervalSinceReferenceDate.truncatingRemainder(dividingBy: shimmerDuration)) / shimmerDuration
            let xOffset = size.width * CGFloat(progress)

            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: .clear, location: 0.0),
                    .init(color: Color.white.opacity(shimmerOpacity), location: 0.45),
                    .init(color: .clear, location: 0.9)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(width: size.width * 1.5, height: size.height * 1.5)
            .offset(x: xOffset - size.width * 0.75, y: 0)
            .rotationEffect(.degrees(shimmerRotation))
            .animation(.linear(duration: shimmerDuration * 2).repeatForever(autoreverses: false),
                       value: shimmerRotation)
            .onAppear {
                shimmerRotation = 360 // continuous spin
            }
            .blendMode(.screen)
            .allowsHitTesting(false)
        }
    }

    /// Convenience computed var for breathing scale (toggles between 1.0 and breathingScale).
    private var breathingScaleEffect: CGFloat {
        breathingScaleEnabled ? breathingScale : 1.0
    }

    /// Toggle breathing via this flag if you don’t want the effect.
    private let breathingScaleEnabled: Bool = true
    @State private var featherRotation: Double = -2 // initial tilt angle for sway
    @State private var shimmerRotation: Double = 0 // rotation angle for shimmer sparkle
}

// MARK: ‑ Preview
struct FeatherBackground_Previews: PreviewProvider {
    static var previews: some View {
        FeatherBackground {
            VStack(spacing: 20) {
                ForEach(0..<5) { idx in
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(uiColor: .secondarySystemBackground))
                        .frame(height: 80)
                        .overlay(Text("Card \(idx + 1)").font(.headline))
                        .shadow(radius: 2)
                        .padding(.horizontal)
                }
            }
        }
        .previewDisplayName("Feather Background")
    }
}
