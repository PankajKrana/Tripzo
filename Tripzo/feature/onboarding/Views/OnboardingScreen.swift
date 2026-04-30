//
//  OnboardingScreen.swift
//  Tripzo
//
//  Created by Pankaj Kumar Rana on 24/04/26.
//

import SwiftUI

struct OnboardingScreen: View {

    @StateObject private var viewModel = OnboardingViewModel()
    @GestureState private var dragOffset: CGFloat = 0
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var onFinished: () -> Void = {}

    private var pageAnimation: Animation {
        reduceMotion
        ? .linear(duration: 0.01)
        : .interactiveSpring(response: 0.36, dampingFraction: 0.88)
    }

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            GeometryReader { proxy in
                let pageWidth = proxy.size.width

                HStack(spacing: 0) {
                    ForEach(Array(viewModel.onboardingData.enumerated()), id: \.element.id) { _, item in
                        OnboardingCard(
                            item: item,
                            currentIndex: $viewModel.currentIndex,
                            totalCount: viewModel.onboardingData.count,
                            onSkip: viewModel.skip,
                            onNext: {
                                viewModel.next(onFinished: onFinished)
                            }
                        )
                        .padding(.horizontal, 16)
                        .frame(width: pageWidth)
                        .padding(.vertical, 14)
                    }
                }
                .offset(x: -CGFloat(viewModel.currentIndex) * pageWidth + dragOffset)
                .animation(pageAnimation, value: viewModel.currentIndex)
                .gesture(
                    DragGesture(minimumDistance: 8)
                        .updating($dragOffset) { value, state, _ in
                            state = value.translation.width
                        }
                        .onEnded { value in
                            withAnimation(pageAnimation) {
                                viewModel.handleDragEnd(value: value, pageWidth: pageWidth)
                            }
                        }
                )
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

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Button("Skip", action: onSkip)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.black.opacity(0.7))
            }
            .padding(.top, 12)

            Spacer(minLength: 12)

            Image(item.image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 12)
                .overlay {
                    
                }

            Spacer(minLength: 28)

            VStack(spacing: 12) {
                Text("\(Text(item.title + " ").foregroundStyle(.black))\(Text(item.highlight).foregroundStyle(.blue))")
                    .font(.system(size: 32, weight: .bold))
                    .multilineTextAlignment(.center)

                Text(item.subtitle)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 8)
            }

            Spacer(minLength: 24)

            HStack(spacing: 8) {
                ForEach(0..<totalCount, id: \.self) { index in
                    Capsule()
                        .fill(index == currentIndex ? Color.blue : Color.gray.opacity(0.3))
                        .frame(width: index == currentIndex ? 24 : 8, height: 8)
                }
            }
            .animation(.easeInOut(duration: 0.2), value: currentIndex)

            Spacer(minLength: 24)

            Button(action: onNext) {
                Text(item.buttonTitle)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .padding(.bottom, 12)
        }
    }
}

#Preview {
    OnboardingScreen()
}
