//
//  OnboardingScreen.swift
//  Tripzo
//
//  Created by Pankaj Kumar Rana on 24/04/26.
//

import SwiftUI

struct OnboardingItem: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let highlight: String
    let subtitle: String
    let buttonTitle: String
}

private let onboardingData: [OnboardingItem] = [
    OnboardingItem(
        image: "onbording1",
        title: "Life is short and the world is",
        highlight: "wide",
        subtitle: "At Friends tours and travel, we customize reliable and trustworthy educational tours to destinations all over the world",
        buttonTitle: "Get Started"
    ),
    OnboardingItem(
        image: "onbording2",
        title: "It’s a big world out there go",
        highlight: "explore",
        subtitle: "To get the best of your adventure you just need to leave and go where you like. we are waiting for you",
        buttonTitle: "Next"
    ),
    OnboardingItem(
        image: "onbording3",
        title: "People don’t take trips, trips take",
        highlight: "people",
        subtitle: "To get the best of your adventure you just need to leave and go where you like. we are waiting for you",
        buttonTitle: "Next"
    )
]

struct OnboardingScreen: View {
    @State private var currentIndex = 0
    @GestureState private var dragOffset: CGFloat = 0
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var onFinished: () -> Void = {}

    private var lastIndex: Int {
        onboardingData.count - 1
    }

    private var pageAnimation: Animation {
        reduceMotion ? .linear(duration: 0.01) : .interactiveSpring(response: 0.36, dampingFraction: 0.88)
    }

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            GeometryReader { proxy in
                let pageWidth = proxy.size.width

                HStack(spacing: 0) {
                    ForEach(Array(onboardingData.enumerated()), id: \.element.id) { index, item in
                        OnboardingCard(
                            item: item,
                            currentIndex: $currentIndex,
                            totalCount: onboardingData.count,
                            onSkip: handleSkipTap,
                            onNext: handleNextTap
                        )
                        .padding(.horizontal, 16)
                        .frame(width: pageWidth)
                        .padding(.vertical, 14)
                    }
                }
                .offset(x: -CGFloat(currentIndex) * pageWidth + dragOffset)
                .animation(pageAnimation, value: currentIndex)
                .gesture(
                    DragGesture(minimumDistance: 8, coordinateSpace: .local)
                        .updating($dragOffset) { value, state, _ in
                            let translation = value.translation.width
                            let isAtFirst = currentIndex == 0 && translation > 0
                            let isAtLast = currentIndex == lastIndex && translation < 0
                            state = (isAtFirst || isAtLast) ? translation / 3 : translation
                        }
                        .onEnded { value in
                            handleDragEnd(value: value, pageWidth: pageWidth)
                        }
                )
                .clipped()
            }
        }
    }

    private func handleNextTap() {
        if currentIndex < lastIndex {
            withAnimation(pageAnimation) {
                currentIndex += 1
            }
        } else {
            onFinished()
        }
    }

    private func handleSkipTap() {
        withAnimation(pageAnimation) {
            currentIndex = lastIndex
        }
    }

    private func handleDragEnd(value: DragGesture.Value, pageWidth: CGFloat) {
        let dragDistance = value.translation.width
        let predictedDistance = value.predictedEndTranslation.width
        let effectiveDistance = abs(predictedDistance) > abs(dragDistance) ? predictedDistance : dragDistance
        let threshold = pageWidth * 0.18

        if effectiveDistance < -threshold, currentIndex < lastIndex {
            withAnimation(pageAnimation) {
                currentIndex += 1
            }
        } else if effectiveDistance > threshold, currentIndex > 0 {
            withAnimation(pageAnimation) {
                currentIndex -= 1
            }
        } else {
            withAnimation(pageAnimation) {
                currentIndex = min(max(currentIndex, 0), lastIndex)
            }
        }
    }
}

private struct OnboardingCard: View {
    let item: OnboardingItem
    @Binding var currentIndex: Int
    let totalCount: Int
    let onSkip: () -> Void
    let onNext: () -> Void
    
    private let titleFont: Font = .system(size: 22, weight: .heavy, design: .rounded)

    private var styledTitle: AttributedString {
        var attributed = AttributedString("\(item.title) \(item.highlight)")
        attributed.font = titleFont
        attributed.foregroundColor = Color(red: 0.11, green: 0.12, blue: 0.18)
        if let highlightRange = attributed.range(of: item.highlight) {
            attributed[highlightRange].foregroundColor = Color(red: 0.95, green: 0.47, blue: 0.19)
            attributed[highlightRange].font = titleFont
        }
        return attributed
    }

    var body: some View {
        VStack(spacing: 20) {
            ZStack(alignment: .topTrailing) {
                Image(item.image)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: 460)
                    .clipShape(RoundedRectangle(cornerRadius: 28))

                Button("Skip", action: onSkip)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(.white.opacity(0.9))
                    .padding(.top, 26)
                    .padding(.trailing, 20)
                    .accessibilityLabel("Skip onboarding")
            }

            VStack(spacing: 14) {
                Text(styledTitle)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .lineSpacing(2)
                    .minimumScaleFactor(0.95)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, 26)
                    .padding(.horizontal, 26)

                Capsule()
                    .fill(Color(red: 0.95, green: 0.47, blue: 0.19))
                    .frame(width: 88, height: 5)
                    .padding(.top, 5)

                Text(item.subtitle)
                    .font(.system(size: 12.5, weight: .medium))
                    .foregroundStyle(Color(red: 0.55, green: 0.57, blue: 0.62))
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.horizontal, 34)
                    .padding(.top, 2)

                HStack(spacing: 7) {
                    ForEach(0..<totalCount, id: \.self) { dotIndex in
                        Capsule()
                            .fill(dotIndex == currentIndex ? Color(red: 0.23, green: 0.46, blue: 0.95) : Color(red: 0.78, green: 0.89, blue: 0.98))
                            .frame(width: dotIndex == currentIndex ? 30 : 9, height: 7)
                            .animation(.easeInOut(duration: 0.2), value: currentIndex)
                    }
                }
                .padding(.top, 12)
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Page \(currentIndex + 1) of \(totalCount)")

                Button(action: onNext) {
                    Text(item.buttonTitle)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color(red: 0.23, green: 0.46, blue: 0.95))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .padding(.horizontal, 20)
                .padding(.top, 14)
                .padding(.bottom, 24)
            }
            .frame(maxWidth: .infinity)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
//            .offset(y: 0)
        }
//        .background(.white)
//        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
    }
}

#Preview {
    OnboardingScreen()
}
