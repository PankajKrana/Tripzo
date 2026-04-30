//
//  OnboardingViewModel.swift
//  Tripzo
//
//  Created by Pankaj Kumar Rana on 30/04/26.
//


import SwiftUI
import Combine

final class OnboardingViewModel: ObservableObject {

    // MARK: - Data
    @Published var currentIndex: Int = 0

    let onboardingData: [OnboardingItem] = [
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

    var lastIndex: Int {
        onboardingData.count - 1
    }

    // MARK: - Actions

    func next(onFinished: () -> Void) {
        if currentIndex < lastIndex {
            currentIndex += 1
        } else {
            onFinished()
        }
    }

    func skip() {
        currentIndex = lastIndex
    }

    func handleDragEnd(value: DragGesture.Value, pageWidth: CGFloat) {
        let dragDistance = value.translation.width
        let predictedDistance = value.predictedEndTranslation.width
        let effectiveDistance = abs(predictedDistance) > abs(dragDistance) ? predictedDistance : dragDistance
        let threshold = pageWidth * 0.18

        if effectiveDistance < -threshold, currentIndex < lastIndex {
            currentIndex += 1
        } else if effectiveDistance > threshold, currentIndex > 0 {
            currentIndex -= 1
        }
    }
}
