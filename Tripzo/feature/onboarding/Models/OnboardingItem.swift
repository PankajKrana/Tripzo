//
//  OnboardingItem.swift
//  Tripzo
//
//  Created by Pankaj Kumar Rana on 30/04/26.
//


import Foundation

struct OnboardingItem: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let highlight: String
    let subtitle: String
    let buttonTitle: String
}