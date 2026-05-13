//
//  AnimationModifiers.swift
//  Tripzo
//

import SwiftUI

// MARK: - Scale & Opacity Animations
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

// MARK: - Shimmer Loading Animation
struct ShimmerModifier: ViewModifier {
    @State private var isAnimating = false

    func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: [
                        .clear,
                        .white.opacity(0.3),
                        .clear
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .offset(x: isAnimating ? 400 : -400)
                .animation(
                    Animation.linear(duration: 1.5).repeatForever(autoreverses: false),
                    value: isAnimating
                )
            )
            .onAppear { isAnimating = true }
    }
}

// MARK: - Pulse Animation
struct PulseModifier: ViewModifier {
    @State private var isAnimating = false

    func body(content: Content) -> some View {
        content
            .scaleEffect(isAnimating ? 1.05 : 1.0)
            .opacity(isAnimating ? 0.8 : 1.0)
            .animation(
                Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true),
                value: isAnimating
            )
            .onAppear { isAnimating = true }
    }
}

// MARK: - Bounce Animation
struct BounceModifier: ViewModifier {
    @State private var isAnimating = false

    func body(content: Content) -> some View {
        content
            .offset(y: isAnimating ? -10 : 0)
            .animation(
                Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true),
                value: isAnimating
            )
            .onAppear { isAnimating = true }
    }
}

// MARK: - Rotation Animation
struct RotationModifier: ViewModifier {
    @State private var isAnimating = false

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(isAnimating ? 360 : 0))
            .animation(
                Animation.linear(duration: 2.0).repeatForever(autoreverses: false),
                value: isAnimating
            )
            .onAppear { isAnimating = true }
    }
}

// MARK: - Slide Animation
struct SlideAnimationModifier: ViewModifier {
    var duration: Double = 0.5
    @State private var isShowing = false

    func body(content: Content) -> some View {
        content
            .offset(y: isShowing ? 0 : 20)
            .opacity(isShowing ? 1 : 0)
            .animation(.easeOut(duration: duration), value: isShowing)
            .onAppear { isShowing = true }
    }
}

// MARK: - Glass Morphism Effect
struct GlassmorphicModifier: ViewModifier {
    var cornerRadius: CGFloat = 12

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.white.opacity(0.1))
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(.ultraThinMaterial)
                    )
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

// MARK: - Elevation Shadow
struct ElevationModifier: ViewModifier {
    enum Elevation {
        case small
        case medium
        case large
        case xl

        var shadow: (radius: CGFloat, y: CGFloat) {
            switch self {
            case .small: (4, 2)
            case .medium: (8, 4)
            case .large: (12, 8)
            case .xl: (16, 12)
            }
        }
    }

    let elevation: Elevation

    func body(content: Content) -> some View {
        content
            .shadow(
                color: .black.opacity(0.1),
                radius: elevation.shadow.radius,
                y: elevation.shadow.y
            )
    }
}

// MARK: - Extension Methods
extension View {
    func shimmer() -> some View {
        modifier(ShimmerModifier())
    }

    func pulse() -> some View {
        modifier(PulseModifier())
    }

    func bounce() -> some View {
        modifier(BounceModifier())
    }

    func rotating() -> some View {
        modifier(RotationModifier())
    }

    func slideAnimation(duration: Double = 0.5) -> some View {
        modifier(SlideAnimationModifier(duration: duration))
    }

    func glassmorphic(cornerRadius: CGFloat = 12) -> some View {
        modifier(GlassmorphicModifier(cornerRadius: cornerRadius))
    }

    func scaleButtonEffect() -> some View {
        buttonStyle(ScaleButtonStyle())
    }

    func elevation(_ level: ElevationModifier.Elevation = .medium) -> some View {
        modifier(ElevationModifier(elevation: level))
    }
}
